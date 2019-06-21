#pragma once

#include <cstdint>
#include "opencv2/opencv.hpp"

namespace RecogLibC
{

class BlurValidator
{
   public:
	float SharpnessForScore0 = 1.5f;
	float SharpnessForScore100 = 6.f;

	// this returns score from 0 to 100, 100 being max sharp
	int32_t GetSharpness(const cv::Mat& projectedImage) const
	{
		cv::Mat gray;
		cvtColor(projectedImage, gray, cv::COLOR_BGR2GRAY);
		
		cv::Mat canny;
		Canny(gray, canny, 225, 175);

		const auto nonZero = countNonZero(canny);
		const double dSharpness = (nonZero * 1000.0 / (canny.cols * canny.rows));
		
		if (dSharpness < SharpnessForScore0) return 0;
		if (dSharpness > SharpnessForScore100) return 100;

		const auto score = (int)(100.0 * (dSharpness - SharpnessForScore0) / (SharpnessForScore100 - SharpnessForScore0));
		return score;
	}
};

}
