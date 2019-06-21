#pragma once

#include <vector>
#include "opencv2/opencv.hpp"
#include "ZenidEnums.generated.h"

namespace RecogLibC
{

class FeatureModel
{
   public:
	FeatureModel(cv::Mat descriptors, std::vector<cv::KeyPoint> keyPoints)
	    : descriptors(std::move(descriptors)), keyPoints(std::move(keyPoints))
	{
	}

	const cv::Mat& GetDescriptors() const { return descriptors; }
	const std::vector<cv::KeyPoint>& GetKeyPoints() const { return keyPoints; }

   private:
	cv::Mat descriptors;
	std::vector<cv::KeyPoint> keyPoints;
};

class ProcModel
{
   public:
	ProcModel(float hessianThreshold,
	          FeatureModel uprightSurfModel,
	          const cv::Vec2i& modelSize,
	          float modelToOcrRatio,
	          DocumentCodes documentCode,
	          PageCodes pageCode,
	          DocumentRole documentRole,
	          Country country)
	    : hessianThreshold(hessianThreshold),
	      uprightSurfModel(std::move(uprightSurfModel)),
	      modelSize(modelSize),
	      documentCode(documentCode),
	      pageCode(pageCode),
		  documentRole(documentRole),
		  country(country)
	{
	}

	float GetHessianThreshold() const { return hessianThreshold; }
	const FeatureModel& GetUprightSurfModel() const { return uprightSurfModel; }
	const cv::Size& GetModelSize() const { return modelSize; }
	DocumentCodes GetDocumentCode() const { return documentCode; }
	PageCodes GetPageCode() const { return pageCode; }
	DocumentRole GetDocumentRole() const { return documentRole; }
	Country GetCountry() const { return country; }

   private:
	float hessianThreshold;
	FeatureModel uprightSurfModel;
	cv::Size modelSize;
	DocumentCodes documentCode;
	PageCodes pageCode;
	DocumentRole documentRole;
	Country country;
};

}
