# ZenID iOS SDK

This documentation targets ZenID SDK 5.0+. Your primary entry point is ZenIDManager, which configures the SDK, provides verifiers, and manages the shared ZenID view.

All public methods and types are documented here and in code. This document does not cover the ZenID backend API; consult the server/API documentation separately.

Tip: Code is worth a thousand words. See our sample app:
https://github.com/ZenIDTeam/ZenID-ios/ZenIDSample


## iOS version compatibility

We suggest targeting iOS 18.0. Technically this SDK should build for versions 15.0 and above.

Note that old out-of-support devices will likely lack sufficient processing capacity and memory to run the SDK with adequate performance.


## Integration

### Manual linking

- Download ZenID.xcframework. All required models are now bundled inside the framework.
- If you will use MS Liveness, also include AzureAIVisionFaceUI.xcframework (~140MB additional).
- Add the frameworks to your Xcode target with "Embed & Sign".

Required Info.plist keys:
- NSCameraUsageDescription (camera access)
- If using NFC (when requested): NFCReaderUsageDescription and the appropriate NFC entitlement (com.apple.developer.nfc.readersession.formats)
- If using MS Liveness: network access is required to call Microsoft endpoints

### Swift Package Manager (SPM)

- Add the package from `https://github.com/ZenIDTeam/ZenID-ios`
- Choose package product:
  - **ZenID** - Lite version (recommended if you don't need MS Liveness)
  - **ZenIDFull** - Full version with MS Liveness support (includes AzureAIVisionFaceUI automatically, adds ~140MB)
- All required models are bundled inside ZenID.xcframework - no manual model management needed.

## Usage

### Step 1 — Authorization

The SDK must be authorized when your app starts. Authorization establishes a session that remains valid for a limited time.

#### Simple Authorization (Recommended)

The simplest way to authorize is using the `initialize()` method with `ZenIDBackendApiImpl`:

```swift
import ZenID

// 1. Create backend API instance
let backendApi = ZenIDBackendApiImpl(
    baseURL: URL(string: "https://api.zenid.com")!,
    apiKey: "your-api-key"
)

// 2. Initialize SDK (handles challenge/response AND model loading internally)
try await ZenIDManager.initialize(backendApi: backendApi)

// SDK is now authorized and ready to use!
// Convenient backend methods are now available:
//   - try await ZenIDManager.uploadSample(sampleData)
//   - try await ZenIDManager.getSample(sampleId: "sample123")
//   - try await ZenIDManager.investigateSamples(sampleIds: ["id1", "id2"])
//   - try await ZenIDManager.getProfiles()
```

**Recommendation:** Use the `initialize()` method for most applications. It handles the challenge/response flow automatically, sets up model loading from your app bundle, and provides convenient upload/investigation methods.

#### Custom Backend Implementation

If you need to customize the backend communication (e.g., add custom headers, use a different networking layer, or proxy through your own backend), you can implement the `ZenIDBackendApi` protocol:

```swift
class MyCustomBackendApi: ZenIDBackendApi {
    func initSdk(challengeToken: String) async throws -> String {
        // Your custom implementation to call ZenID's initSDK endpoint
        // Return the response token
    }

    func uploadSample(_ data: Data) async throws -> Data {
        // Your custom implementation to upload samples
        // Return raw JSON Data response from the server
    }

    func getSample(sampleId: String) async throws -> Data {
        // Your custom implementation to get sample info
    }

    func investigateSamples(sampleIds: [String]) async throws -> Data {
        // Your custom implementation to investigate samples
    }

    func getProfiles() async throws -> Data {
        // Your custom implementation to get available profiles
    }
}

// Use your custom implementation
let customApi = MyCustomBackendApi()
try await ZenIDManager.initialize(backendApi: customApi)
```

All ZenIDManager backend API methods return raw `Data` for maximum flexibility. Use the `decode(_:as:)` helper to convert responses to your types.

#### Manual Authorization (Alternative)

If you don't want to use the `initialize()` method (e.g., you manage SDK lifecycle differently), you can use the manual authorization flow. **Note:** This approach doesn't provide the convenience methods like `uploadSample()` - you'll need to implement those yourself.

```swift
// Step 1: Get challenge token
guard let challengeToken = ZenIDManager.getChallengeToken() else {
    print("Failed to generate challenge token")
    return
}

// Step 2: Exchange with your backend (using your own networking)
let responseToken = try await yourBackend.initSDK(challengeToken: challengeToken)

// Step 3: Authorize SDK
guard ZenIDManager.authorize(responseToken: responseToken) else {
    print("Authorization failed")
    return
}
```

**Important:** `getChallengeToken()` resets the SDK session. Always follow it with `authorize()`. Do not call while a verifier is running.

You can check current authorization:
```swift
let authorized = ZenIDManager.isAuthorized()
```

### Step 2 — Select profile

If your backend is configured with multiple profiles, select one by name (otherwise, a default profile is used):
```swift
ZenIDManager.selectProfile("PROFILE_NAME")
```

Returns true if the profile was successfully selected.

**Note:** The SDK also provides ready-to-use ViewModel classes (DocumentViewModel, SelfieViewModel, FaceLivenessViewModel, HologramViewModel, MSLivenessViewModel, LicencePlateViewModel) that simplify integration by handling verifier lifecycle, state management, and backend communication. These ViewModels work with both SwiftUI and UIKit. See the web documentation or sample app for complete examples.

### Step 3 — Prepare view

Use UIZenIDView (UIKit) or ZenIDView (SwiftUI). Add it to your view hierarchy. The view integrates the camera feed and the SDK’s visualization layer. You can rely on automatic registration or do it manually.

- SwiftUI (automatic registration):
struct ScannerView: View {
  var body: some View {
    ZenIDView() // registers automatically with ZenIDManager
  }
}

- SwiftUI (manual registration via callback):
struct ScannerView: View {
  @StateObject var viewModel = ViewModel()
  var body: some View {
    ZenIDView { view in
      viewModel.documentVerifier?.setView(view) // or ZenIDManager.setView(view)
    }
  }
}

- UIKit:
let scannerView = UIZenIDView(unregistered: false) // automatic registration
ZenIDManager.setView(scannerView)

If you initialize ZenIDView with a callback, automatic registration is disabled (unregistered mode) and you must call ZenIDManager.setView(...) or specificVerifier.setView(...) yourself.

You can set insets to adjust the scanning area (see “View insets and reticle”).

### Step 4 — Run a verifier

Obtain a verifier from ZenIDManager. Each call returns a shared instance per type; only one instance of a given verifier type exists at a time. If you call the factory again, you receive the same instance.

Available verifiers:
- documentVerifier(settings:visualiser:onNfcRequested:)
- hologramVerifier(settings:visualiser:)
- selfieVerifier(settings:visualiser:)
- faceLivenessVerifier(settings:visualiser:)
- msLivenessVerifier(settings:)
- licencePlateVerifier(settings:visualiser:)

Typical flow:
- Create (or fetch) the verifier
- Register the ZenID view (if not using automatic registration)
- Start the verifier
- Observe state ($state) and onResult/result
- Stop the verifier when you’re done

Example (Document verifier):
import ZenID
import Combine

let documentVerifier = try ZenIDManager.documentVerifier(
  settings: .init(
    viewportHeightCm: nil,
    enableAimingCircle: false,
    showTimer: false,
    drawOutline: true,
    platformSupportsNfcFeature: true,
    acceptableInput: .init(possibleDocuments: [
      DocumentFilter(role: DOCUMENT_ROLE,
                     country: DOCUMENT_COUNTRY,
                     page: DOCUMENT_PAGE,
                     documentCode: nil,
                     modelID: "")
    ])
  )
)

ZenIDManager.setInsets(verticalInsets: UIEdgeInsets(top: 0, left: 0, bottom: 200, right: 0))
ZenIDManager.selectProfile("PROFILE_NAME")

// States are emitted ~30 times per second. Filter as needed.
var stateCancellable: AnyCancellable?
stateCancellable = documentVerifier.$state
  .removeDuplicates(by: { $0?.state == $1?.state })
  .sink { state in
    // handle state transitions, giveMeWhat, feedback, etc.
  }

// You can observe $result or set onResult
documentVerifier.onResult = { result in
  stateCancellable?.cancel()
  documentVerifier.stop()
  uploadData(result.signedSamplePackage) // your upload method
}

try documentVerifier.start()
// ...
documentVerifier.stop()

Important:
- Only one instance of each verifier type can exist. Repeated calls return the same instance.
- If you use automatic view registration (SwiftUI ZenIDView without callback), the SDK will register the current view automatically. If not, call setView(view) before start().

## Verifier states and feedback

Each verifier publishes a specific state container via $state. All containers share:
- state: VerifierState
  - inProgress: configured and running
  - giveMe: waiting for your input (NFC, MS Liveness, or a still photo)
  - success: scan finished successfully and result will be available
  - failed: scanning failed

- giveMeWhat: SdkResponseType
  - nfc: provide NFC data (NfcResponse JSON)
  - msLiveness: perform MS Liveness and provide response
  - photo: take a photo and provide it to the SDK

- feedback: CommonVerifierFeedback
  See enums for details. Highlights:

Document verifier feedback:
- documentNoMatchFound, documentAlignCard, documentHoldSteady, documentBlurry, documentReflectionPresent, documentHologram, documentDark, documentBarcode, documentTextNotReadable, documentNfc, documentCenter, documentTiltLeftAndRight, documentTiltUpAndDown, documentTimedOut, documentTiltLeft/Right/Up/Down

Selfie verifier feedback:
- selfieNoFaceFound, selfieBlurry, selfieDark, selfieDecentred, selfieConfirmingFace, selfieBadFaceAngle

Hologram verifier feedback:
- hologramCenter, hologramTiltLeftAndRight, hologramTiltUpAndDown, hologramTimedOut, hologramTiltLeft/Right/Up/Down

Face Liveness verifier feedback:
- faceLivenessLookAtMe, faceLivenessTurnHead, faceLivenessSmile, faceLivenessBlurry, faceLivenessDark, faceLivenessHoldStill, faceLivenessResetting, faceLivenessDontSmile

Licence plate verifier feedback:
- licensePlateNotFound, licensePlateTryingToRead

MS Liveness verifier feedback:
- msLivenessNotDone

## Verifier details

All verifiers share the BaseVerifier API:
- start() / stop() / restart()
- setView(UIZenIDView) / setView(ZenIDView)
- $state: Published state container
- result: Published UploadReadyData?
- onResult: ((UploadReadyData) -> Void)?
- unload(): unloads the underlying feature
- isRunning: Published Bool

On a transition to .success, BaseVerifier automatically stops and prepares UploadReadyData, triggering onResult and updating result.

### Document verifier

Factory:
try ZenIDManager.documentVerifier(settings: DocumentVerifierSettings, visualiser: Visualiser = .defaultWeb, onNfcRequested: (NfcKey) async throws -> NfcData = DocumentVerifier.defaultNfcHandler)

Settings (DocumentVerifierSettings):
- viewportHeightCm: Float?
- enableAimingCircle: Bool
- showTimer: Bool
- drawOutline: Bool
- platformSupportsNfcFeature: Bool
- acceptableInput: AcceptableInput (array of DocumentFilter)

State type: DocumentVerifierStateContainerForPublicData
- documentCode: DocumentCodes?
- pageCode: PageCodes?
- expectedOutline: [ZenidPointF] (normalized points)
- secondsToMaxTolerance: Float
- nfcKey: NfcKey (birthDate, documentNumber, expiryDate)
- validatorsData: FrontendValidationResults

NFC Handling:
- NFC reading works automatically with zero code required - the SDK provides a built-in default handler
- To intervene in the workflow (e.g., add confirmation dialogs, custom UI), wrap the default handler - don't replace it
- Use setupNfcWithRetry() for retry handling, then optionally wrap onNfcRequested to add your logic before NFC starts
- The SDK automatically handles all NFC chip reading, retries, error handling, and response submission (success, userSkipped, deviceDoesNotSupportNfc)

Example - Wrapping handler to add confirmation dialog:
```swift
override func createVerifier() throws -> DocumentVerifier {
    let verifier = try ZenIDManager.documentVerifier(settings: settings)

    // Setup retry handling first
    verifier.setupNfcWithRetry(
        showRetryPrompt: { attempt, maxAttempts, error, skipAllowed in
            return await self.showRetryPrompt(...)
        }
    )

    // Wrap the default handler to add confirmation step
    let defaultHandler = verifier.onNfcRequested
    verifier.onNfcRequested = { [weak self] nfcKey in
        guard let self = self else {
            throw NfcDocumentReaderError.Stop
        }

        // Wait for user confirmation
        let confirmed = await self.waitForConfirmation()

        if !confirmed {
            // User wants to retake photo - stop without submission
            throw NfcDocumentReaderError.Stop
        }

        // User confirmed - call default handler (preserves all SDK functionality)
        return try await defaultHandler(nfcKey)
    }

    return verifier
}
```

NFC Error Types:
When wrapping onNfcRequested, you can throw specific errors to control the flow:
- `.Stop` - Stops verifier without backend submission or error modal (use when user wants to retake photo)
- `.UserCanceled` - User cancelled during NFC reading (SDK handles according to backend config: skip or show error)

GiveMe Photo:
- When state == .giveMe and giveMeWhat == .photo, provide a still image (encoded) to the SDK. In typical flows, the SDK captures frames; some configurations request a still.

### Hologram verifier

Factory:
try ZenIDManager.hologramVerifier(settings: DocumentVerifierSettings, visualiser: Visualiser = .defaultWeb)

State type: HologramStateContainerForPublicData
- documentCode: DocumentCodes?
- pageCode: PageCodes?
- expectedOutline: [ZenidPointF]

### Selfie verifier

Factory:
try ZenIDManager.selfieVerifier(settings: SelfieVerifierSettings = .init(), visualiser: Visualiser = .defaultWeb)

State type: SelfieStateContainerForPublicData
- stepParameters: StepParameters (headYaw, headPitch, headRoll, face center/size, checks)

Behavior:
- Requires a visible face for a short continuous period before success (stability check). Feedback transitions from SelfieConfirmingFace to Ok.

### Face Liveness verifier

Factory:
try ZenIDManager.faceLivenessVerifier(settings: FaceLivenessVerifierSettings, visualiser: Visualiser = .defaultWeb)

Settings (FaceLivenessVerifierSettings):
- enableLegacyMode: Bool
- showSmileAnimation: Bool

State type: FaceLivenessStateContainerForPublicData
- stepParameters: StepParameters

Behavior:
- Guides the user to perform liveness actions (turn head, smile, etc.). Provides detailed feedback and step parameters.

### MS Liveness verifier

Factory:
try ZenIDManager.msLivenessVerifier(settings: MsLivenessVerifierSettings = .init())

Public API:
- coordinator: MSLivenessCoordinator — provides token and handles completion
- coordinator.token: Published<String?> — observe this to show Azure UI
- coordinator.complete(success:error:) — call when Azure UI finishes
- start()/stop() — begin/end the MS liveness session

State type: MsLivenessStateContainerForPublicData
- msLivenessApiKey: String
- msLivenessEndpoint: String

Integration steps:
1. Create verifier with ZenIDManager.msLivenessVerifier()
2. Start the verifier
3. Observe coordinator.$token in your ViewModel (republish as @Published property)
4. Show Azure FaceLivenessDetectorView when token becomes available
5. Call coordinator.complete(success:error:) when Azure UI finishes
6. Verifier completes and provides result for upload

SwiftUI example:

```swift
import ZenID
import AzureAIVisionFaceUI
import SwiftUI
import Combine

// ViewModel
@MainActor class LivenessViewModel: ObservableObject {
  @Published var livenessToken: String?

  private var msLivenessVerifier: MSLivenessVerifier?
  private var tokenCancellable: AnyCancellable?

  var coordinator: MSLivenessCoordinator? {
    msLivenessVerifier?.coordinator
  }

  func setup() async {
    msLivenessVerifier = try? ZenIDManager.msLivenessVerifier()

    // Republish token to trigger UI presentation
    tokenCancellable = msLivenessVerifier?.coordinator.$token.sink { [weak self] token in
      self?.livenessToken = token
    }

    try? msLivenessVerifier?.start()
  }

  func cleanup() {
    tokenCancellable?.cancel()
    msLivenessVerifier?.stop()
  }
}

// View
struct LivenessView: View {
  @StateObject var viewModel = LivenessViewModel()

  var body: some View {
    ZenIDView()  // Shows ZenID visualizer
      .fullScreenCover(item: Binding(
        get: { viewModel.livenessToken.map { PresentationToken(token: $0) } },
        set: { _ in }
      )) { tokenWrapper in
        if let coordinator = viewModel.coordinator {
          MSLivenessSwiftUIHelper(token: tokenWrapper.token, coordinator: coordinator)
        }
      }
      .onAppear { Task { await viewModel.setup() } }
      .onDisappear { viewModel.cleanup() }
  }
}

// Helper to make String token work with .fullScreenCover(item:)
struct PresentationToken: Identifiable {
  let id = UUID()
  let token: String
}

// Copy MSLivenessSwiftUIHelper from the SDK package:
// - SPM: Samples/MSLiveness/MSLivenessSwiftUIHelper.swift
// - Manual: SDK/MSLivenessHelpers/MSLivenessSwiftUIHelper.swift or SampleTemplate/MSLiveness/MSLivenessSwiftUIHelper.swift
// See sample app for complete implementation
```

### Licence plate verifier

Factory:
try ZenIDManager.licencePlateVerifier(settings: LicensePlateVerifierSettings = .init(), visualiser: Visualiser = .defaultWeb)

State type: LicensePlateStateContainerForPublicData
- licensePlate: DetectedLicensePlate (outline, text, confidence, wpodConfidence)

## Visualizers

The SDK uses a web-based visualizer (`.defaultWeb`) that provides WebSDK-compatible appearance and optimized performance. This is the default for all verifiers.

- **defaultWeb**: Web-based visualizer (default)
- **none**: Disables SDK visualization. Build your own overlay by observing state and drawing in your own UI.

### Text Instructions

The visualizer displays text instructions by default. To disable:

```swift
ZenIDManager.renderText(false)  // Disable text overlays
```

## View insets

You can set insets to shrink the scanning area and influence how frames are cropped before processing:
- Global (for the registered view):
  ZenIDManager.setInsets(insets: UIEdgeInsets? = nil,
                         verticalInsets: UIEdgeInsets? = nil,
                         horizontalInsets: UIEdgeInsets? = nil)

- Per view:
  - ZenIDView: insets, horizontalInsets, verticalInsets
  - UIZenIDView: insets, horizontalInsets, verticalInsets

Notes:
- Only the view registered through ZenIDManager is affected by ZenIDManager.setInsets.
- Insets do not change the camera view’s aspect ratio; they adjust the crop and visualization region.

## Supported documents discovery

These helpers reflect the models bundled and license constraints:

- ZenIDManager.supportedCountries() -> [Country]?
- ZenIDManager.supportedDocuments(for: Country) -> [DocumentRole]?
- ZenIDManager.supportedDocumentPageCodes(for: Country, documentRole: DocumentRole) -> [PageCodes]?

Use them to drive UI and to build AcceptableInput with DocumentFilter entries for DocumentVerifierSettings.

## Models and loaders

All required models are now bundled inside ZenID.xcframework. The SDK discovers them automatically when you call `ZenIDManager.initialize(backendApi:)`.

If you use manual authorization with `getChallengeToken()` + `authorize()` instead of `initialize()`, models are still loaded automatically from Bundle.main.

If you need to customize model loading (advanced usage):

- Replace all loaders:
  ```swift
  ZenIDManager.setModelLoader(_ loader: ModelLoader)
  ```

- Add an additional loader:
  ```swift
  ZenIDManager.addModelLoader(_ loader: ModelLoader)
  ```

The SDK will query all registered loaders for models.

## Logging

Provide your logger to receive SDK logs:

public struct MyLogger: ZenidLogger {
  public func error(_ message: String)   { print("E:", message) }
  public func warn(_ message: String)    { print("W:", message) }
  public func info(_ message: String)    { print("I:", message) }
  public func debug(_ message: String)   { print("D:", message) }
  public func verbose(_ message: String) { print("V:", message) }
}

ZenIDManager.setLogger(MyLogger())


## Language Configuration

Configure the SDK language globally at app initialization. This affects all verifiers created afterwards.

### Automatic Language Detection (Recommended)

```swift
import RecogLib_iOS

// At app initialization - automatically detects device language
ZenIDManager.setLanguageFromDevice()
```

### Manual Language Selection

```swift
// Set a specific language
ZenIDManager.setLanguage(.czech)
ZenIDManager.setLanguage(.english)
ZenIDManager.setLanguage(.polish)
// ... other supported languages
```

### Retrieve Current Language

```swift
// Get current language name
let language = ZenIDManager.getLanguage()

// Get locale code (e.g., "en", "cs", "pl")
let localeCode = ZenIDManager.getLanguageLocale()
```

## MS Liveness

MS Liveness works like other verifiers - start it and wait for results. The only difference is you need to show Azure's liveness UI when requested.

Include AzureAIVisionFaceUI.xcframework in your project.

**Integration steps:**

1. Copy MS Liveness helper from the SDK package into your app (one-time setup):
   - **SwiftUI:** Copy `MSLivenessSwiftUIHelper.swift`
   - **UIKit:** Copy `MSLivenessUIKitHelper.swift`
   - Location in package: `Samples/MSLiveness/` (SPM) or `SDK/MSLivenessHelpers/` and `SampleTemplate/MSLiveness/` (manual)
2. Create verifier and start it
3. Observe coordinator.$token in your ViewModel (republish as @Published property)
4. Show Azure UI when token becomes available
5. Call coordinator.complete() with the result from Azure UI
6. Verifier completes and provides result for upload

See complete working example in the "MS Liveness verifier" section above or in the iOS sample app.

Implementation notes:
- Use ViewModel pattern with @Published livenessToken observing coordinator.$token
- Use Binding with .map to wrap String token as Identifiable for .fullScreenCover(item:)
- Clear coordinator.token = nil BEFORE calling complete() to dismiss Azure UI immediately


## Best practices

- Single instance rule:
  ZenIDManager returns the same instance for each verifier type. Keep weak references or nil them out to allow deallocation when not needed.

- Authorization:
  Use `ZenIDManager.initialize(backendApi:)` when your app starts. This handles authorization and provides convenient backend methods (uploadSample, investigateSamples, etc.). Alternative: manual flow with getChallengeToken -> backend -> authorize(responseToken:).

- View lifecycle:
  Ensure the ZenID view is on screen and registered before calling start(). If you navigate away, stop verifiers and re-set the view on return.

- Insets and cropping:
  Insets affect the crop region used for processing. Avoid extreme values that leave no effective scanning area.

- State frequency:
  $state updates up to ~30 times per second. Use removeDuplicates or throttle if you only care about transitions.

- NFC:
  Works automatically by default with zero code. To intervene in the workflow (e.g., add confirmation dialogs), wrap the default handler - don't replace it. Store the original handler and call it after your logic. Use `.Stop` error to cancel without backend submission. The SDK always handles all chip reading, retries, error handling, and response submission automatically.

- MS Liveness:
  Works via MSLivenessCoordinator. Observe coordinator.token to show Azure UI, call coordinator.complete() when done. SDK handles all Microsoft API calls and response submission automatically.

- Results:
  UploadReadyData contains signedSamplePackage, imagePreview, auxiliary images and metadata. Use the provided Data accessors from the extension.


#### How to fix focusing problem with new iPhone Pro models.

You must zoom in on the video stream to compensate for the minimum focus distance and required magnification.
We created a method which do exactly this, so you don't have to write your own. This method is available since
iOS 15 which covers iPhone 13 Pro and newer.

```swift
if #available(iOS 15.0, *) {
    Camera.setRecommendedZoomFactor(for: device) // AVCaptureDevice
}
```

## Version

Get the SDK version:
let version = ZenIDManager().version
