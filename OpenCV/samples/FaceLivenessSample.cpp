#include "FaceLivenessSample.h"
#include "FaceLivenessDetector.h"

#include "opencv2/core.hpp"

void DetectFaceLiveness()
{
	cv::VideoCapture cap;
	cap.open(1);

	using namespace RecogLibC;

	static const char* resourcesPath = "./models";
	static FaceLivenessDetector faceLivenessDetector = FaceLivenessDetector(resourcesPath);

	while (cv::waitKey(1) != 'q')
	{
		cv::Mat frame;
		cap.read(frame);

		// While loading the faceLivenessDetector, show "Look straight into camera" (selfie_instruction_look)

		faceLivenessDetector.ProcessFrame(frame, Orientation::Up);
		const auto stage = faceLivenessDetector.GetStage();

		std::string message;

		switch (stage)
		{
			case FaceLivenessDetector::Stage::TurnHead:
			{
				message = "Slowly turn your head to LEFT and RIGHT"; // selfie_instruction_turn_any
				break;
			}
			case FaceLivenessDetector::Stage::Smile:
			{
				message = "Smile or move your mouth"; // selfie_instruction_smile
				break;
			}

			case FaceLivenessDetector::Stage::Done:
			{
				message = "Done! Press R to reset.";
				// Here we can send the face image to the server, and use .Reset() if necessary.
				break;
			}
		}

		auto displayFrame = frame.clone();
		cv::putText(displayFrame, message, cv::Point(10, 40), cv::FONT_HERSHEY_PLAIN, 1.5, cv::Scalar(0, 255, 0), 2);
		cv::imshow("Frame", displayFrame);

		if (stage == FaceLivenessDetector::Stage::Done)
		{
			faceLivenessDetector.Reset();
			while (cv::waitKey(0) != 'r') // Block until R is pressed
			{
			}
		}
	}
}
