#pragma once

#include "ZenidEnums.generated.h"

#ifndef NO_OPENCV
#include <opencv2/core.hpp>
#endif

#include <memory>
#include <optional>
#include <string>
#include <utility>

namespace RecogLibC
{
class Image;
class AcceptableInput;

class DocumentVerifierSettings
{
public:
	DocumentVerifierSettings() = default;
	DocumentVerifierSettings(const std::optional<float>& viewportHeightCm,
	                         bool enableAimingCircle,
	                         bool showTimer,
	                         const std::optional<int>& specularAcceptableScore,
	                         const std::optional<int>& documentBlurAcceptableScore,
	                         const std::optional<int>& timeToBlurMaxToleranceInSeconds,
	                         bool drawOutline,
	                         bool readBarcode);

	// Height of the visible area seen by the camera, in cm.
	// If set, the outlines will be adjusted to match the actual document sizes.
	// Useful for taking pictures from a camera mounted at a fixed distance from a surface.
	// If not set, the outline scale will be chosen independently for each document type.
	std::optional<float> viewportHeightCm;

	// Toggles displaying an aiming circle while searching for cards.
	bool enableAimingCircle = false;

	// Toggles displaying timer that shows seconds remaining for the validators to become max tolerant. 
	bool showTimer = false;

	//Can be used for fine tuning the sensitivity of the specular validator. Value range 0-100. Default value is 50.
	std::optional<int> specularAcceptableScore;
	//Can be used for fine tuning the sensitivity of the document blur validator. Value range 0-100. Default value is 50.
	std::optional<int> documentBlurAcceptableScore;
	//The time delay for the blur validator to become max tolerant. Default value is 10.
	std::optional<int> timeToBlurMaxToleranceInSeconds;

	// Draw the card outline
	bool drawOutline = true;
	// Read the barcode
	bool readBarcode = true;
	
	// Selects the format of GetRenderCommands.
	// Version 1 is the procedural version wih semicolon-separated parameters.
	// Version 2 is JSON processed by zenid-visualizer.js
	int visualizerVersion = 2;
};

class DocumentVerifier
{
public:
	using State = DocumentVerifierState;

	// Don't load any models. Models will need to be loaded individually with LoadModel.
	DocumentVerifier(
		const std::shared_ptr<DocumentVerifierSettings>& settings = std::make_shared<DocumentVerifierSettings>());

	void ProcessFrame(const Image& frame,
	                  const DocumentRole* role = nullptr,
	                  const Country* country = nullptr,
	                  const PageCodes* page = nullptr,
	                  const DocumentCodes* documentCode = nullptr);
	
	void ProcessFrame(const Image& frame, const AcceptableInput& acceptableInput);
	void ProcessFrame(const Image& frame, const std::string& acceptableInputJson);

#ifndef NO_OPENCV
	void ProcessFrame(const cv::Mat& frame, const AcceptableInput& acceptableInput);
	void ProcessFrame(const cv::Mat& frame, const std::string& acceptableInputJson);
	
	void ProcessFrame(const cv::Mat& frame,
	                  const std::optional<DocumentRole> role = {},
	                  const std::optional<Country> country = {},
	                  const std::optional<PageCodes> page = {},
	                  const std::optional<DocumentCodes> documentCode = {});
#endif

	State GetState() const;
	float GetSecondsToMaxTolerance() const;
	// Empty if the state is NoMatchFound
	std::optional<DocumentCodes> GetDocumentCode() const;
	// Empty if the state is NoMatchFound
	std::optional<PageCodes> GetPageCode() const;
	// Empty if the state is NoMatchFound
	std::optional<DocumentRole> GetDocumentRole() const;
	// Empty if the state is NoMatchFound
	std::optional<Country> GetCountry() const;

	std::optional<int> GetRequiredVideoFps() const;
	std::optional<int> GetRequiredVideoResolution() const;
	
	// Only valid if the state is OK.
	const std::string& GetSignature() const;
	// Only valid if the state is OK.
	const std::vector<uint8_t>& GetSignedImage() const;

	HologramState GetHologramState() const;

	void LoadModel(const char* buffer, size_t size);
	
	void BeginHologramVerification();

	void EndHologramVerification();
#ifndef NO_OPENCV
	std::string GetRenderCommands(const cv::Size& canvasSize, SupportedLanguages language);
#endif
	std::string GetRenderCommands(int canvasWidth, int canvasHeight, SupportedLanguages language);

	void SetDebugVisualization(bool isEnabled);

	~DocumentVerifier();

	DocumentVerifierSettings& GetSettings() const;

	// Returns pairs of enabled DocumentCodes/PageCodes taking into account AcceptableInput and the license. Has to be run after Authorize.
	std::vector<std::pair<DocumentCodes, PageCodes>> GetEnabledModels(const AcceptableInput& acceptableInput) const;
	
	// Returns pairs of enabled DocumentCodes/PageCodes taking into account AcceptableInput and the license. Has to be run after Authorize.
	// acceptableInput is an AcceptableInput string in json format. 
	std::vector<std::pair<DocumentCodes, PageCodes>> GetEnabledModels(const std::string& acceptableInputJson) const;

	// Resets the state. The state will go back as though no picture was found. Models will stay loaded.
	void Reset();

	class Impl;

private:
	std::unique_ptr<Impl> pImpl;
};
}
