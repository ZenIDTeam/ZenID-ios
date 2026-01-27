# MS Liveness Sample Code

This folder contains ready-to-copy helper code for integrating MS Liveness into your app.

## Files Included

### `MSLivenessSwiftUIHelper.swift` (SwiftUI)
SwiftUI view that wraps Azure's `FaceLivenessDetectorView` and integrates with ZenID's `MSLivenessCoordinator`.

**Usage:** Copy this file into your SwiftUI project. Reduces integration code to ~15 lines.

### `MSLivenessUIKitHelper.swift` (UIKit)
UIKit helper class that manages the entire MS Liveness flow including:
- Creating and managing `MSLivenessViewModel` (with upload/investigation)
- Observing coordinator token changes
- Presenting/dismissing Azure UI as a child view controller
- Handling Azure liveness results and retry logic

**Usage:** Copy this file into your UIKit project. Reduces integration code to ~15 lines.

### `MsLivenessViewModel.swift` (Reference)
This is the original SDK source code that implements MsLivenessViewModel.

Not needed for integration, but may be helpful for understanding how the helpers work.

**Usage:** Reference only - use the helpers above for actual integration.

## Integration Steps

### For SwiftUI Apps

1. **Copy `MSLivenessSwiftUIHelper.swift` into your project**
   - Drag the file into Xcode
   - Ensure it's added to your app target (not the SDK)

2. **Use with MSLivenessViewModel:**
   ```swift
   @StateObject private var viewModel = MSLivenessViewModel()
   @State private var showLivenessSheet: MSLivenessPresentationToken?

   .fullScreenCover(item: $showLivenessSheet) { token in
       if let coordinator = viewModel.verifier?.coordinator {
           MSLivenessSwiftUIHelper(token: token.token, coordinator: coordinator)
       }
   }
   ```

### For UIKit Apps

1. **Copy `MSLivenessUIKitHelper.swift` into your project**
   - Drag the file into Xcode
   - Ensure it's added to your app target (not the SDK)

2. **Use in your view controller:**
   ```swift
   livenessHelper = MSLivenessUIKitHelper(
       parentViewController: self,
       zenIDView: zenIDView
   )
   livenessHelper?.start()
   ```

## Framework Requirements

Ensure you've linked both frameworks:
- `ZenID.xcframework`
- `AzureAIVisionFaceUI.xcframework`

## Why Is This Code Not in the SDK?

Azure AI Vision Face SDK is an **optional dependency** (140MB).

Keeping the helpers separate makes it easy to use the SDK without the dependency when it's not needed.
