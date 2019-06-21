#pragma once

#include "opencv2/opencv.hpp"

namespace RecogLibC
{
namespace Transform
{

inline cv::Mat_<double> Identity()
{
	return cv::Mat::eye(3, 3, CV_64FC1);
}

inline cv::Mat_<double> Scale(double x, double y)
{
	auto transform = Identity();
	transform(0, 0) = x;
	transform(1, 1) = y;
	return transform;
}

inline cv::Mat_<double> Translation(double x, double y)
{
	auto transform = Identity();
	transform(0, 2) = x;
	transform(1, 2) = y;
	return transform;
}

inline cv::Mat_<double> ScaleCenter(const cv::Size& imageSize, double scale)
{
	const auto scaleTransform = Scale(1. / scale, 1. / scale);

	const auto translateForward = Translation(imageSize.width * 0.5, imageSize.height * 0.5);
	const auto translateBack = Translation(imageSize.width * -0.5, imageSize.height * -0.5);

	return translateForward * scaleTransform * translateBack;
}

inline float euclideanDist(cv::Point2f& a, cv::Point2f& b)
{
	cv::Point2f diff = a - b;
	return cv::sqrt(diff.x * diff.x + diff.y * diff.y);
}

/*
yaw   = eulerAngles[1];
pitch = eulerAngles[0];
roll  = eulerAngles[2];
*/
inline void getEulerAngles(cv::Mat& rotCamerMatrix, cv::Vec3d& eulerAngles)
{
	cv::Mat cameraMatrix, rotMatrix, transVect, rotMatrixX, rotMatrixY, rotMatrixZ;
	double* _r = rotCamerMatrix.ptr<double>();
	double projMatrix[12] = {_r[0], _r[1], _r[2], 0, _r[3], _r[4], _r[5], 0, _r[6], _r[7], _r[8], 0};

	decomposeProjectionMatrix(cv::Mat(3, 4, CV_64FC1, projMatrix),
	                          cameraMatrix,
	                          rotMatrix,
	                          transVect,
	                          rotMatrixX,
	                          rotMatrixY,
	                          rotMatrixZ,
	                          eulerAngles);
}

inline void getEulerAngles2(cv::Mat& rotCamerMatrix, cv::Vec3d& eulerAngles)
{
	cv::Mat cameraMatrix, rotMatrix, transVect, rotMatrixX, rotMatrixY, rotMatrixZ;
	decomposeProjectionMatrix(
	    rotCamerMatrix, cameraMatrix, rotMatrix, transVect, rotMatrixX, rotMatrixY, rotMatrixZ, eulerAngles);
}

inline void GetCameraMatrix(cv::Mat& im, cv::Mat& camera_matrix)
{
	double focal_length = im.cols; // Approximate focal length.
	cv::Point2d center = cv::Point2d(im.cols / 2, im.rows / 2);
	camera_matrix = (cv::Mat_<double>(3, 3) << focal_length, 0, center.x, 0, focal_length, center.y, 0, 0, 1);
}

/* hologram functions - copy from c# */
/*
static(Matrix<double>, Matrix<double>, Matrix<double>) NormalVectorCV(cv::Mat perspective) in hologram ->
getEulerAngles(cv::Mat& rotCamerMatrix, cv::Vec3d& eulerAngles) ...nearly the same, also uses RQDecomp (main in
decomposeProjectionMatrix)
*/

inline cv::Point2f GetCardCentre(std::array<cv::Point2f, 4ULL> outline)
{
	// What is the centre of the card shape rectangle/diamond/whatever?
	auto p = outline[0];
	auto q = outline[1];
	auto rX = outline[2].x - outline[0].x;
	auto rY = outline[2].y - outline[0].y;
	auto sX = outline[3].x - outline[1].x;
	auto sY = outline[3].y - outline[1].y;
	cv::Point2f s = cv::Point2f(sX, sY);
	cv::Point2f r = cv::Point2f(rX, rY);
	// https://stackoverflow.com/questions/563198/whats-the-most-efficent-way-to-calculate-where-two-line-segments-intersect

	// t = (q − p) × s / (r × s)

	auto qmp = cv::Point2f(q.x - p.x, q.y - p.y);
	auto tUpper =
	    (float)qmp.cross(s); // public static float VectorX(PointF a, PointF b) => a.X * b.Y - a.Y * b.X; VectorX(qmp, s)
	auto tLower = (float)r.cross(s); // VectorX(r, s)
	auto t = tUpper / tLower;

	auto centre = cv::Point2f(p.x + t * rX, p.y + t * rY);
	return centre;
}

inline cv::Point2f NormalVectorFromCentre(cv::Point2f centre, cv::Mat perspective, bool debug)
{
	// from C# VectorUtils
	// https://math.stackexchange.com/questions/62936/transforming-2d-outline-into-3d-plane/63100#63100

	// The outline we have is a 2d object embedded in 3d space, perspective mapped, and then projected back to 2d space
	// (to the result image). The aligned card is got via the reverse perspective mapping (in var perspective).

	// https://en.wikipedia.org/wiki/Cross_product#Matrix_notation
	cv::Mat copy = cv::Mat(3, 3, CV_64FC1);
	copy.at<double>(0, 1) = -perspective.at<double>(0, 2);
	copy.at<double>(1, 0) = perspective.at<double>(0, 2);
	copy.at<double>(0, 2) = perspective.at<double>(0, 1);
	copy.at<double>(2, 0) = -perspective.at<double>(0, 1);
	copy.at<double>(2, 1) = perspective.at<double>(0, 0);
	copy.at<double>(1, 2) = -perspective.at<double>(0, 0);
	cv::Mat second = cv::Mat(3, 1, CV_64FC1);
	second.at<double>(0, 0) = -perspective.at<double>(1, 0);
	second.at<double>(1, 0) = perspective.at<double>(1, 1);
	second.at<double>(2, 0) = -perspective.at<double>(1, 2);
	cv::Mat perpendicular = copy * second;
	cv::Point2f pp = cv::Point2f(centre.x + (float)(perpendicular.at<double>(0, 0) / perpendicular.at<double>(2, 0)),
	                             centre.y + (float)(perpendicular.at<double>(1, 0) / perpendicular.at<double>(2, 0)));
	return pp;
}

inline cv::Point2f StraightUpVector(double orientationDegrees)
{
	auto ANGLE_THRESHOLD = 20;
	auto straightUp = cv::Point2f(0, -200);
	// Which way is up?
	if (orientationDegrees < ANGLE_THRESHOLD && orientationDegrees > -ANGLE_THRESHOLD)
	{
		// up
		straightUp = cv::Point2f(0, -200);
	}
	else if (orientationDegrees - 90 < ANGLE_THRESHOLD && orientationDegrees > 90 - ANGLE_THRESHOLD)
	{
		// right
		straightUp = cv::Point2f(200, 0);
	}
	else if (orientationDegrees - 180 < ANGLE_THRESHOLD && orientationDegrees > 180 - ANGLE_THRESHOLD)
	{
		// Down
		straightUp = cv::Point2f(0, 200);
	}
	else if (orientationDegrees + 180 < ANGLE_THRESHOLD && orientationDegrees > -180 - ANGLE_THRESHOLD)
	{
		// Down
		straightUp = cv::Point2f(0, 200);
	}
	else if (orientationDegrees + 90 < ANGLE_THRESHOLD && orientationDegrees > -90 - ANGLE_THRESHOLD)
	{
		// left
		straightUp = cv::Point2f(-200, 0);
	}
	return straightUp;
}

inline cv::Vec3d NormalVectorAngle(cv::Point2f normalVector,
                                   cv::Point2f straightUpVector,
                                   float distanceToCorner,
                                   bool debug = false)
{
	// http://onlinemschool.com/math/library/vector/angl/
	cv::Point2f origin = cv::Point2f(0, 0);
	auto dist = euclideanDist(normalVector, origin);
	if (debug) std::cout << "dist " << std::endl << dist << std::endl;
	auto cosa = normalVector.dot(straightUpVector) / (dist * euclideanDist(straightUpVector, origin));
	auto angle = std::acos(cosa) / CV_PI * 180.0;
	if (debug) std::cout << "angle-cosa " << std::endl << angle << std::endl;
	auto ltt = distanceToCorner - dist;
	if (debug) std::cout << "ltt " << std::endl << ltt << std::endl;
	cv::Vec3d ret;
	ret[0] = angle;
	ret[1] = dist;
	ret[2] = ltt;
	return ret;
}

inline cv::Vec3d AngleAndDistance(cv::Mat& im, cv::Mat& H, std::array<cv::Point2f, 4ULL> outline, bool debug = false)
{
	cv::Point2f centre = GetCardCentre(outline);
	float distanceToCorner = euclideanDist(outline[0], centre);

	cv::Point2f pp = NormalVectorFromCentre(centre, H, false);
	cv::Point2f normalVector = cv::Point2f(pp.x - centre.x, pp.y - centre.y);

	cv::Mat cameraMatrix;
	cv::Mat rotMatrix;
	cv::Vec3d angles = RQDecomp3x3(H, cameraMatrix, rotMatrix);
	if (debug) std::cout << "angles2 " << std::endl << angles << std::endl;
	double orientationDegrees = angles[2];
	if (debug) std::cout << "norm " << std::endl << normalVector << std::endl;
	cv::Point2f straightUp = StraightUpVector(orientationDegrees);
	if (debug) std::cout << "straightUp " << std::endl << straightUp << std::endl;
	// Console.WriteLine("Orientation: {0} Straight up: {1},{2}", orientationDegrees, straightUp.X, straightUp.Y);
	return NormalVectorAngle(normalVector, straightUp, distanceToCorner);
}

/* end hologram */

/*normalized*/
/* https://stackoverflow.com/questions/8927771/computing-camera-pose-with-homography-matrix-based-on-4-coplanar-points
 * usable only for getting left-right-top-bottom (not real angles) */
inline cv::Vec3d GetAnglesByNormalization(cv::Mat& im, cv::Mat& H, std::array<cv::Point2f, 4ULL> outline)
{
	double norm1 = (double)norm(H.col(0));
	double norm2 = (double)norm(H.col(1));
	double tnorm = (norm1 + norm2) / 2.0f; // Normalization value

	cv::Mat c0;
	cv::Mat p1 = H.col(0); // Pointer to first column of H
	cv::normalize(p1, c0); // Normalize the rotation

	cv::Mat c1;
	p1 = H.col(1);         // Pointer to second column of H
	cv::normalize(p1, c1); // Normalize the rotation and copies the column to pose

	cv::Mat c2 = c0.cross(c1);     // Computes the cross-product of c0 and c1
	cv::Mat c3 = H.col(2) / tnorm; // vector t [R|t] is the last column of pose

	cv::Mat pose2 = cv::Mat(3, 4, CV_64FC1);
	c0.copyTo(pose2.col(0));
	c1.copyTo(pose2.col(1));
	c2.copyTo(pose2.col(2));
	c3.copyTo(pose2.col(3));

	cv::Mat pose3 = cv::Mat(3, 3, CV_64FC1);
	c0.copyTo(pose3.col(0));
	c1.copyTo(pose3.col(1));
	c2.copyTo(pose3.col(2));
	cv::Vec3d eulerAngles;
	getEulerAngles2(pose2, eulerAngles);
	return eulerAngles;
}

/* end normalized*/

/*decomposemat*/

inline std::array<cv::Point3d, 4ULL> getTranslatedOutline(cv::Mat& K, std::array<cv::Point2f, 4ULL> outline)
{
	cv::Mat Kinv = K.inv();
	std::array<cv::Point3d, 4> translatedOutline;
	cv::Mat a = Kinv * cv::Mat(cv::Point3d{outline[0].x, outline[0].y, 1});
	cv::Mat b = Kinv * cv::Mat(cv::Point3d{outline[1].x, outline[1].y, 1});
	cv::Mat c = Kinv * cv::Mat(cv::Point3d{outline[2].x, outline[2].y, 1});
	cv::Mat d = Kinv * cv::Mat(cv::Point3d{outline[3].x, outline[3].y, 1});
	cv::Point3d aa = cv::Point3d(a);
	cv::Point3d bb = cv::Point3d(b);
	cv::Point3d cc = cv::Point3d(c);
	cv::Point3d dd = cv::Point3d(d);
	translatedOutline[0] = aa;
	translatedOutline[1] = bb;
	translatedOutline[2] = cc;
	translatedOutline[3] = dd;
	return translatedOutline;
}

inline bool DifferentSign(double a, double b)
{
	return (abs(a + b) != abs(a) + abs(b)) //different sign 
	&& (abs(a) > 5 && abs(b) > 5); //numbers higher than 5 in absolute
}

/* gets decomposition and points the decomposition we found the best (ignore one with some points behind camera, or angle not coresponding with pose */
inline cv::Vec3d GetAnglesByDecomposition(cv::Mat& im,
                                          cv::Mat& H,
                                          std::array<cv::Point2f, 4ULL> outlineRelative,
                                          cv::Vec3d& previousFrame,
                                          bool debug = false)
{
	cv::Mat K;
	GetCameraMatrix(im, K);
	cv::Vec3d eulerAnglesFirst;
	double ex = 5;

	cv::Point2f centre = GetCardCentre(outlineRelative);
	cv::Point2f pp = NormalVectorFromCentre(centre, H, false);
	cv::Point2f normalVector = cv::Point2f(pp.x - centre.x, pp.y - centre.y);
	/* maybe we can do something with normalvector from card outline and normalvector from decomposition */

	std::array<cv::Point2f, 4> outline;
	std::transform(outlineRelative.begin(), outlineRelative.end(), outline.begin(), [&](const auto& point) {
		return cv::Point2f{(point.x * (float)im.cols), (point.y * (float)im.rows)};
	});
	std::array<cv::Point3d, 4ULL> translatedOutline = getTranslatedOutline(K, outline);

	float topDistance = euclideanDist(outline[0], outline[1]);
	float rightDistance = euclideanDist(outline[1], outline[2]);
	float bottomDistance = euclideanDist(outline[2], outline[3]);
	float leftDistance = euclideanDist(outline[3], outline[0]);
	bool toUp = topDistance < bottomDistance; // pitch < 0
	bool toBottom = topDistance > bottomDistance;
	bool toLeft = leftDistance < rightDistance; // yaw > 0
	bool toRight = leftDistance > rightDistance;
	std::vector<cv::Mat> Rs, Ts, Ns;
	int solutions = cv::decomposeHomographyMat(H, K, Rs, Ts, Ns);
	auto previousPitch = previousFrame[0];
	auto previousYaw = previousFrame[1];

	for (int i = 0; i < solutions; i++)
	{
		cv::Mat R_ = Rs[i];
		cv::Mat T_ = Ts[i];
		cv::Vec3d N_ = cv::Vec3d(Ns[i]);
		double proj = translatedOutline[i].x * N_[0] + translatedOutline[i].y * N_[1] + translatedOutline[i].z * N_[2];
		if (proj <= 0)
		{
			if (debug) std::cout << i << "-st ignored due to point behind camera " << std::endl;
			continue;
		}
		cv::Vec3d eulerAngles;
		getEulerAngles(R_, eulerAngles);
		auto pitch = eulerAngles[0];
		auto yaw = eulerAngles[1];
		auto roll = eulerAngles[2];

		if (DifferentSign(pitch, previousPitch))
		{
			if (debug) std::cout << i << "-st ignored due to huge change from previous frame " << std::endl;
			if (debug) std::cout << i << "-st distances: p" << pitch << " pp" << previousPitch << std::endl;
			continue;
		}
		if (DifferentSign(yaw, previousYaw))
		{
			if (debug) std::cout << i << "-st ignored due to huge change from previous frame " << std::endl;
			if (debug) std::cout << i << "-st distances: y" << yaw << " py" << previousYaw << std::endl;
			continue;
		}
		eulerAnglesFirst = eulerAngles;
		if (toUp && pitch > ex)
		{
			if (debug) std::cout << i << "-st ignored due to positive pitch with to up " << std::endl;
			if (debug) std::cout << i << "-st distances: t" << topDistance << " b" << bottomDistance << std::endl;
			continue;
		}
		if (toBottom && pitch < -ex)
		{
			if (debug) std::cout << i << "-st ignored due to negative pitch with to down " << std::endl;
			if (debug) std::cout << i << "-st distances: t" << topDistance << " b" << bottomDistance << std::endl;
			continue;
		}
		if (toLeft && yaw < -ex)
		{
			if (debug) std::cout << i << "-st ignored due to negative yaw with to left " << std::endl;
			if (debug) std::cout << i << "-st distances: l" << leftDistance << " r" << rightDistance << std::endl;
			continue;
		}
		if (toRight && yaw > ex)
		{
			if (debug) std::cout << i << "-st ignored due to positive yaw with to right " << std::endl;
			if (debug) std::cout << i << "-st distances: l" << leftDistance << " r" << rightDistance << std::endl;
			continue;
		}

		if (debug) std::cout << i << " Camera Matrix1 " << std::endl << R_ << std::endl;
		if (debug) std::cout << i << " angles1 " << std::endl << eulerAngles << std::endl;

		return eulerAngles;
	}
	cv::Vec6d eulerAngles3;
	for (int i = 0; i < solutions; i++)
	{
		cv::Mat R_x = Rs[i];
		cv::Vec3d e;
		getEulerAngles(R_x, e);
		if (DifferentSign(e[0], previousPitch))
		{
			if (debug) std::cout << i << "-st ignored due to huge change from previous frame " << std::endl;
			if (debug) std::cout << i << "-st distances: p" << e[0] << " pp" << previousPitch << std::endl;
			continue;
		}
		if (DifferentSign(e[1], previousYaw))
		{
			if (debug) std::cout << i << "-st ignored due to huge change from previous frame " << std::endl;
			if (debug) std::cout << i << "-st distances: y" << e[1] << " py" << previousYaw << std::endl;
			continue;
		}
		if (debug) std::cout << i << " to up " << std::endl << toUp << std::endl;
		if (debug) std::cout << i << " to left " << std::endl << toLeft << std::endl;
		if (debug) std::cout << i << " wrong angle " << std::endl << e << std::endl;
	}
	return eulerAnglesFirst;
}
/*end decomposemat*/

/* this jumps to negative - todo needs some work*/
inline cv::Vec3d GetAnglesByPnP(cv::Mat& im, cv::Mat& H, std::array<cv::Point2f, 4ULL> outline, bool debug = false)
{
	std::vector<cv::Point3d> model_points;
	std::vector<cv::Point2d> image_points;
	cv::Point2f centre = GetCardCentre(outline);
	double halfwidth = centre.x - outline[0].x;
	double halfheight = centre.y - outline[0].y;
	// 3D model points.
	model_points.push_back(cv::Point3d(150.0f * halfwidth, -150.0f * halfheight, -50.0f));  // Left top
	model_points.push_back(cv::Point3d(150.0f * halfwidth, 150.0f * halfheight, -50.0f));   // Right top
	model_points.push_back(cv::Point3d(150.0f * halfwidth, -150.0f * halfheight, -50.0f));  // Right bottom
	model_points.push_back(cv::Point3d(-150.0f * halfwidth, -150.0f * halfheight, -50.0f)); // Left bottom

	// 2D image points.
	image_points.push_back(outline[0]);
	image_points.push_back(outline[1]);
	image_points.push_back(outline[2]);
	image_points.push_back(outline[3]);

	cv::Mat camera_matrix;
	Transform::GetCameraMatrix(im, camera_matrix);
	cv::Mat dist_coeffs = cv::Mat::zeros(4, 1, cv::DataType<double>::type); // Assuming no lens distortion

	std::cout << "Camera Matrix " << std::endl << camera_matrix << std::endl;
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

inline static double THRESHOLD = 0;
inline static int PREDICTION_THRESHOLD = 30;
enum OutlierType
{
	Distance,
	Prediction,
	None
};

/* from OUtlierRemover.cs*/
inline std::array<cv::Point2f, 4ULL> predictPosition(std::queue<std::array<cv::Point2f, 4ULL>>& queue)
{
	std::array<cv::Point2f, 4ULL> vector;
	if (queue.empty()) return vector;
	auto queueCopy = queue;
	std::array<cv::Point2f, 4ULL> first = queueCopy.front();
	queueCopy.pop();
	if (queueCopy.empty()) return vector;
	std::array<cv::Point2f, 4ULL> second = queueCopy.front();

	// Linear interpolation for each point.
	// 1. Directional vectors:
	for (int i = 0; i < 4; i++)
	{
		cv::Point2f f = first[i];
		cv::Point2f s = second[i];
		vector[i] = cv::Point2f(s.x - f.x, s.y - f.y);
	}
	// 2. End position:
	for (int i = 0; i < 4; i++)
	{
		cv::Point2f start = second[i];
		cv::Point2f increment = vector[i];
		vector[i] = cv::Point2f(start.x - increment.x, start.y - increment.y);
	}

	return vector;
}

inline bool isValid(std::array<cv::Point2f, 4ULL>& outline, std::array<cv::Point2f, 4ULL>& prediction, int threshold)
{
	bool valid = true;
	for (int i = 0; i < 4; i++)
	{
		cv::Point2f o = outline[i];
		cv::Point2f p = prediction[i];
		double dist = euclideanDist(o, p);
		// Console.WriteLine("Distance of " + i + " from prediction: " + dist);
		valid = valid && dist < threshold;
	}
	return valid;
}

/*  this function gets Homography and outline, ant tries to identify if the outline should be ignored for getting the angles */
inline bool isOutlier(cv::Mat& im,
                      cv::Mat& H,
                      std::array<cv::Point2f, 4ULL> outline,
                      std::queue<std::array<cv::Point2f, 4ULL>>& queue,
                      std::array<cv::Point2f, 4ULL>& prediction,
                      OutlierType type = Distance,
                      bool debug = false)
{
	if (type == Distance) //non-state
	{
		cv::Vec3d v = AngleAndDistance(im, H, outline, debug);
		if (debug) std::cout << " distancefrom topleft to center " << std::endl << v[2] << std::endl;
		return v[2] < THRESHOLD;
	}
	if (type == Prediction) //needs queue of previous outlines
	{
		bool keep = false;
		if (queue.size() > 1)
		{
			prediction = predictPosition(queue);
			keep = isValid(outline, prediction, PREDICTION_THRESHOLD);
			queue.pop();
		}
		else
		{
			queue.push(outline);
		}
		if (keep)
		{
			queue.push(outline);
		}
		return !keep;
	}
	return type != None; //for none all is in, otherwise all is out
}

enum GetAngleType
{
	Normalization,
	Decomposition,
	PnP
};

/* Get Pitch, Yaw and Roll from Homography matrix
 * - possible types Normalization -
 * https://stackoverflow.com/questions/8927771/computing-camera-pose-with-homography-matrix-based-on-4-coplanar-points
 * - Decomposition - decomposeHomographyMat (that returns 4 possible output, we are using axiom of "all points in front
 * of camera" and also the rectangelity of card to ignore some of them
 * - PnP - get 3d model to 2d outline - returns one output - but right now not usable right now, it jumps
 * negative+positive
 */
inline cv::Vec3d getAnglesRectangle_pitch_yaw_roll(cv::Mat& im,
                                                   cv::Mat& H,
                                                   std::array<cv::Point2f, 4ULL> outline,
                                                   std::array<cv::Point2f, 4ULL>& prediction,
                                                   std::queue<std::array<cv::Point2f, 4ULL>>& queue,
												   cv::Vec3d& previousAngles,
                                                   GetAngleType type = Decomposition,
                                                   bool debug = false)
{
	cv::Vec3d angles;
	cv::Vec3d angles0;
	if (type == Normalization)
		angles = GetAnglesByNormalization(im, H, outline);
	else if (type == PnP)
		angles = GetAnglesByPnP(im, H, outline, debug);
	else
		angles = GetAnglesByDecomposition(im, H, outline, previousAngles, debug);
	if (debug) std::cout << " Found angles " << std::endl << angles << std::endl;
	bool isOk = !isOutlier(im, H, outline, queue, prediction, Prediction, debug);
	if (isOk)
	{
		if (debug) std::cout << " is ok " << std::endl << isOk << std::endl;
		return angles;
	}
		
	return angles0;
}
}
}