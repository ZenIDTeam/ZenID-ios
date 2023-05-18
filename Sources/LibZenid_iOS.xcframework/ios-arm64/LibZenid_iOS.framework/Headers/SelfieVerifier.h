#pragma once

#include "ZenidEnums.generated.h"

#include "Image.h"

#ifndef NO_OPENCV
#include <opencv2/core.hpp>
#endif

#include <memory>
#include <string>
#include <vector>
#include <cstdint>


class SelfieVerifierSettings
{
public:
	SelfieVerifierSettings() = default;
	explicit SelfieVerifierSettings(int visualizerVersion);

	// Selects the format of GetRenderCommands.
	// Version 1 is the procedural version wih semicolon-separated parameters.
	// Version 2 is JSON processed by zenid-visualizer.js
	int visualizerVersion = 2;
};

namespace RecogLibC
{
class Image;
class SelfieVerifier
{
   public:
	using State = SelfieVerifierState;
	explicit SelfieVerifier(const std::shared_ptr<SelfieVerifierSettings>& settings = std::make_shared<SelfieVerifierSettings>());
	void Load(const std::string& modelPath);
#ifndef NO_OPENCV
	void ProcessFrame(const cv::Mat& frame);
#endif
	void ProcessFrame(const Image& frame);
	State GetState() const;
	std::string GetRenderCommands(int width, int height, SupportedLanguages language) const;
	void SetDebugVisualization(bool isEnabled);
	// Only valid if the state is OK.
	const std::string& GetSignature() const;
	// Only valid if the state is OK.
	const std::vector<uint8_t>& GetSignedImage() const;
	void Reset();
	~SelfieVerifier();
	class Impl;

   private:
	std::unique_ptr<Impl> pImpl;
};

}
