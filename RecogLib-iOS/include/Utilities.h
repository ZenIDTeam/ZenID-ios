#pragma once

#include "opencv2/opencv.hpp"

namespace RecogLibC
{

enum class Orientation
{
	Up,
	Right,
	Down,
	Left
};
namespace Utilities
{

inline void Viz(const cv::Mat& mat, double scale = 1.)
{
	cv::Mat viz;
	cv::resize(mat, viz, cv::Size(), scale, scale, cv::INTER_CUBIC);
	cv::imshow("viz", viz);
	cv::waitKey();
}

inline bool Contains(const std::string& string, const std::string& searchString)
{
	return string.find(searchString) != std::string::npos;
}

inline std::array<cv::Point2f, 4> GetCorners(int cols, int rows)
{
	return std::array<cv::Point2f, 4>{
	    {{0.f, 0.f}, {(float)cols - 1.f, 0.f}, {(float)cols - 1.f, (float)rows - 1.f}, {0.f, (float)rows - 1.f}}};
}

inline std::array<cv::Point2f, 4> GetCorners(const cv::Mat& mat)
{
	return GetCorners(mat.cols, mat.rows);
}

inline std::array<cv::Point2f, 4> GetCorners(const cv::Size& size)
{
	return GetCorners(size.width, size.height);
}

inline cv::Size ComputeScalePreservingSize(const cv::Size& current, const cv::Size& max)
{
	const double num = cv::min((double)max.width / (double)current.width, (double)max.height / (double)current.height);
	return cv::Size((int)((double)current.width * num), (int)((double)current.height * num));
}

inline void ResizeForFrame(
    const cv::Mat& src, cv::Mat& dst, const cv::Size& frameSize, int interpolationMethod, bool scaleDownOnly = true)
{
	const cv::Size size(src.cols, src.rows);
	if (scaleDownOnly && size.width <= frameSize.width && size.height <= frameSize.height)
	{
		src.copyTo(dst);
		return;
	}
	const auto scalePreservingSize = ComputeScalePreservingSize(size, frameSize);
	cv::resize(src, dst, scalePreservingSize, 0., 0., interpolationMethod);
}

inline void CropToSquare(const cv::Mat& input, cv::Mat& output)
{
	if (input.cols > input.rows)
	{
		cv::Rect roi((input.cols - input.rows) / 2, 0, input.rows, input.rows);
		output = cv::Mat(input, roi);
	}
	else if (input.cols < input.rows)
	{
		cv::Rect roi(0, (input.rows - input.cols) / 2, input.cols, input.cols);
		output = cv::Mat(input, roi);
	}
	else
	{
		input.copyTo(output);
	}
}

inline bool ArePointsInBox(std::array<cv::Point2f, 4>& points, const cv::Size& boundingBox, float borderTolerance)
{
	const float hTolerance = boundingBox.width * borderTolerance;
	const float vTolerance = boundingBox.height * borderTolerance;

	return std::all_of(points.begin(), points.end(), [&](const cv::Point2f& p) {
		return p.x >= -hTolerance && p.x <= boundingBox.width + hTolerance && p.y >= -vTolerance
		       && p.y <= boundingBox.height + vTolerance;
	});
}

/* faces and cards */
inline static cv::Scalar COLOR = cv::Scalar(21, 207, 189);
inline static cv::Scalar COLOR2 = cv::Scalar(3, 85, 79);

// drawPolyLine draws a poly line by joining
// successive points between the start and end indices.
inline void drawPolyline(
    cv::Mat& im, const std::vector<cv::Point2f>& outline, const int start, const int end, bool isClosed = false)
{
	// Gather all points between the start and end indices
	std::vector<cv::Point> points;
	for (int i = start; i <= end; i++)
	{
		points.push_back(cv::Point((int)outline[i].x, (int)outline[i].y));
	}
	// Draw polylines.
	cv::polylines(im, points, isClosed, COLOR, 4, 16);
}

// draw point over the defined index
inline void drawPolyline2(cv::Mat& im, const std::vector<cv::Point2f>& outline, const int start)
{
	// Gather all points between the start and end indices
	std::vector<cv::Point> points;
	points.push_back(cv::Point((int)outline[start].x, (int)outline[start].y));
	// Draw polylines.
	cv::polylines(im, points, true, COLOR2, 10, 16);
}

inline void print_queue(std::queue<std::array<cv::Point2f, 4ULL>> q)
{
	std::cout << "QUEUE: ";
	while (!q.empty())
	{
		std::array<cv::Point2f, 4ULL> v = q.front();
		std::cout << "[" << v[0] << "|" << v[1] << "|" << v[2] << "|" << v[3] << "]"
		          << " ";
		q.pop();
	}
	std::cout << std::endl;
}

inline void Rotate(const cv::Mat& src, cv::Mat& dst, Orientation orientation)
{
	switch (orientation)
	{
		case Orientation::Up: break; // Do nothing
		case Orientation::Right:
		{
			cv::transpose(src, dst);
			cv::flip(dst, dst, -1);
			break;
		}
		case Orientation::Left:
		{
			cv::transpose(src, dst);
			break;
		}
		case Orientation::Down:
		{
			cv::flip(src, dst, 0);
			break;
		}
	}
}

inline cv::Rect ToRect(const cv::Mat& mat)
{
	return cv::Rect(0, 0, mat.cols, mat.rows);
}

inline int Area(const cv::Mat& mat)
{
	return mat.rows * mat.cols;
}

}
}