#pragma once

#include "Utilities.h"

#include "opencv2/core.hpp"
#define FMT_HEADER_ONLY
#include "fmt/format.h"
#include <cmath>
#include <numeric>

namespace RecogLibC
{
class HomographyRanker
{
   public:
	static float Rank(const cv::Mat& homography,
	                  const cv::Size& observedSize,
	                  const cv::Size& modelSize,
	                  const cv::Mat& debugObservedImage = {})
	{
		double score = 0.;
		const std::array<cv::Point2f, 4> org{{
		    {0.f, 0.f},
		    {(float)modelSize.width, 0.f},
		    {(float)modelSize.width, (float)modelSize.height},
		    {0.f, (float)modelSize.height},
		}};

		std::array<cv::Point2f, 4> pts;
		cv::perspectiveTransform(org, pts, homography);

		if (debugLevel > 1 && !debugObservedImage.empty())
		{
			auto rankOutline = debugObservedImage.clone();
			std::array<cv::Point, 4> outline;
			std::transform(pts.begin(), pts.end(), outline.begin(), [&](const auto& point) {
				return cv::Point{(int)(point.x), (int)(point.y)};
			});
			cv::polylines(rankOutline, outline, true, cv::Scalar(255, 255, 0), 2);
			Utilities::ResizeForFrame(rankOutline, rankOutline, cv::Size(1000, 1000), cv::INTER_CUBIC);
			cv::imshow("Homography Rank", rankOutline);
			cv::waitKey(1);
		}

		if (!Utilities::ArePointsInBox(pts, observedSize, 0.2f))
		{
			return 0.f;
		}

		// calculate side vectors
		const cv::Vec2f v1 = pts[1] - pts[0];
		const cv::Vec2f v2 = pts[2] - pts[1];
		const cv::Vec2f v3 = pts[3] - pts[2];
		const cv::Vec2f v4 = pts[0] - pts[3];

		// calculate size ratios (w/h)
		const auto sizeRatioOriginal = modelSize.width / (float)modelSize.height;
		const auto sizeRatioProjected = (float)((norm(v1) + norm(v3)) / (norm(v2) + norm(v4)));
		const auto sizeRatioDifference = std::abs(sizeRatioOriginal - sizeRatioProjected);

		static constexpr float maxSizeRatioDifference = 2.f;
		if (sizeRatioDifference > maxSizeRatioDifference) return 2.f;

		const auto sizeSymmetryError = (float)std::min(RatioDiff(norm(v1), norm(v3)), RatioDiff(norm(v2), norm(v4)));
		constexpr float maxSizeSymmetryError = 1.f;
		if (sizeSymmetryError > maxSizeSymmetryError)
		{
			return 0.f;
		}

		// calculate angles
		const auto a1 = ToDegrees(SignedAngleToRadians(v4, v1, false));
		const auto a2 = ToDegrees(SignedAngleToRadians(v1, v2, false));
		const auto a3 = ToDegrees(SignedAngleToRadians(v2, v3, false));
		const auto a4 = ToDegrees(SignedAngleToRadians(v3, v4, false));

		// check angles being too small/big for rectangle
		const double maxAngleTolerance = 50;
		const auto angles = std::array<float, 4>{a1, a2, a3, a4};
		if (std::any_of(angles.begin(), angles.end(), [&](float x) {
			    return (x > 90.f + maxAngleTolerance) || (x < 90.f - maxAngleTolerance);
		    }))
		{
			return 0.f;
		}

		// calculate total angle difference from rectangle
		const auto angleDiff = std::accumulate(
		    angles.begin(), angles.end(), 0.f, [&](float acc, float x) { return acc + std::abs(x - 90.f); });

		// calculate angle symmetry
		const auto da1 = std::abs(a1 - a2);
		const auto da2 = std::abs(a2 - a3);
		const auto da3 = std::abs(a3 - a4);
		const auto da4 = std::abs(a4 - a1);

		float angleSymmetryError;
		if (da1 + da3 < da2 + da4)
		{
			angleSymmetryError = std::max(da1, da3);
		}
		else
		{
			angleSymmetryError = std::max(da2, da4);
		}

		static constexpr float maxAngleSymmetryError = 30.f;
		if (angleSymmetryError > maxAngleSymmetryError)
		{
			return 0.f;
		}

		const auto projArea = Area(pts);
		const auto areaRatio = projArea / (observedSize.width * observedSize.height);

		// check area ratio being too small/big
		const auto minArea = 0.02f;
		const auto maxArea = 1.7f;
		// if ((areaRatio < minArea) || (areaRatio > maxArea)) return 0.f;

		// Compute composite rank
		{
			const auto area = Rank(areaRatio, 1.f, 0.5f);
			const auto angleSymmetry = Rank(angleSymmetryError, 0.f, maxAngleSymmetryError);
			const auto angleDifference = Rank(angleDiff, 0.f, 40.f);
			const auto sizeRatio = Rank(sizeRatioDifference, 0.f, maxSizeRatioDifference);
			const auto sizeSymmetry = Rank(sizeSymmetryError, 0.f, maxSizeSymmetryError);

			const auto totalScore = 1.f + angleSymmetry * 20.f + angleDifference * 20.f + area * 20.f + sizeRatio * 20.f
			                        + sizeSymmetry * 20.f;

			if (debugLevel > 0)
			{
				fmt::print(
				    "Total: {:.2f}, AngleSym: {:.2f}, AngleDiff: {:.2f}, Area: {:.2f}, SizeRatio: {:.2f}, SizeSym: "
				    "{:.2f}\n",
				    totalScore,
				    angleSymmetry,
				    angleDifference,
				    area,
				    sizeRatio,
				    sizeSymmetry);
			}

			return totalScore;
		}
	}

   private:
	static constexpr int debugLevel = 0;

	static float Rank(float value, float optimum, float cutOffDistance)
	{
		const float distance = std::abs(value - optimum);
		if (distance >= cutOffDistance) return 0.f;
		return 1.f - distance / cutOffDistance;
	}

	template <class number_type>
	static number_type RatioDiff(number_type v1, number_type v2)
	{
		return v1 > v2 ? v1 / v2 - 1 : v2 / v1 - 1;
	}

	static float Area(const std::array<cv::Point2f, 4>& pts)
	{
		auto sum = 0.f;
		std::array<cv::Point2f, 5> v{{pts[0], pts[1], pts[2], pts[3], pts[0]}};

		for (int i = 0; i < 4; ++i)
		{
			sum += v[i].x * v[i + 1].y - v[i].y * v[i + 1].x;
		}

		return std::abs(sum / 2.f);
	}

	static float ToDegrees(float angleRadians) { return angleRadians / (float)CV_PI * 180.f; }

	static float SignedAngleToRadians(const cv::Vec2f& v1,
	                                  const cv::Vec2f& v2,
	                                  bool clockWise,
	                                  bool returnNegative = false)
	{
		const float sign = clockWise ? -1.f : 1.f;
		auto num2 = std::atan2(v1[1], v1[0]);
		if (num2 < 0.0)
		{
			num2 += 2.f * (float)CV_PI;
		}
		auto num3 = std::atan2(v2[1], v2[0]);
		if (num3 < 0.f)
		{
			num3 += 2.f * (float)CV_PI;
		}
		auto radians = sign * (num3 - num2);
		if (radians < 0.f && !returnNegative)
		{
			radians += 2.f * (float)CV_PI;
		}
		if (radians > (float)CV_PI && returnNegative)
		{
			radians -= 2.f * (float)CV_PI;
		}
		return radians;
	}
};
}
