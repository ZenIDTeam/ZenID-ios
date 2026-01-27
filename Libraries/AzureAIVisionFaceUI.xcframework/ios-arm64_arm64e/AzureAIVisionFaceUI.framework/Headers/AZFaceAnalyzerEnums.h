//
// Copyright (c) Microsoft. All rights reserved.
// See https://aka.ms/csspeech/license for the full license information.
//

#import <Foundation/Foundation.h>

/**
  * The face recognition failure reason
  */
typedef NS_ENUM(NSUInteger, AZFaceRecognitionFailureReason)
{
    /**
     * Indicates no failure
     */
    AZFaceRecognitionFailureReasonNone,

    /**
     * Indicates internal failure
     */
    AZFaceRecognitionFailureReasonGenericFailure,

    /**
     * Indicates face pose is incorrect
     */
    AZFaceRecognitionFailureReasonFaceNotFrontal,

    /**
     * Indicates eyes are not visible
     */
    AZFaceRecognitionFailureReasonFaceEyeRegionNotVisible,

    /**
     * Indicates face is too bright
     */
    AZFaceRecognitionFailureReasonExcessiveFaceBrightness,

    /**
     * Indicates face is too blurred
     */
    AZFaceRecognitionFailureReasonExcessiveImageBlurDetected,

    /**
     * Indicates face is not found in verify image
     */
    AZFaceRecognitionFailureReasonFaceNotFound,

    /**
     * Indicates multiple face found in verify image
     */
    AZFaceRecognitionFailureReasonMultipleFaceFound,

    /**
     * Indicates verify image has content decoding error
     */
    AZFaceRecognitionFailureReasonContentDecodingError,

    /**
     * Indicates image size is too large
     */
    AZFaceRecognitionFailureReasonImageSizeIsTooLarge,

    /**
     * Indicates image size is too small
     */
    AZFaceRecognitionFailureReasonImageSizeIsTooSmall,

    /**
     * Indicates image is with unsupported media type
     */
    AZFaceRecognitionFailureReasonUnsupportedMediaType,

    /**
     * Indicates mouth region is not visible
     */
    AZFaceRecognitionFailureReasonFaceMouthRegionNotVisible,

    /**
     * Indicates a mask has been detected
     */
    AZFaceRecognitionFailureReasonFaceWithMaskDetected,
  } NS_SWIFT_NAME(RecognitionError);

/**
 * Reasons for failure of the liveness analysis.
 */
typedef NS_ENUM(NSUInteger, AZFaceLivenessFailureReason)
{
    /**
     * Indicates no failure.
     */
    AZFaceLivenessFailureReasonNone,

    /**
     * Indicates mouth region is not visible
     */
    AZFaceLivenessFailureReasonFaceMouthRegionNotVisible,

    /**
     * Indicates eye region is not visible
     */
    AZFaceLivenessFailureReasonFaceEyeRegionNotVisible,

    /**
     * Indicates image is too blurry
     */
    AZFaceLivenessFailureReasonExcessiveImageBlurDetected,

    /**
     * Indicates image is too bright
     */
    AZFaceLivenessFailureReasonExcessiveFaceBrightness,

    /**
     * Indicates a mask has been detected
     */
    AZFaceLivenessFailureReasonFaceWithMaskDetected,

    /**
     * Indicates a timeout failure
     */
    AZFaceLivenessFailureReasonTimedOut,

    /**
     * Indicates environment not supported failure
     */
    AZFaceLivenessFailureReasonEnvironmentNotSupported,

    /**
     * Indicates face tracking failure
     */
    AZFaceLivenessFailureReasonFaceTrackingFailed,

    /**
     * Indicates service response code between 401 and 409 is returned
     */
    AZFaceLivenessFailureReasonUnexpectedClientError,

    /**
     * Indicates service response code equal to or greater than 500 is returned
     */
    AZFaceLivenessFailureReasonUnexpectedServerError,

    /**
     * Indicates unexpected service response code is returned
     */
    AZFaceLivenessFailureReasonUnexpected,

    /**
     * Indicates camera permission denied failure
     */
    AZFaceLivenessFailureReasonCameraPermissionDenied,

    /**
     * Indicates other camera startup failures
     */
    AZFaceLivenessFailureReasonCameraStartupFailure,

    /**
     * smile not performed liveness failure reason.
     */
    AZFaceLivenessFailureReasonSmileNotPerformed,

    /**
     * random pose not performed liveness failure reason.
     */
    AZFaceLivenessFailureReasonHeadTurnNotPerformed,

    /**
     * Server request timed out liveness failure reason.
     */
    AZFaceLivenessFailureReasonServerTimedOut,

    /**
     * Invalid token liveness failure reason.
     */    
    AZFaceLivenessFailureReasonInvalidToken,

    /**
     * No face detected liveness failure reason.
     */    
    AZFaceLivenessFailureReasonNoFaceDetected,

    /**
     * User canceled session liveness failure reason.
     */    
    AZFaceLivenessFailureReasonUserCanceledSession,

    /**
     * User canceled active motion liveness failure reason.
     */    
    AZFaceLivenessFailureReasonUserCanceledActiveMotion,

    /**
     * User canceled active motion prompt liveness failure reason.
     */    
    AZFaceLivenessFailureReasonUserCanceledActiveMotionPrompt,

    /**
     * Client version not supported liveness failure reason.
     */
    AZFaceLivenessFailureReasonClientVersionNotSupported,
    
    /**
     * Verification image not provided liveness failure reason.
     */
    AZFaceLivenessFailureReasonVerifyImageNotProvided,
    
    /**
     * Setting verification image not allowed liveness failure reason.
     */
    AZFaceLivenessFailureReasonSetVerifyImageNotAllowed,

    /**
     * Indicates internal failure
     */
    AZFaceLivenessFailureReasonGenericFailure,
} NS_SWIFT_NAME(LivenessError);
