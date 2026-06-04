# MS Liveness Integration Helpers

SwiftUI and UIKit helper code for integrating MS Liveness into your app.

**Swift Package Manager:** the helpers ship as the `ZenIDMSLiveness` module (part of the
`ZenIDFull` product) — `import ZenIDMSLiveness`, nothing to copy.

**Manual integration:** copy the relevant helper file below into your app target.

## Files Included

### `MSLivenessSwiftUIHelper.swift` (SwiftUI)
SwiftUI view that wraps Azure's `FaceLivenessDetectorView` and reports back to a
`MSLivenessCoordinator`. Uses `.fullScreenCover(item:)` keyed on `MSLivenessPresentationRequest.id`,
so retries cleanly dismiss-then-represent without the timing hacks earlier versions required.

**Manual integration only:** copy this file into your SwiftUI project. (SwiftPM users skip this.)

**Usage:** apply `.msLiveness(coordinator:)` once on your view; that's the entire SwiftUI integration.

### `MSLivenessUIKitHelper.swift` (UIKit)
UIKit helper class that:
- Adds a black background to hide the dead camera (Azure manages its own camera).
- Observes `coordinator.presentation` and presents/dismisses Azure UI accordingly.
- Calls `coordinator.complete(success:error:)` with the Azure result.

**Manual integration only:** copy this file into your project. (SwiftPM users skip this.)

**Usage:** instantiate with `MSLivenessUIKitHelper.setup(viewController:coordinator:)`.

### `MSLivenessViewModel.swift` (Reference)
Reference snippet showing the SDK's `MSLivenessViewModel`. Already compiled into the SDK — you
don't need to copy it.

## Integration

The coordinator can be created independently of the verifier. Create it once, observe it from
your view, and pass the same instance to the verifier.

### SwiftUI
```swift
import SwiftUI
import ZenID

struct MyLivenessView: View {
    @StateObject var coordinator = MSLivenessCoordinator()
    @State var verifier: MSLivenessVerifier?

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()   // hide dead camera
            ZenIDView()                     // visualizer messages (retry countdown)
        }
        .onAppear {
            verifier = try? ZenIDManager.msLivenessVerifier(coordinator: coordinator)
            verifier?.onResult = { /* handle UploadReadyData */ }
            try? verifier?.start()
        }
        .onDisappear { verifier?.stop() }
        .msLiveness(coordinator: coordinator)
    }
}
```

You can also drop the coordinator entirely and use the closure-shaped API:

```swift
verifier.onAzurePresentationRequested = { token, completion in
    // present Azure however you want, then call completion(success, error)
}
```

### UIKit
```swift
let coordinator = MSLivenessCoordinator()
let verifier = try ZenIDManager.msLivenessVerifier(coordinator: coordinator)

// In viewDidAppear:
msLivenessHelper = MSLivenessUIKitHelper.setup(viewController: self, coordinator: coordinator)
try verifier.start()

// In viewWillDisappear:
verifier.stop()
msLivenessHelper?.cleanup()
```

## Framework Requirements

Ensure you've linked both frameworks:
- `ZenID.xcframework`
- `AzureAIVisionFaceUI.xcframework`

## Why Is This Code Not in the SDK?

Azure AI Vision Face SDK is an **optional dependency** (140MB).

Keeping the helpers separate makes it easy to use the SDK without the dependency when it's not needed.
