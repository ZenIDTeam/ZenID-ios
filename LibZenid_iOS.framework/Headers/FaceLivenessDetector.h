// Copyright (c) Společnost pro informační technologie a právo, s.r.o.

#pragma once

#include "opencv2/core.hpp"

#include "ZenidEnums.generated.h"
#include "Orientation.h"

#include <memory>

namespace RecogLibC
{
enum class Orientation;
class Image;

class FaceLivenessDetector
{
   public:
	enum class Stage
	{
		LookAtMe,
		TurnHead,
		Smile,
		Done,
	};

	explicit FaceLivenessDetector(const char* resourcesPath);

	// lbfModelContents: Buffer containing the contents of the lbfmodel.yaml.bin file.
	// lbfModelSize: Size of the lbfModelContents buffer in bytes.
	FaceLivenessDetector(const char* resourcesPath, const char* lbfModelContents, size_t lbfModelSize);

	[[deprecated(
	    "cv::Mat and OpenCV will be removed from the public interface. Use the overload taking Image instead.")]] void
	ProcessFrame(const cv::Mat& frame, Orientation faceOrientation);

	void ProcessFrame(const Image& frame, Orientation faceOrientation);

	Stage GetStage() const;
	void Reset();

	std::string GetRenderCommands(const cv::Size& canvasSize, Orientation orientation, SupportedLanguages language);
	void SetDebugVisualization(bool isEnabled);

	~FaceLivenessDetector();

   private:
	class Impl;
	std::unique_ptr<Impl> pImpl;
};
}
