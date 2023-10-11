// This file is generated automatically. Any change will be overwritten.
#pragma once

#include <string>
#include <map>
#include <unordered_map>
#include <vector>
#include <optional>
#include <chrono>
#include <cstdint>

#include "RecogLibCApi.h"


namespace RecogLibC RECOGLIBC_PUBLIC
{

enum class SdkLivenessSteps
{
  UpPerspective = 0,
  Left = 1,
  Right = 2,
  Down = 3,
  Smile = 4,
  Blinking = 5,
  UpObsolete = 6,
};

class SelfieLivenessSdkValidatorConfig
{
public:
  std::vector<std::vector<SdkLivenessSteps>> RandomSequences;
  inline static float SmileThreshold = 0.82f;
  int ScoreStep = 100;
  std::vector<SdkLivenessSteps> AllowedSteps;
  bool StepUpPerspective = true;
  bool StepDown = true;
  bool StepLeft = true;
  bool StepBlinking = false;
  bool StepRight = true;
  bool StepSmile = true;
  bool StepUpObsolete = false;
  int StepCount = 4;
  bool LostFaceResets = true;
  bool ReCheckFrontend = false;
  int AcceptScore = 100;
  bool IsTestEnabled = true;
};
class NfcValidatorConfig
{
public:
  int NfcChipReadingTimeoutSeconds = 30;
  int NumberOfReadingAttempts = 1;
  bool SkipNfcAllowed = false;
  bool NoNfcMeansError = false;
  bool IsEnabled = false;
  int AcceptScore = 100;
  int ScoreStep = 100;
  bool IsTestEnabled = true;
};
class BlurValidatorConfig
{
public:
  int AcceptScore = 50;
  bool IsTestEnabled = true;
  int ScoreStep = 1;
};
class SpecularImageValidatorConfig
{
public:
  int AcceptScore = 50;
  bool IsTestEnabled = true;
  int ScoreStep = 1;
};
class BarcodeValidatorConfig
{
public:
  int ScoreStep = 100;
  bool UseOnNfcFields = false;
  int MinFieldConfidence = 50;
  int AcceptScore = 100;
  bool IsTestEnabled = true;
};
class SdkPictureQualityValidatorConfig
{
public:
  int OverallTimeToMaxTolerance = 10;
  int TimeToMaxToleranceForBlur = 10;
  int TimeToMaxToleranceForSpecular = 10;
  int TimeToMaxToleranceForDarkness = 10;
  int TimeToMaxToleranceForAlignment = 10;
  int TimeToMaxToleranceForBorderDistance = 10;
  int TimeToMaxToleranceForLinearFit = 5;
  int TimeToMaxToleranceForStability = 10;
  int MinDarkness = 80;
  int MaxDarkness = 100;
  int MinAlignment = 50;
  int MaxAlignment = 70;
  int MinBorderDistance = 40;
  int MaxBorderDistance = 50;
  int MinLinearFit = 50;
  int MaxLinearFit = 50;
  int MinStability = 20;
  int MaxStability = 30;
  int AcceptScore = 100;
  int ScoreStep = 100;
  bool IsTestEnabled = true;
};
class IQSHologramValidatorConfig
{
public:
  int RequiredHorizontalRangeTR = 20;
  int RequiredVerticalRangeTR = 20;
  int MinimumUniqueMatchesTR = 0;
  int TimeoutTR = 0;
  int RequiredHorizontalRangeOL = 6;
  int RequiredVerticalRangeOL = 7;
  int MinimumUniqueMatchesOL = 0;
  int TimeoutOL = 0;
  int AcceptScore = 100;
  bool IsTestEnabled = true;
  int ScoreStep = 1;
};
class SdkProfileConfigs
{
public:
  SelfieLivenessSdkValidatorConfig SelfieLivenessSdkValidatorConfig;
  NfcValidatorConfig NfcValidatorConfig;
  BlurValidatorConfig BlurValidatorConfig;
  SpecularImageValidatorConfig SpecularImageValidatorConfig;
  BarcodeValidatorConfig BarcodeValidatorConfig;
  SdkPictureQualityValidatorConfig SdkPictureQualityValidatorConfig;
  IQSHologramValidatorConfig IQSHologramValidatorConfig;
};
class SdkMasterConfig
{
public:
  std::unordered_map<std::string, SdkProfileConfigs> PerProfileConfigs;
  std::string DefaultProfile;
  std::string NfcStringToSign = "";
};
enum class PlatformKind
{
  Web = 0,
  Android = 1,
  iOS = 2,
};

enum class ValidatorType
{
  LowConfidence = 1,
  BirthDateMrz = 2,
  IssueAndExpiry = 3,
  BirthNumber = 4,
  Specular = 5,
  Selfie = 6,
  Kerning = 7,
  VerticalAlignment = 8,
  FontShape = 9,
  Holo = 11,
  Dpi = 15,
  SelfieLiveness = 17,
  Exif = 18,
  IdCardRecalled = 19,
  FaceSex = 20,
  Moire = 21,
  Barcode = 22,
  DocumentComplete = 23,
  FirstNameMrz = 24,
  LastNameMrz = 25,
  ExpiryDateMrz = 26,
  SexMrz = 27,
  IdcardNumberMrz = 28,
  PassportNumberMrz = 29,
  BirthNumberDateMrz = 30,
  BirthNumberSexMrz = 31,
  BirthNumberPassportMrz = 32,
  MrzChecksum = 33,
  SelfieRequired = 34,
  FieldsAlignment = 35,
  SelfieVideoRequired = 36,
  FaceAge = 37,
  RequiredFields = 38,
  VideoCut = 40,
  Blur = 41,
  UnknownDocument = 43,
  DocVideoRequired = 44,
  DocRequired = 45,
  IDCardNumberRange = 46,
  Insolvency = 47,
  DocumentsConsistency = 48,
  PhotoColor = 49,
  PaperGrain = 50,
  DocumentPhoto = 51,
  SpecularImage = 53,
  OneFaceSeveralBirthNums = 54,
  OneBirthNumSeveralFaces = 55,
  FaceTilt = 56,
  Mvsr = 57,
  DisplayDetection = 58,
  SdkSignature = 59,
  VisaNumberMrz = 60,
  MinimalAge = 61,
  FieldManipulation = 62,
  CardFaceManipulation = 63,
  DamagedCard = 64,
  MaskedFace = 65,
  SelfieLivenessSdk = 66,
  Nfc = 67,
  SdkPictureQuality = 68,
  IQSHologram = 69,
};

class ValidatorResultInfo
{
public:
  std::optional<ValidatorType> ValidatorType;
  std::string Description;
  int Score = 0;
  int ThresholdMax = 0;
  int ThresholdMin = 0;
  bool PassedValidation = false;
};
class ValidatorBackendData
{
public:
  std::vector<ValidatorResultInfo> ValidatorResults;
  std::string Barcode = "";
};
enum class DefType
{
  TD1_IDC = 0,
  TD2_IDC2000 = 1,
  TD3_PAS = 2,
  SKDRV = 3,
  None = 4,
  FrenchID1988 = 5,
  NLDRV = 6,
};

class MrzData
{
public:
  bool NfcEnabled = false;
  std::string BirthDate;
  bool BirthDateVerified = false;
  std::string DocumentNumber;
  bool DocumentNumberVerified = false;
  std::string ExpiryDate;
  bool ExpiryDateVerified = false;
  std::string GivenName;
  bool ChecksumVerified = false;
  int ChecksumDigit = 0;
  std::string LastName;
  std::string Nationality;
  std::string Sex;
  std::string BirthNumber;
  std::optional<int> BirthNumberChecksum;
  std::optional<bool> BirthNumberVerified;
  std::optional<int> BirthDateChecksum;
  std::optional<int> DocumentNumChecksum;
  std::optional<int> ExpiryDateChecksum;
  std::string IssueDate;
  std::string AdditionalData;
  std::string AdditionalData2;
  std::string Issuer;
  std::string Prefix;
  std::string CardType;
  std::string CardSubType;
  std::optional<std::chrono::system_clock::time_point> BirthDateParsed;
  std::optional<std::chrono::system_clock::time_point> ExpiryDateParsed;
  std::optional<std::chrono::system_clock::time_point> IssueDateParsed;
  DefType MrzDefType = DefType::TD1_IDC;
};
enum class DGName
{
  COM = 0,
  SOD = 1,
  DG1 = 2,
  DG2 = 3,
  DG3 = 4,
  DG4 = 5,
  DG5 = 6,
  DG6 = 7,
  DG7 = 8,
  DG8 = 9,
  DG9 = 10,
  DG10 = 11,
  DG11 = 12,
  DG12 = 13,
  DG13 = 14,
  DG14 = 15,
  DG15 = 16,
  DG16 = 17,
};

enum class NfcProtocol
{
  PACE = 0,
  BAC = 1,
};

class NfcData
{
public:
  std::unordered_map<DGName, std::string> DataGroups;
  NfcProtocol ProtocolUsed = NfcProtocol::PACE;
};
enum class NfcStatus
{
  DeviceDoesNotSupportNfc = 0,
  InvalidNfcKey = 1,
  UserSkipped = 2,
  Ok = 3,
};

class Signature
{
public:
  std::string Hash;
  std::vector<float> Outline;
  int64_t Timestamp = 0;
  std::string Identifier;
  PlatformKind PlatformKind = PlatformKind::Web;
  ValidatorBackendData ValidatorData;
  bool IsOfflineToken = false;
  std::string Version;
  int LivenessTryNumber = 0;
  std::string ChallengeToken;
  std::string SelectedProfile;
  MrzData MrzData;
  NfcData NfcData;
  std::optional<NfcStatus> NfcStatus;
};
}
