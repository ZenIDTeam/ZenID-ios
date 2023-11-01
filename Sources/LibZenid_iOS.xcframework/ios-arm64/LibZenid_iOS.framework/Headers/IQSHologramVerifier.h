#pragma once

#include "RecogLibCApi.h"
#include "ZenidEnums.generated.h"

#include <memory>
#include <optional>
#include <string>
#include <utility>

#ifndef NO_OPENCV
#include <opencv2/core.hpp>
#endif

namespace RecogLibC RECOGLIBC_PUBLIC
{
class Image;
class AcceptableInput;

class IQSHologramVerifierSettings
{
   public:
	// Toggles displaying an aiming circle while searching for cards.
	bool enableAimingCircle = false;

	// Draw the card outline
	bool drawOutline = true;

	// Selects the format of GetRenderCommands.
	// Version 1 is the procedural version wih semicolon-separated parameters.
	// Version 2 is JSON processed by zenid-visualizer.js
	int visualizerVersion = 2;
};


class IQSHologramVerifier
{
   public:
	IQSHologramVerifier(const std::shared_ptr<IQSHologramVerifierSettings>& settings =
		std::make_shared<IQSHologramVerifierSettings>());

#ifndef NO_OPENCV
	void ProcessFrame(const cv::Mat& frame, const AcceptableInput& acceptableInput);
#endif
	void ProcessFrame(const Image& frame, const AcceptableInput& acceptableInput);
	void ProcessFrame(const Image& frame, const std::string& acceptableInputJson);


	HologramState GetState() const;
	void Reset();

	// Empty if the state is NoMatchFound
	std::optional<DocumentCodes> GetDocumentCode() const;
	// Empty if the state is NoMatchFound
	std::optional<PageCodes> GetPageCode() const;
	// Empty if the state is NoMatchFound
	std::optional<DocumentRole> GetDocumentRole() const;
	// Empty if the state is NoMatchFound
	std::optional<Country> GetCountry() const;

	std::vector<std::pair<DocumentCodes, PageCodes>> GetEnabledModels(const AcceptableInput& acceptableInput) const;
	std::vector<std::pair<DocumentCodes, PageCodes>> GetEnabledModels(const std::string& acceptableInputJson) const;

	// Only valid if the state is OK.
	const std::string& GetSignature() const;
	// Only valid if the state is OK.
	const std::vector<uint8_t>& GetSignedImage() const;

	void LoadModel(const char* buffer, size_t size);
	void LoadTesseractModel(const std::string& resourcePath);

#ifndef NO_OPENCV
	std::string GetRenderCommands(const cv::Size& canvasSize, SupportedLanguages language);
#endif
	std::string GetRenderCommands(int canvasWidth, int canvasHeight, SupportedLanguages language);

	static std::string GetStateDescription(HologramState feedback, SupportedLanguages language);

	void SetDebugVisualization(bool isEnabled);

	IQSHologramVerifierSettings& GetSettings() const;

	~IQSHologramVerifier();

   private:
	class RECOGLIBC_PRIVATE Impl;
	std::unique_ptr<Impl> pImpl;
};

}