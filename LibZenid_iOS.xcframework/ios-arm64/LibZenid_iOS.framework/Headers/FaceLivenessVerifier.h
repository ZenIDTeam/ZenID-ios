// Copyright (c) Společnost pro informační technologie a právo, s.r.o.

#pragma once

#ifndef NO_FACE

#ifndef NO_OPENCV
#include "opencv2/core.hpp"
#endif

#include "ZenidEnums.generated.h"

#include <memory>
#include <vector>
#include <cstdint>
#include <string>

namespace RecogLibC
{
enum class Orientation;
class Image;

class FaceLivenessVerifierSettings
{
public:
	// Use the pre-1.11.4 behavior: turn in any direction then smile.
	bool enableLegacyMode = false;
	// Auxiliary images will be resized to fit into this size while preserving the aspect ratio.
	int maxAuxiliaryImageSize = 300;
};

class FaceLivenessVerifier
{
   public:
	using State = FaceLivenessVerifierState;

	explicit FaceLivenessVerifier(const char* resourcesPath, const std::shared_ptr<FaceLivenessVerifierSettings>& settings = std::make_shared<FaceLivenessVerifierSettings>());
	
#ifndef NO_OPENCV
	void ProcessFrame(const cv::Mat& frame);
#endif

	void ProcessFrame(const Image& frame);

	State GetStage() const;
	
	// Only valid if the state is OK.
	const std::string& GetSignature() const;
	// Only valid if the state is OK.
	const std::vector<uint8_t>& GetSignedImage() const;

	std::vector<std::shared_ptr<std::vector<uint8_t>>> GetAuxiliaryImages() const;
	std::string GetAuxiliaryImageMetadata() const;

	// Settings that will be applied when Reset() is called.
	FaceLivenessVerifierSettings& GetSettings();
	
	void Reset();

	std::string GetRenderCommands(int width, int height, SupportedLanguages language);
	void SetDebugVisualization(bool isEnabled);

	~FaceLivenessVerifier();

   private:
	class Impl;
	std::unique_ptr<Impl> pImpl;
};
}

#endif