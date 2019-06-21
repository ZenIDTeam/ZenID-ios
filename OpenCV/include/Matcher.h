#pragma once

#include "ZenidEnums.generated.h"
#include "Utilities.h"
#include "Transform.h"
#include "HomohgraphyRank.h"
#include "ProcModel.h"

#include "opencv2/opencv.hpp"
#include "opencv2/xfeatures2d/nonfree.hpp"
#include "opencv2/features2d.hpp"

#include <cmath>
#include <optional>
#include <memory>
#include <vector>

namespace RecogLibC
{

class MatchResult
{

   public:
	DocumentCodes DocumentCode;
	PageCodes PageCode;
	cv::Size ProjectedSize;
	std::array<cv::Point2f, 4> Outline;  // Outline in relative coordinates (0 to 1)
	std::array<cv::Point2f, 4> OutlineAbsolute; 	// outline in absolute coordinates
	float Score = 0.f;     // If the score is 0, all other fields are invalid.
	cv::Vec2f TiltRadians; // Not implement yet
	cv::Mat Transform;
	cv::Mat ObservedImage;
	float StabilityScore = 0.f;
	float LinearFitFraction = 0.f; // linear coverage of the card. If the card takes 50 pixels out of 100 image in it's best direciton, result is 0.5
	float MinBorderDistance = 0.f; // minimum border of the edge of the card from picture edge. If it's negative, card is outside the screen

	const cv::Mat& ProjectedImage() const
	{
		if (projectedImage.empty())
			cv::warpPerspective(
			    ObservedImage, projectedImage, Transform, ProjectedSize, cv::INTER_CUBIC | cv::WARP_INVERSE_MAP);

		return projectedImage;
	}

   private:
	mutable cv::Mat projectedImage;
};

class Matcher
{
   public:
	Matcher(std::shared_ptr<std::vector<std::unique_ptr<const ProcModel>>> models) : models(std::move(models)) {}

	// expectedOutline is in relative coordinates (0 to 1)
	std::optional<MatchResult> Match(const cv::Mat& observedImage,
	                                 const std::array<cv::Point2f, 4>& expectedOutline,
	                                 const std::optional<DocumentRole> documentRole = {},
	                                 const std::optional<PageCodes> pageCode = {},
	                                 const std::optional<Country> country = {})
	{
		cv::Mat cropped;
		cv::Mat trans;
		if (!PrepareImage(observedImage, expectedOutline, cropped, trans))
		{
			// The image could not be prepared because it was unsuitable for tracking.
			LastMatch = {};
			return {};
		}

		std::vector<cv::KeyPoint> observedKeyPoints;
		cv::Mat observedDescriptors;
		const auto feature2D = cv::xfeatures2d::SURF::create(100, 4, 2, useExtended, useUpright);
		feature2D->detectAndCompute(cropped, cv::noArray(), observedKeyPoints, observedDescriptors);

		const ProcModel* lastMatchModel = FindLastMatchModel();
		if (VerifyModel(lastMatchModel, documentRole, pageCode, country))
		{
			// Use information from the previous match.
			auto match = MatchPrepared(
			    trans, LastMatch->Outline, observedKeyPoints, observedDescriptors, *lastMatchModel, observedImage);
			if (match.has_value() && match->Score > scoreRequiredForMatch)
			{
				match->StabilityScore = ComputeStabilityScore(*LastMatch, *match);
				LastMatch = match;
				return match;
			}
		}

		// No valid previous match. Start over.
		for (const std::unique_ptr<const ProcModel>& model : *models)
		{
			if (!VerifyModel(model.get(), documentRole, pageCode, country)) continue;
			const auto& match =
			    MatchPrepared(trans, expectedOutline, observedKeyPoints, observedDescriptors, *model, observedImage);
			if (match.has_value() && match->Score > scoreRequiredForMatch)
			{
				LastMatch = match;
				return match;
			}
		}

		LastMatch = {};
		return {}; // No match found.
	}

	std::optional<MatchResult> LastMatch;

   private:
	std::shared_ptr<const std::vector<std::unique_ptr<const ProcModel>>> models;

	static constexpr float stabilityHysteresis = 0.0f;
	static constexpr float scoreRequiredForMatch = 50.f;
	static constexpr bool useUpright = true;
	static constexpr bool useExtended = false;
	static constexpr cv::InterpolationFlags interpolation = cv::INTER_CUBIC;
	static constexpr float zoomScale = 0.9f;
	static constexpr float uniquenessThreshold = 0.8f;
	static constexpr float voteScaleIncrement = 1.5f;
	static constexpr int32_t voteRotationBins = 20;
	static constexpr int32_t ransacReprojThreshold = 2;
	static constexpr int32_t k = 2;
	static constexpr float flannKeyPointThreshold = 10e7f;
	inline static const cv::Size minCroppedSize = {100, 100};

	static float ComputeStabilityScore(const MatchResult& lastMatch, const MatchResult& newMatch)
	{
		const auto distance = DistanceBetweenOutlines(newMatch.Outline, lastMatch.Outline);
		const auto frameStability = std::max(100.f - distance * 1e5f, 0.f);
		return lastMatch.StabilityScore * stabilityHysteresis + frameStability * (1.f - stabilityHysteresis);
	}

	static float GetDistanceSquared(const cv::Point2f& a, const cv::Point2f b)
	{
		return (a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y);
	}

	static float DistanceBetweenOutlines(const std::array<cv::Point2f, 4>& a, const std::array<cv::Point2f, 4>& b)
	{
		float distance = 0.f;
		for (size_t i = 0; i < 4; ++i)
		{
			distance += GetDistanceSquared(a[i], b[i]);
		}
		return distance;
	}

	const ProcModel* FindLastMatchModel() const
	{
		if (!LastMatch.has_value()) return nullptr;
		const auto it = std::find_if(models->begin(), models->end(), [&](const auto& model) {
			return model->GetDocumentCode() == LastMatch->DocumentCode && model->GetPageCode() == LastMatch->PageCode;
		});
		if (it == models->end()) return nullptr;
		return it->get();
	}

	bool VerifyModel(const ProcModel* lastMatchModel,
	                 const std::optional<DocumentRole> documentRole,
	                 const std::optional<PageCodes> pageCode,
	                 const std::optional<Country> country) const
	{
		if (!lastMatchModel) return false;
		if (documentRole && *documentRole != lastMatchModel->GetDocumentRole()) return false;
		if (pageCode && *pageCode != lastMatchModel->GetPageCode()) return false;
		if (country && *country != lastMatchModel->GetCountry()) return false;
		return true;
	}

	std::optional<MatchResult> MatchPrepared(const cv::Mat& croppedTransform,
	                                         const std::array<cv::Point2f, 4>& expectedOutline,
	                                         const std::vector<cv::KeyPoint>& observedKeyPoints,
	                                         const cv::Mat& observedDescriptors,
	                                         const ProcModel& model,
	                                         const cv::Mat& observedImage) const
	{
		const auto& modelKeyPoints = model.GetUprightSurfModel().GetKeyPoints();
		const auto& modelDescriptors = model.GetUprightSurfModel().GetDescriptors();

		std::unique_ptr<cv::DescriptorMatcher> matcher;
		if ((float)observedDescriptors.rows * (float)modelDescriptors.rows < flannKeyPointThreshold)
		{
			matcher = std::make_unique<cv::BFMatcher>(cv::NORM_L1);
		}
		else
		{
			matcher = std::make_unique<cv::FlannBasedMatcher>();
		}

		matcher->add(modelDescriptors);
		std::vector<std::vector<cv::DMatch>> matches;
		matcher->knnMatch(observedDescriptors, matches, k);

		cv::Mat mask((int)matches.size(), 1, CV_8UC1);
		mask.setTo(cv::Scalar(255));

		PerformRatioTest(matches, mask);
		if (cv::countNonZero(mask) < 4)
		{
			return {}; // Not enough unique features.
		}

		if (VoteForSizeAndOrientation(modelKeyPoints, observedKeyPoints, matches, mask) < 4)
		{
			return {}; // Not enough unique features.
		}

		std::vector<cv::Point2f> sourcePoints;
		std::vector<cv::Point2f> destinationPoints;

		// Apply mask
		for (int i = 0; i < mask.rows; i++)
		{
			if (!mask.at<uint8_t>(i)) continue;
			const auto modelIndex = matches.at(i).at(0).trainIdx;
			sourcePoints.push_back(modelKeyPoints[modelIndex].pt);
			destinationPoints.push_back(observedKeyPoints[i].pt);
		}

		const cv::Mat surfTransform =
		    cv::findHomography(cv::Mat(sourcePoints), cv::Mat(destinationPoints), cv::RANSAC, ransacReprojThreshold);
		if (surfTransform.empty())
		{
			return {}; // No homography found.
		}

		const cv::Mat sourceToProjected = croppedTransform * surfTransform;

		const auto observedImageCorners = Utilities::GetCorners(model.GetModelSize());

		std::array<cv::Point2f, 4> trackedOutlineAbsolute;
		cv::perspectiveTransform(observedImageCorners, trackedOutlineAbsolute, sourceToProjected);

		auto trackedOutlineRelative = ToRelativeOutline(trackedOutlineAbsolute, observedImage.size());

		MatchResult result;
		result.ObservedImage = observedImage;
		result.DocumentCode = model.GetDocumentCode();
		result.PageCode = model.GetPageCode();
		result.ProjectedSize = model.GetModelSize();
		std::copy(trackedOutlineRelative.begin(), trackedOutlineRelative.end(), result.Outline.begin());
		std::copy(trackedOutlineAbsolute.begin(), trackedOutlineAbsolute.end(), result.OutlineAbsolute.begin());

		// calculate min distance from border (negative if outside observed) and linera size
		float width = observedImage.cols;
		float height = observedImage.rows;
		float borderDistance = std::max(width, height);

		float minX = std::numeric_limits<float>::max();
		float maxX = std::numeric_limits<float>::min();
		float minY = std::numeric_limits<float>::max();
		float maxY = std::numeric_limits<float>::min();

		for (const auto& outlinePoint : trackedOutlineAbsolute)
		{
			minX = std::min(minX, outlinePoint.x);
			minY = std::min(minY, outlinePoint.y);
			maxX = std::max(maxX, outlinePoint.x);
			maxY = std::max(maxY, outlinePoint.y);

			borderDistance = std::min(borderDistance, outlinePoint.x);
			borderDistance = std::min(borderDistance, width - outlinePoint.x);
			borderDistance = std::min(borderDistance, outlinePoint.y);
			borderDistance = std::min(borderDistance, height - outlinePoint.y);
		}
		result.MinBorderDistance = borderDistance;
		result.LinearFitFraction = std::max((maxX - minX) / width, (maxY - minY) / height);
		
		result.Transform = sourceToProjected;
		result.Score = HomographyRanker::Rank(
		    sourceToProjected, cv::Size(observedImage.cols, observedImage.rows), model.GetModelSize(), observedImage);

		return result;
	}

	void PerformRatioTest(const std::vector<std::vector<cv::DMatch>>& matches, cv::Mat& mask) const
	{
		for (int i = 0; i < (int)matches.size(); ++i)
		{
			if (mask.at<uint8_t>(i) == 0) continue;
			assert(matches[i].size() == 2);
			const auto dist0 = matches[i][0].distance;
			const auto dist1 = matches[i][1].distance;
			assert(dist0 <= dist1);
			if (dist0 < dist1 * uniquenessThreshold) continue;
			mask.at<uint8_t>(i) = 0;
		}
	}

	int VoteForSizeAndOrientation(const std::vector<cv::KeyPoint>& modelKeyPoints,
	                              const std::vector<cv::KeyPoint>& observedKeyPoints,
	                              const std::vector<std::vector<cv::DMatch>>& matches,
	                              cv::Mat& mask) const
	{
		std::vector<float> logScale;
		std::vector<float> rotations;
		float maxS = -1.0e-10f;
		float minS = 1.0e10f;

		for (int i = 0; i < mask.rows; ++i)
		{
			if (mask.at<uint8_t>(i, 0))
			{
				const cv::KeyPoint& observedKeyPoint = observedKeyPoints.at(i);
				const cv::KeyPoint& modelKeyPoint = modelKeyPoints.at(matches.at(i).at(0).trainIdx);
				float s = log10(observedKeyPoint.size / modelKeyPoint.size);
				logScale.push_back(s);
				maxS = s > maxS ? s : maxS;
				minS = s < minS ? s : minS;

				float r = observedKeyPoint.angle - modelKeyPoint.angle;
				r = r < 0.0f ? r + 360.0f : r;
				rotations.push_back(r);
			}
		}

		int scaleBinSize = cvCeil((maxS - minS) / log10(voteScaleIncrement));
		if (scaleBinSize < 2) scaleBinSize = 2;
		float scaleRanges[] = {minS, (float)(minS + scaleBinSize * log10(voteScaleIncrement))};

		cv::Mat_<float> scalesMat(logScale);
		cv::Mat_<float> rotationsMat(rotations);
		std::vector<float> flags(logScale.size());
		cv::Mat flagsMat(flags);

		int histSize[] = {scaleBinSize, voteRotationBins};
		float rotationRanges[] = {0, 360};
		int channels[] = {0, 1};
		const float* ranges[] = {scaleRanges, rotationRanges};
		double minVal, maxVal;

		const cv::Mat_<float> arrs[] = {scalesMat, rotationsMat};

		cv::MatND hist; // CV_32S
		cv::calcHist(arrs, 2, channels, cv::Mat(), hist, 2, histSize, ranges, true);
		cv::minMaxLoc(hist, &minVal, &maxVal);

		cv::threshold(hist, hist, maxVal * 0.5, 0, cv::THRESH_TOZERO);
		cv::calcBackProject(arrs, 2, channels, hist, flagsMat, ranges);

		int index = 0;
		int nonZeroCount = 0;
		for (int i = 0; i < mask.rows; i++)
		{
			if (mask.at<uint8_t>(i, 0))
			{
				if (flags[index++] != 0.0f)
					nonZeroCount++;
				else
					mask.at<uint8_t>(i, 0) = 0;
			}
		}
		return nonZeroCount;
	}

	static bool PrepareImage(const cv::Mat& observedImage,
	                         const std::array<cv::Point2f, 4>& expectedOutline,
	                         cv::Mat& croppedImage,
	                         cv::Mat& transform)
	{
		auto widthTolerance = 0.1f;
		auto heightTolerance = 0.1f;

		auto width = (float)observedImage.cols;
		auto height = (float)observedImage.rows;
		auto minx = (cv::min(expectedOutline[0].x, expectedOutline[2].x) - widthTolerance) * width;
		auto miny = (cv::min(expectedOutline[0].y, expectedOutline[1].y) - heightTolerance) * height;
		auto maxx = (cv::max(expectedOutline[1].x, expectedOutline[3].x) + widthTolerance) * width;
		auto maxy = (cv::max(expectedOutline[2].y, expectedOutline[3].y) + heightTolerance) * height;
		if (minx < 0) minx = 0;
		if (miny < 0) miny = 0;
		if (maxx > width) maxx = width;
		if (maxy > height) maxy = height;
		cv::Rect roi((int)minx, (int)miny, (int)(maxx - minx), (int)(maxy - miny));

		cv::Mat cropped = observedImage(roi);

		if (cropped.size[0] < minCroppedSize.width || cropped.size[1] < minCroppedSize.height)
		{
			return false; // Image is unsuitable
		}

		auto trans = Transform::Translation(minx, miny);

		float maxWidth = 800.0; // model.GetModelSize().width  determine optimum max size

		if (roi.width > maxWidth)
		{
			float dsc = maxWidth / (float)roi.width;
			trans = trans * Transform::Scale(1.f / dsc, 1.f / dsc);
			cv::resize(cropped, cropped, cv::Size(), dsc, dsc, cv::INTER_CUBIC);
		}

		cv::cvtColor(cropped, cropped, cv::COLOR_BGR2GRAY);

		croppedImage = cropped;
		transform = trans;

		return true; // Prepare was successful
	}

	static std::array<cv::Point2f, 4> ToAbsoluteOutline(const std::array<cv::Point2f, 4>& relative, cv::Size size)
	{
		std::array<cv::Point2f, 4> absolute;

		std::transform(relative.begin(), relative.end(), absolute.begin(), [&](const cv::Point2f& point) {
			return cv::Point2f{point.x * size.width, point.y * size.height};
		});

		return absolute;
	}

	static std::array<cv::Point2f, 4> ToRelativeOutline(const std::array<cv::Point2f, 4>& absolute, cv::Size size)
	{
		std::array<cv::Point2f, 4> relative;
		std::transform(absolute.begin(), absolute.end(), relative.begin(), [&](const cv::Point2f& point) {
			return cv::Point2f{point.x / (float)size.width, point.y / (float)size.height};
		});
		return relative;
	}
};
}
