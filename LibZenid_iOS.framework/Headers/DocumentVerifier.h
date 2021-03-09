// Copyright (c) Společnost pro informační technologie a právo, s.r.o.

#pragma once

#include "ZenidEnums.generated.h"

#ifndef NO_OPENCV
#include "opencv2/core.hpp"
#endif

#include <memory>
#include <optional>

namespace RecogLibC
{
class Image;
class AcceptableInput;

class DocumentVerifierSettings
{
public:
	// Height of the visible area seen by the camera, in cm.
	// If set, the outlines will be adjusted to match the actual document sizes.
	// Useful for taking pictures from a camera mounted at a fixed distance from a surface.
	// If not set, the outline scale will be chosen independently for each document type.
	std::optional<float> viewportHeightCm;

	// Toggles displaying an aiming circle while searching for cards.
	bool enableAimingCircle = false;
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

#ifndef NO_OPENCV
	void ProcessFrame(const cv::Mat& frame, const AcceptableInput& acceptableInput);
	
	void ProcessFrame(const cv::Mat& frame,
	                  const std::optional<DocumentRole> role = {},
	                  const std::optional<Country> country = {},
	                  const std::optional<PageCodes> page = {},
	                  const std::optional<DocumentCodes> documentCode = {});
#endif

	State GetState() const;

	// Invalid if the state is NoMatchFound
	DocumentCodes GetDocumentCode() const;
	// Invalid if the state is NoMatchFound
	PageCodes GetPageCode() const;
	// Invalid if the state is NoMatchFound
	DocumentRole GetDocumentRole() const;
	// Invalid if the state is NoMatchFound
	Country GetCountry() const;

	HologramState GetHologramState() const;

	void LoadModel(const char* buffer, size_t size);

	bool SupportsHologram() const;

	void BeginHologramVerification();

	void EndHologramVerification();
#ifndef NO_OPENCV
	std::string GetRenderCommands(const cv::Size& canvasSize, SupportedLanguages language);
#endif
	std::string GetRenderCommands(int canvasWidth, int canvasHeight, SupportedLanguages language);

	void SetDebugVisualization(bool isEnabled);

	~DocumentVerifier();

	DocumentVerifierSettings& GetSettings() const;

	// Resets the state. The state will go back as though no picture was found. Models will stay loaded.
	void Reset();

	class Impl;

private:
	std::unique_ptr<Impl> pImpl;
};
}
