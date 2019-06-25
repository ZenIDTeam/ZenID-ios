#pragma once

#include "Matcher.h"
#include "ModelLoader.h"
#include "BlurValidator.h"
#include "SpecularImageValidator.h"
#include "RecogLibCException.h"

#include "opencv2/core/core.hpp"

#include <array>

namespace RecogLibC
{

class DocumentPictureVerifier
{
   public:
	enum class State
	{
		NoMatchFound,
		AlignCard,
		HoldSteady,
		Blurry,
		ReflectionPresent,
		Ok
	};

	// Load all models from the given path.
	DocumentPictureVerifier(const std::string& resourcePath)
	{
		models = ModelLoader::LoadModels(resourcePath);
		matcher = std::make_unique<Matcher>(models);
	}

	// Don't load any models. Models will need to be loaded individually with LoadModel.
	DocumentPictureVerifier()
	{
		models = std::make_shared<ModelLoader::ModelList>();
		matcher = std::make_unique<Matcher>(models);
	}

	void ProcessFrame(const cv::Mat& frame,
	                  const std::array<cv::Point2f, 4>& expectedOutline, // The expected outline of the card in the
	                                                                     // frame, in relative (0 to 1) coordinates.
	                  const std::optional<DocumentRole> role = {},
	                  const std::optional<Country> country = {},
	                  const std::optional<PageCodes> page = {})
	{
		const auto matchResult = matcher->Match(frame, expectedOutline, role, page, country);
		state = GetStateForMatchResult(matchResult);
		if (state != State::NoMatchFound)
        {
		    documentCode = matchResult->DocumentCode;
		    pageCode = matchResult->PageCode;
        }
	}

	State GetState() const { return state; }

	// Invalid if the state is NoMatchFound
	DocumentCodes GetDocumentCode() const
	{
	    if (state == State::NoMatchFound)
	    {
	        throw RecogLibCException("DocumentCode is not known in state NoMatchFound.");
	    }
	    return documentCode;
	}

    // Invalid if the state is NoMatchFound
    PageCodes GetPageCode() const
    {
        if (state == State::NoMatchFound)
        {
            throw RecogLibCException("PageCode is not known in state NoMatchFound.");
        }
        return pageCode;
    }

	void LoadModel(const char* buffer, size_t size)
	{
		models->push_back(ModelLoader::LoadModel(buffer, size));
	}

   private:
	State state = State::NoMatchFound;
	DocumentCodes documentCode;
	PageCodes pageCode;

	static constexpr bool enableSpecularValidator = false;
	std::unique_ptr<Matcher> matcher;
	std::shared_ptr<ModelLoader::ModelList> models;

	State GetStateForMatchResult(const std::optional<MatchResult>& matchResult) const
	{
		if (!matchResult) return State::NoMatchFound;
		if (matchResult->Score < 70.f) return State::AlignCard;
		if (matchResult->MinBorderDistance < 5.f) return State::AlignCard; // card less than 5px from border
		if (matchResult->LinearFitFraction < 0.65f) return State::AlignCard; // card taking less than 70% of linear space
		if (matchResult->StabilityScore < 40.f) return State::HoldSteady;

		const int blurScore = BlurValidator{}.GetSharpness(matchResult->ProjectedImage());
		if (blurScore < 70)
		{
			return State::NoMatchFound;
		}

		if (enableSpecularValidator)
		{
            SpecularImageValidator specularValidator;
			if (specularValidator.ValidateImage(matchResult->ProjectedImage()) < 100)
			{
				return State::ReflectionPresent;
			}
		}

		return State::Ok;
	}
};

}
