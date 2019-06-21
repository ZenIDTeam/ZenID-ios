#pragma once

#include "faceidentification.h"

#include "opencv2/core.hpp"
#include <opencv2/face/facemark.hpp>
#include <opencv2/face/facemarkLBF.hpp>
#include <facemarkLBFBinary.h>

#include <memory>
#include <numeric>
#include <chrono>

namespace RecogLibC
{

class FaceLivenessDetector
{
   public:
	enum class Stage
	{
		TurnHead,
		Smile,
		Done,
	};

	FaceLivenessDetector(const char* resourcesPath)
	{
		const auto cascadePath = std::string(resourcesPath) + "/haarcascade_frontalface_alt2.xml";
		cascadeClassifier = {cascadePath};

		const auto faceMarkPath = std::string(resourcesPath) + "/lbfmodel.yaml";
		facemark = cv::face::FacemarkLBFImplBinary::createBinary();
		
		//facemark->loadModel(faceMarkPath);	
		//facemark->saveBinaryModel(faceMarkPath);
		facemark->loadBinaryModel(faceMarkPath);		
		Reset();
	}

	FaceLivenessDetector(const char* resourcesPath, const char* buffer, size_t size)
	{
		const auto cascadePath = std::string(resourcesPath) + "/haarcascade_frontalface_alt2.xml";
		cascadeClassifier = {cascadePath};

		facemark = cv::face::FacemarkLBFImplBinary::createBinary();
		facemark->loadBinaryModel(buffer, size);
		Reset();
	}

	void ProcessFrame(const cv::Mat& frame, Orientation faceOrientation)
	{
		auto faceImage = frame.clone();
		Utilities::CropToSquare(faceImage, faceImage);
		Utilities::ResizeForFrame(faceImage, faceImage, FrameSize, cv::INTER_CUBIC);

		Utilities::Rotate(faceImage, faceImage, faceOrientation);

		auto faces = Face::detectFaceHaar(cascadeClassifier, faceImage, false);
		faces = Face::getMostProbable(faces);

		if (!faces.empty())
		{
			const auto& mostProbableRect = faces[0];
			const auto facePose = Face::getFacePose(faceImage, mostProbableRect, facemark, faces, false);
			if (facePose)
			{
				UpdateState(*facePose);
			}
		}
	}

	cv::Size FrameSize = {200, 200};

	float FaceTurnAngleDegrees = 20.f;

	float SmileHysteresis = 0.4f;
	float DeltaSmileThreshold = 5.f;
	float InstantaneousSmileThreshold = 0.2f;

	int ConsecutiveFramesRequired = 2; // increase this if we have high frame rate and desire stability

	Stage GetStage() const { return stage; }

	void Reset()
	{
		stage = Stage::TurnHead;
		minYaw = std::numeric_limits<float>::max();
		maxYaw = std::numeric_limits<float>::min();
		minSmile = std::numeric_limits<float>::max();
		maxSmile = std::numeric_limits<float>::min();
		consecutiveFrameCounter = 0;
		smoothSmile = 0;
	}

   private:
	Stage stage;
	float minYaw;
	float maxYaw;
	float minSmile;
	float maxSmile;
	int consecutiveFrameCounter;
	float smoothSmile;

	cv::CascadeClassifier cascadeClassifier;
	cv::Ptr<cv::face::FacemarkLBFImplBinary> facemark;

	void UpdateState(const Face::Pose& pose)
	{
		bool success = false;
		switch (stage)
		{
			case Stage::TurnHead:
			{
				minYaw = std::min(pose.Yaw, minYaw);
				maxYaw = std::max(pose.Yaw, maxYaw);
				success = maxYaw - minYaw > FaceTurnAngleDegrees;
				break;
			}
			case Stage::Smile:
			{
				smoothSmile = smoothSmile * SmileHysteresis + (1.f - SmileHysteresis) * pose.SmileVert;

				minSmile = std::min(smoothSmile, minSmile);
				maxSmile = std::max(smoothSmile, maxSmile);

				success = maxSmile - minSmile > DeltaSmileThreshold && smoothSmile > InstantaneousSmileThreshold;
				break;
			}
			case Stage::Done: return;
		}

		if (success)
		{
			++consecutiveFrameCounter;
			if (consecutiveFrameCounter >= ConsecutiveFramesRequired)
			{
				consecutiveFrameCounter = 0;
				stage = NextStage(stage);
			}
		}
		else
		{
			consecutiveFrameCounter = 0;
		}
	}

	Stage NextStage(Stage s) const
	{
		if (s == Stage::Done) throw std::out_of_range("Tried to get the stage after Stage::Done.");
		return (Stage)((int)s + 1);
	}
};

}
