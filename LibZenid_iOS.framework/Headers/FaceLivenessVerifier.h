// Copyright (c) Společnost pro informační technologie a právo, s.r.o.

#pragma once

#ifndef NO_FACE

#include "opencv2/core.hpp"

#include "ZenidEnums.generated.h"

#include <memory>

namespace RecogLibC
{
enum class Orientation;
class Image;

class FaceLivenessVerifier
{
   public:
	using Stage = FaceLivenessVerifierStage;

	explicit FaceLivenessVerifier(const char* resourcesPath);

	// lbfModelContents: Buffer containing the contents of the lbfmodel.yaml.bin file.
	// lbfModelSize: Size of the lbfModelContents buffer in bytes.
	FaceLivenessVerifier(const char* resourcesPath, const char* lbfModelContents, size_t lbfModelSize);

	[[deprecated(
	    "cv::Mat and OpenCV will be removed from the public interface. Use the overload taking Image instead.")]] void
	ProcessFrame(const cv::Mat& frame);

	void ProcessFrame(const Image& frame);

	Stage GetStage() const;
	void Reset();

	std::string GetRenderCommands(const cv::Size& canvasSize, SupportedLanguages language);
	void SetDebugVisualization(bool isEnabled);

	~FaceLivenessVerifier();

   private:
	class Impl;
	std::unique_ptr<Impl> pImpl;
};
}

#endif