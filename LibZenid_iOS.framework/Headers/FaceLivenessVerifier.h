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

class FaceLivenessVerifier
{
   public:
	using State = FaceLivenessVerifierState;

	explicit FaceLivenessVerifier(const char* resourcesPath);

	// lbfModelContents: Buffer containing the contents of the lbfmodel.yaml.bin file.
	// lbfModelSize: Size of the lbfModelContents buffer in bytes.
	FaceLivenessVerifier(const char* resourcesPath, const char* lbfModelContents, size_t lbfModelSize);

#ifndef NO_OPENCV
	void ProcessFrame(const cv::Mat& frame);
#endif

	void ProcessFrame(const Image& frame);

	State GetStage() const;
	
	// Only valid if the state is OK.
	const std::string& GetSignature() const;
	// Only valid if the state is OK.
	const std::vector<uint8_t>& GetSignedImage() const;
	
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