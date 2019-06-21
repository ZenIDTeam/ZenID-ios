#pragma once
#include "Utilities.h"
#include "Transform.h"

#include "opencv2/core.hpp"
#include "opencv2/face/facemark.hpp"

#include <vector>
#include <optional>


namespace RecogLibC
{

namespace Face
{

inline std::vector<cv::Rect> detectFaceHaar(cv::CascadeClassifier& detector, const cv::Mat& image, bool draw)
{
	std::vector<cv::Rect> faces;
	cv::Mat gray;
	// Convert frame to grayscale because
	// faceDetector requires grayscale image.
	cv::cvtColor(image, gray, cv::ColorConversionCodes::COLOR_BGR2GRAY);

	// Detect faces
	detector.detectMultiScale(gray, faces);
	if (draw)
	{
		cv::Rect best = faces.front();
		if (best.width != 0 && best.height != 0)
		{
			cv::rectangle(image,
			              cv::Point(best.x, best.y),
			              cv::Point(best.x + best.width, best.y + best.height),
			              cv::Scalar(0, 200, 0),
			              2,
			              4);
		}
	}
	return faces;
}

inline void drawLandmarks(cv::Mat& im, std::vector<cv::Point2f>& landmarks)
{
	// Draw face for the 68-point model.
	if (landmarks.size() == 68)
	{
		Utilities::drawPolyline(im, landmarks, 0, 16);        // Jaw line
		Utilities::drawPolyline(im, landmarks, 17, 21);       // Left eyebrow
		Utilities::drawPolyline(im, landmarks, 22, 26);       // Right eyebrow
		Utilities::drawPolyline(im, landmarks, 27, 30);       // Nose bridge
		Utilities::drawPolyline(im, landmarks, 30, 35, true); // Lower nose
		Utilities::drawPolyline(im, landmarks, 36, 41, true); // Left eye
		Utilities::drawPolyline(im, landmarks, 42, 47, true); // Right Eye
		Utilities::drawPolyline(im, landmarks, 48, 59, true); // Outer lip
		Utilities::drawPolyline(im, landmarks, 60, 67, true); // Inner lip

		Utilities::drawPolyline2(im, landmarks, 30); // Nose tip
		Utilities::drawPolyline2(im, landmarks, 8);  // Chin
		Utilities::drawPolyline2(im, landmarks, 36); // Left eye left corner
		Utilities::drawPolyline2(im, landmarks, 45); // Right eye right corner
		Utilities::drawPolyline2(im, landmarks, 48); // Left Mouth corner
		Utilities::drawPolyline2(im, landmarks, 57); // middle
		Utilities::drawPolyline2(im, landmarks, 66); // middle a
		Utilities::drawPolyline2(im, landmarks, 54); // Right mouth corner
	}
	else
	{ // If the number of points is not 68, we do not know which
		// points correspond to which facial features. So, we draw
		// one dot per landamrk.
		for (int i = 0; i < landmarks.size(); i++)
		{
			circle(im, landmarks[i], 3, Utilities::COLOR, cv::FILLED);
		}
	}
}

inline cv::Vec3d getAngles_pitch_yaw_roll(cv::Mat& im, std::vector<cv::Point2f>& landmarks, bool debug = false)
{
	std::vector<cv::Point3d> model_points;
	std::vector<cv::Point2d> image_points;
	// 3D model points.
	model_points.push_back(cv::Point3d(0.0f, 0.0f, 0.0f));          // Nose tip
	model_points.push_back(cv::Point3d(0.0f, -330.0f, -65.0f));     // Chin
	model_points.push_back(cv::Point3d(-225.0f, 170.0f, -135.0f));  // Left eye left corner
	model_points.push_back(cv::Point3d(225.0f, 170.0f, -135.0f));   // Right eye right corner
	model_points.push_back(cv::Point3d(-150.0f, -150.0f, -125.0f)); // Left Mouth corner
	model_points.push_back(cv::Point3d(150.0f, -150.0f, -125.0f));  // Right mouth corner

	// 2D image points. If you change the image, you need to change vector
	image_points.push_back(landmarks[30]); // Nose tip
	image_points.push_back(landmarks[8]);  // Chin
	image_points.push_back(landmarks[36]); // Left eye left corner
	image_points.push_back(landmarks[45]); // Right eye right corner
	image_points.push_back(landmarks[48]); // Left Mouth corner
	image_points.push_back(landmarks[54]); // Right mouth corner

	cv::Mat camera_matrix;
	Transform::GetCameraMatrix(im, camera_matrix);
	cv::Mat dist_coeffs = cv::Mat::zeros(4, 1, cv::DataType<double>::type); // Assuming no lens distortion

	if (debug)
	{
		std::cout << "Camera Matrix " << std::endl << camera_matrix << std::endl;
	}
	// Output rotation and translation
	cv::Mat rotation_vector; // Rotation in axis-angle form
	cv::Mat translation_vector;
	cv::Mat rotCamerMatrix1;

	// Solve for pose
	cv::solvePnP(model_points, image_points, camera_matrix, dist_coeffs, rotation_vector, translation_vector);
	Rodrigues(rotation_vector, rotCamerMatrix1);

	cv::Vec3d eulerAngles;
	Transform::getEulerAngles(rotCamerMatrix1, eulerAngles);
	return eulerAngles;
}

inline std::vector<cv::Rect> getMostProbable(std::vector<cv::Rect> faces)
{
	std::vector<cv::Rect> mostProbableFace;
	if (faces.size() == 0) return mostProbableFace;
	cv::Rect mostProbableRect = faces.back();
	cv::Size mostProbable = mostProbableRect.size();
	if (mostProbableRect.width > 0 && mostProbableRect.height > 0)
	{
		mostProbableFace.push_back(mostProbableRect);
	}
	return mostProbableFace;
}

// calculates MAR ratio between mouth width and height
inline double getSmileSize(std::vector<cv::Point2f>& landmarks)
{
	const auto a = Transform::euclideanDist(landmarks[50], landmarks[58]);
	const auto b = Transform::euclideanDist(landmarks[51], landmarks[57]);
	const auto c = Transform::euclideanDist(landmarks[52], landmarks[56]);
	const auto l = (a + b + c) / 3.;
	const auto d = Transform::euclideanDist(landmarks[48], landmarks[54]);
	return l / d;
}

struct Pose
{
	Pose(float yaw, float roll, float pitch, float smileVert, float smileMar)
	    : Yaw(yaw), Roll(roll), Pitch(pitch), SmileVert(smileVert), SmileMar(smileMar)
	{
	}

	float Yaw;
	float Roll;
	float Pitch;
	float SmileVert;
	float SmileMar;
};

inline Pose getFacePose(cv::Mat& image, std::vector<cv::Point2f>& landmarks, bool print = false)
{
	cv::Vec3d angles = getAngles_pitch_yaw_roll(image, landmarks);
	if (print)
	{
		std::cout << "ANGLES: " << angles << std::endl;
	}

	double pitch = angles[0];
	double yaw = angles[1];
	double roll = angles[2];

	int yaw_left = yaw < -15;
	int yaw_right = yaw > 15;
	int pitch_up = pitch > -170 && pitch < 0;
	int pitch_down = pitch < 170 && pitch > 0;
	auto smileMar = getSmileSize(landmarks);
	auto smileVert = landmarks[66].y - landmarks[54].y;
	int smile = smileMar < .02 || smileMar > .038;

	if (print)
	{
		std::string horizontal = yaw_left ? "left" : (yaw_right ? "right" : "normal");
		std::string vertical = pitch_up ? "nod up" : (pitch_down ? "nod down" : "normal");
		std::string smiling = smile ? "yes" : "no";

		putText(image,
		        cv::format("Face = %s - %s - smile: %s", horizontal.c_str(), vertical.c_str(), smiling.c_str()),
		        cv::Point(10, 100),
		        cv::HersheyFonts::FONT_HERSHEY_SIMPLEX,
		        0.5,
		        cv::Scalar(255, 255, 255),
		        2);
	}

	return Pose((float)yaw, (float)roll, (float)pitch, smileVert, (float)smileMar);
}

inline std::optional<Pose> getFacePose(cv::Mat& image,
                                       cv::Rect mostProbableRect,
                                       cv::Ptr<cv::face::Facemark> facemark,
                                       std::vector<cv::Rect> faces,
                                       bool print = false)
{
	std::vector<std::vector<cv::Point2f>> landmarks;
	bool outImage = (mostProbableRect.x > image.cols || mostProbableRect.y > image.rows);
	if (!outImage)
	{
		bool success = facemark->fit(image, faces, landmarks);
		if (success)
		{
			drawLandmarks(image, landmarks[0]);
			/*for (int j = 0; j < mostProbableFace.size(); j++)
			{
			    face::drawFacemarks(image, landmarks[j], Scalar(0, 0, 255));
			}*/
			return getFacePose(image, landmarks[0], print);
		}
	}
	return {};
}
}
}
