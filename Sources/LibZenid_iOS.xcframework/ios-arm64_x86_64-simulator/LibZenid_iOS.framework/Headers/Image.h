#pragma once

#include <memory>

namespace RecogLibC
{

enum class ImageFormat
{
	RGB,
	BGR,
	YUV,
	YUV_NV21, // Standard picture format for the Android camera.
	BGRA
};

enum class RotateFlags
{
	Rotate90Clockwise,
	Rotate180,
	Rotate90CounterClockwise
};

class Image
{
   public:
	Image();
	~Image();

	/**
	 * \brief Create a new image by copying data from a pointer
	 * \param data Address of the first pixel
	 * \param width Width of the image in pixels
	 * \param height Height of the image in pixels
	 * \param format Internal image format
	 * \param stride Length of a row of pixels, including the padding. If no padding is used, this can be left as 0.
	 * Also known as scanline or step.
	 */
	Image(void* data, int width, int height, ImageFormat format, size_t stride = 0);

	void Rotate(RotateFlags rotateFlags);

	/**
	 * \brief Crop an image using a rectangle. The origin is in the top-left.
	 * \param x x coordinate of the top-left point in the cropped rectangle
	 * \param y y coordinate of the top-left point in the cropped rectangle
	 * \param width width of the cropped rectangle
	 * \param height height of the cropped rectangle
	 */
	void Crop(int x, int y, int width, int height);

	/**
	 * \brief Crop image to the viewport aspect ratio.
	 * \param viewportHeight 
	 * \param viewportWidth 
	 */
	void CenterCrop(int viewportWidth, int viewportHeight);

	/**
	 * \brief Flip an image around its y axis.
	 */
	void FlipHorizontally();

	void* GetData() const;
	int GetWidth() const;
	int GetHeight() const;

	class Impl;

   private:
	std::unique_ptr<Impl> pImpl;
};

}
