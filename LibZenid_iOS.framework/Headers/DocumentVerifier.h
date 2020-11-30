// Copyright (c) Společnost pro informační technologie a právo, s.r.o.

#pragma once

#include "ZenidEnums.generated.h"

#ifndef NO_OPENCV
#include "opencv2/core.hpp"
#endif

#include <memory>
#include <optional>

namespace RecogLibC
{
class Image;

class DocumentVerifier
{
   public:
	using State = DocumentVerifierState;

	// Don't load any models. Models will need to be loaded individually with LoadModel.
	DocumentVerifier();

	void ProcessFrame(const Image& frame,
	                  const DocumentRole* role = nullptr,
	                  const Country* country = nullptr,
	                  const PageCodes* page = nullptr,
	                  const DocumentCodes* documentCode = nullptr);

#ifndef NO_OPENCV

	void ProcessFrame(const cv::Mat& frame,
	                  const std::optional<DocumentRole> role = {},
	                  const std::optional<Country> country = {},
	                  const std::optional<PageCodes> page = {},
	                  const std::optional<DocumentCodes> documentCode = {});
#endif

	State GetState() const;

	// Invalid if the state is NoMatchFound
	DocumentCodes GetDocumentCode() const;

	// Invalid if the state is NoMatchFound
	PageCodes GetPageCode() const;

	HologramState GetHologramState() const;

	void LoadModel(const char* buffer, size_t size);

	bool SupportsHologram() const;

	void BeginHologramVerification();

	void EndHologramVerification();
#ifndef NO_OPENCV
	std::string GetRenderCommands(const cv::Size& canvasSize, SupportedLanguages language);
#endif
	std::string GetRenderCommands(int canvasWidth, int canvasHeight, SupportedLanguages language);

	void SetDebugVisualization(bool isEnabled);

	~DocumentVerifier();

	class Impl;

   private:
	std::unique_ptr<Impl> pImpl;
};
}
