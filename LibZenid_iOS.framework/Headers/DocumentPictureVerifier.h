// Copyright (c) Společnost pro informační technologie a právo, s.r.o.

#pragma once

#include "Orientation.h"
#include "ZenidEnums.generated.h"
#include "HologramFeedback.h"

#include "opencv2/core.hpp"

#include <memory>
#include <optional>

namespace RecogLibC
{
class Image;

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
		Ok,
		Hologram,
		Dark
	};

	using OutlineType = std::array<cv::Point2f, 4>;

	// Load all models from the given path.
	explicit DocumentPictureVerifier(const std::string& resourcePath);

	// Don't load any models. Models will need to be loaded individually with LoadModel.
	DocumentPictureVerifier();

	void ProcessFrame(const Image& frame,
	                  const Orientation orientation,
	                  const DocumentRole* role = nullptr,
	                  const Country* country = nullptr,
	                  const PageCodes* page = nullptr,
	                  const DocumentCodes* documentCode = nullptr);

	[[deprecated(
	    "cv::Mat and OpenCV will be removed from the public interface. Use the overload taking Image instead.")]] void
	ProcessFrame(const cv::Mat& frame,
	             const Orientation orientation,
	             const std::optional<DocumentRole> role = {},
	             const std::optional<Country> country = {},
	             const std::optional<PageCodes> page = {},
	             const std::optional<DocumentCodes> documentCode = {});

	State GetState() const;

	// Invalid if the state is NoMatchFound
	DocumentCodes GetDocumentCode() const;

	// Invalid if the state is NoMatchFound
	PageCodes GetPageCode() const;

	HologramFeedback GetHologramFeedback() const;

	void LoadModel(const char* buffer, size_t size);

	bool SupportsHologram() const;

	void BeginHologramVerification();

	void EndHologramVerification();

	std::string GetRenderCommands(const cv::Size& canvasSize, Orientation orientation, SupportedLanguages language);

	void SetDebugVisualization(bool isEnabled);

	~DocumentPictureVerifier();

   private:
	class Impl;
	std::unique_ptr<Impl> pImpl;
};
}
