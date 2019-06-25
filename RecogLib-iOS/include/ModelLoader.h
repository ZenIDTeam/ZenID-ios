#pragma once

#include "ProcModel.h"
#include "opencv2/opencv.hpp"

#include <exception>
#include <sstream>
#include <fstream>

namespace RecogLibC
{

class ModelLoader
{

   public:
	static constexpr int Version = 0;

	using ModelList = std::vector<std::unique_ptr<const ProcModel>>;

	static std::shared_ptr<ModelList> LoadModels(const std::string& resourcesRootPath)
	{
		auto models = std::make_shared<std::vector<std::unique_ptr<const ProcModel>>>();
		for (const auto& fileName : modelFileNames)
		{
			std::ifstream fileStream{resourcesRootPath + "/" + fileName, std::fstream::binary};
			models->emplace_back(LoadModel(fileStream));
		}
		return models;
	}

	static std::unique_ptr<ProcModel> LoadModel(std::istream& input)
	{
		// Header
		const auto fileVersion = ReadNumber<int>(input);
		if (fileVersion != Version) throw std::exception();

		// Descriptors
		auto descriptors = LoadDescriptors(input);

		// Key Points
		const auto keyPointCount = ReadNumber<int>(input);
		std::vector<cv::KeyPoint> keyPoints(keyPointCount);
		for (int i = 0; i < keyPointCount; ++i)
		{
			auto& keyPoint = keyPoints[i];
			ReadNumber(input, keyPoint.pt.x);
			ReadNumber(input, keyPoint.pt.y);
			ReadNumber(input, keyPoint.size);
			ReadNumber(input, keyPoint.angle);
			ReadNumber(input, keyPoint.response);
			ReadNumber(input, keyPoint.octave);
			ReadNumber(input, keyPoint.class_id);
		}

		// Metadata
		const auto hessianThreshold = ReadNumber<float>(input);
		const auto modelWidth = ReadNumber<int>(input);
		const auto modelHeight = ReadNumber<int>(input);
		const auto modelToOcrRatio = ReadNumber<float>(input);
		const auto documentCode = ReadNumber<int>(input);
		const auto pageCode = ReadNumber<int>(input);
		const auto documentRole = ReadNumber<int>(input);
		const auto country = ReadNumber<int>(input);

		const cv::Vec2i modelSize{(int)modelWidth, (int)modelHeight};
		FeatureModel featureModel(std::move(descriptors), std::move(keyPoints));
		return std::make_unique<ProcModel>(hessianThreshold,
		                                   std::move(featureModel),
		                                   modelSize,
		                                   modelToOcrRatio,
		                                   static_cast<DocumentCodes>(documentCode),
		                                   static_cast<PageCodes>(pageCode),
		                                   static_cast<DocumentRole>(documentRole),
		                                   static_cast<Country>(country));
	}

	static std::unique_ptr<ProcModel> LoadModel(const char* buffer, size_t size)
	{
		MemoryStream memoryStream(buffer, size);
		return LoadModel(memoryStream);
	}

		struct MemoryBuffer : std::streambuf
	{
		MemoryBuffer(char const* base, size_t size)
		{
			char* p(const_cast<char*>(base));
			this->setg(p, p, p + size);
		}
	};

	struct MemoryStream : virtual MemoryBuffer, std::istream
	{
		MemoryStream(char const* base, size_t size)
		    : MemoryBuffer(base, size), std::istream(static_cast<std::streambuf*>(this))
		{
		}
	};

   private:

	inline static const std::vector<std::string> modelFileNames = {
	    "recoglibc_DRV_F.bin",
	    "recoglibc_IDC1_B.bin",
	    "recoglibc_IDC1_F.bin",
	    "recoglibc_IDC2_B.bin",
	    "recoglibc_IDC2_F.bin",
	    "recoglibc_PAS_F.bin"
	};

	template <class number_type>
	static number_type ReadNumber(std::istream& input)
	{
		number_type temp;
		ReadNumber(input, temp);
		return temp;
	}

	template <class number_type>
	static void ReadNumber(std::istream& input, number_type& number)
	{
		input.read((char*)&number, sizeof(decltype(number)));
	}

	static cv::Mat LoadDescriptors(std::istream& input)
	{
		const auto rows = ReadNumber<int>(input);
		static constexpr int cols = 64;
		const auto type = CV_32FC1;
		cv::Mat mat = cv::Mat::zeros(rows, cols, type);
		input.read((char*)mat.data, CV_ELEM_SIZE(type) * rows * cols);
		return mat;
	}
};
}
