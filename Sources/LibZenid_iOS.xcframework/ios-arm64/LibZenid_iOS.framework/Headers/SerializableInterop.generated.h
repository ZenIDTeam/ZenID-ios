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
#include "ZenidEnums.generated.h"


namespace RecogLibC RECOGLIBC_PUBLIC
{

class SelfieLivenessSdkValidatorConfig
{
public:
  std::vector<std::vector<SdkLivenessSteps>> RandomSequences;
  inline static float SmileThreshold = 0.65f;
  inline static float NoSmileThreshold = 0.4f;
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
  int RandomSequencesCount = 50;
  int AcceptScore = 100;
  bool IsTestEnabled = true;
};
class NfcValidatorConfig
{
public:
  int NumberOfReadingAttempts = 1;
  bool SkipNfcAllowed = false;
  bool NoNfcMeansError = false;
  bool IsEnabled = true;
  int AcceptScore = 100;
  int ScoreStep = 100;
  bool IsTestEnabled = true;
};
class BarcodeValidatorConfig
{
public:
  int ScoreStep = 100;
  bool UseOnNfcFields = false;
  int MinFieldConfidence = 0;
  int AcceptScore = 100;
  bool IsTestEnabled = true;
};
class SdkPictureQualityValidatorConfig
{
public:
  int OverallTimeToMaxTolerance = 60;
  int TimeToMaxToleranceForBlur = 60;
  int TimeToMaxToleranceForSpecular = 10;
  int TimeToMaxToleranceForDarkness = 60;
  int TimeToMaxToleranceForAlignment = 10;
  int TimeToMaxToleranceForBorderDistance = 10;
  int TimeToMaxToleranceForLinearFit = 5;
  int TimeToMaxToleranceForStability = 10;
  int MinBlurriness = 30;
  int MaxBlurriness = 50;
  int MinSpecular = 50;
  int MaxSpecular = 100;
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
  bool UseAlternativeTiltVisualisation = false;
  int AcceptScore = 100;
  bool IsTestEnabled = true;
  int ScoreStep = 1;
};
class MrzChecksumValidatorConfig
{
public:
  int ScoreStep = 100;
  bool EnableSdkCheck = false;
  bool UseOnNfcFields = false;
  int MinFieldConfidence = 0;
  int AcceptScore = 100;
  bool IsTestEnabled = true;
};
class SdkSignatureValidatorConfig
{
public:
  ResponseWhenNoSignature NoSignatureHandling = ResponseWhenNoSignature::ValidatorDoesnotRun;
  bool AcceptOfflineToken = false;
  int TimestampDelayInSeconds = 300;
  int ScoreStep = 100;
  int AcceptScore = 100;
  bool IsTestEnabled = true;
};
class SdkProfileConfigs
{
public:
  SelfieLivenessSdkValidatorConfig SelfieLivenessSdkValidatorConfig;
  NfcValidatorConfig NfcValidatorConfig;
  BarcodeValidatorConfig BarcodeValidatorConfig;
  SdkPictureQualityValidatorConfig SdkPictureQualityValidatorConfig;
  IQSHologramValidatorConfig IQSHologramValidatorConfig;
  MrzChecksumValidatorConfig MrzChecksumValidatorConfig;
  SdkSignatureValidatorConfig SdkSignatureValidatorConfig;
};
class SdkMasterConfig
{
public:
  std::unordered_map<std::string, SdkProfileConfigs> PerProfileConfigs;
  std::string DefaultProfile;
  std::string NfcStringToSign = "";
};
class ValidatorResultInfo
{
public:
  std::optional<FrontendValidatorType> ValidatorType;
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
  std::string SecondaryDocumentNumber;
  std::optional<int> SecondaryDocumentNumberChecksum;
  std::optional<bool> SecondaryDocumentNumberVerified;
  std::string SecondaryDocumentRole;
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
class NfcData
{
public:
  std::unordered_map<DGName, std::string> DataGroups;
  NfcProtocol ProtocolUsed = NfcProtocol::PACE;
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
  std::optional<DocumentCodes> DocumentCode;
  std::optional<PageCodes> PageCode;
  std::unordered_map<FieldID, std::string> MinedData;
  std::string LicensePlate;
};
class FrontendValidationResults
{
public:
  ValidatorBackendData ResultsOfFrontendValidations;
  std::optional<DocumentCodes> DocumentCode;
  std::optional<PageCodes> PageCode;
};
}
