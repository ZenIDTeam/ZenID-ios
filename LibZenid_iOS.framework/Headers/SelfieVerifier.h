#pragma once

#include "ZenidEnums.generated.h"

#include "Image.h"

#ifndef NO_OPENCV
#include "opencv2/core.hpp"
#endif

#include <memory>
#include <string>

namespace RecogLibC
{
class Image;
class SelfieVerifier
{
   public:
	using State = SelfieVerifierState;
	SelfieVerifier();
	void Load(const std::string& modelPath);
#ifndef NO_OPENCV
	void ProcessFrame(const cv::Mat& frame);
#endif
	void ProcessFrame(const Image& frame);
	State GetState() const;
	std::string GetRenderCommands(int width, int height, SupportedLanguages language) const;
	void SetDebugVisualization(bool isEnabled);
	~SelfieVerifier();
	class Impl;

   private:
	std::unique_ptr<Impl> pImpl;
};

}
