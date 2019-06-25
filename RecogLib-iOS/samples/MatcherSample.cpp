#include "MatcherSample.h"
#include "ModelLoader.h"
#include "Matcher.h"
#include "BlurValidator.h"
#include "SpecularImageValidator.h"
#include "DocumentPictureVerifier.h"

static std::string GetStateDescription(const RecogLibC::DocumentPictureVerifier::State state)
{
	using namespace RecogLibC;
	switch (state)
	{
		case DocumentPictureVerifier::State::NoMatchFound: return "No match found.";
		case DocumentPictureVerifier::State::AlignCard: return "Align card.";
		case DocumentPictureVerifier::State::HoldSteady: return "Hold Steady";
		case DocumentPictureVerifier::State::Blurry: return "Too blurry.";
		case DocumentPictureVerifier::State::ReflectionPresent: return "Reflections Present";
		case DocumentPictureVerifier::State::Ok: return "Good Match. Press R to reset.";
	}
	throw std::out_of_range("Unknown state value.");
}

void VerifyDocumentFromVideo()
{
	using namespace RecogLibC;
	cv::VideoCapture videoCapture;
	videoCapture.open(0);

	const char* resourcePath = "./models";
	auto pictureVerifier = DocumentPictureVerifier{resourcePath};

	while (cv::waitKey(1) != 'q') // Video loop
	{
		cv::Mat frame;
		videoCapture.read(frame);

		// These properties determine which document type to look for.
		const DocumentRole role = DocumentRole::Idc;
		const Country country = Country::Cz;
		const PageCodes page = PageCodes::F;

		// This should be the outline of the card shape drawn on the device screen.
		const float margin = 0.3f;
		const std::array<cv::Point2f, 4> expectedOutline{{
		    {margin, margin},
		    {1.f - margin, margin},
		    {1.f - margin, 1.f - margin},
		    {margin, 1.f - margin},
		}};

		pictureVerifier.ProcessFrame(frame, expectedOutline, role, country, page);

		const DocumentPictureVerifier::State state = pictureVerifier.GetState();
		// If the state is OK, we can send the picture to the server. Otherwise we should give feedback to the user.

		const std::string message = GetStateDescription(state);

		// Print the state on the screen.
		auto displayFrame = frame.clone();
		cv::putText(displayFrame, message, cv::Point(10, 40), cv::FONT_HERSHEY_PLAIN, 1.5, cv::Scalar(0, 255, 0), 2);
		cv::imshow("Frame", displayFrame);

		if (state == DocumentPictureVerifier::State::Ok)
		{
			while (cv::waitKey(0) != 'r') // Block until R is pressed
			{
			}
		}
	}
}