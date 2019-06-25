#pragma once

#include "Utilities.h"

#include "format.h"
#include "opencv2/core.hpp"

namespace RecogLibC
{
class SpecularImageValidator
{
   public:
	static constexpr bool Debug = false;
	int MaxSaturation = 10;
	int MinValue = 250;
	float Margin = 0.05f;

	int ValidateImage(const cv::Mat& originalInput, bool cropInput = true)
	{
		cv::Mat image = cropInput ? GetCropped(originalInput) : originalInput;

		if (image.empty()) return 0;

		Utilities::ResizeForFrame(image, image, cv::Size(100, 100), cv::INTER_LANCZOS4, true);

		cv::Mat imageHsv;
		cv::cvtColor(image, imageHsv, cv::COLOR_BGR2HSV);

		std::array<cv::Mat, 3> channels;
		cv::split(imageHsv, channels);
		cv::normalize(channels[1], channels[1], 0, 255, cv::NormTypes::NORM_MINMAX);
		cv::merge(channels, imageHsv);

		const auto binaryImage = Binarize(imageHsv, MinValue, MaxSaturation);
		return cv::countNonZero(binaryImage) == 0 ? 100 : 0;
	}

	[[nodiscard]] cv::Mat GetCropped(const cv::Mat& src) const
	{
		const auto marginAbsolute = (int)(Margin * (float)src.rows);
		const cv::Rect roi(
		    marginAbsolute, marginAbsolute, src.cols - 2 * marginAbsolute, src.rows - 2 * marginAbsolute);
		if (roi.area() <= 0) return cv::Mat();
		return src(roi);
	}

   private:
	static cv::Mat Binarize(const cv::Mat& inputHsv, int minValue, int maxSaturation)
	{
		cv::Mat mask(inputHsv.size(), CV_8UC1);
		inputHsv.forEach<cv::Vec3b>([&](const cv::Vec3b& pixel, const int* position) {
			const auto s = pixel[1];
			const auto v = pixel[2];
			mask.at<uint8_t>(position[0], position[1]) = s < maxSaturation && v > minValue ? 255 : 0;
		});

		return mask;
	}
};

}
