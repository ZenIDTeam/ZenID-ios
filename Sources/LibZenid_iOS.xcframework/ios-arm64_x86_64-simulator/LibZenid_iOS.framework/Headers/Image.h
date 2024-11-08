#pragma once

#include "RecogLibCApi.h"
#include <memory>
#include <ctype.h>
#include <vector>

namespace RecogLibC RECOGLIBC_PUBLIC
{

enum class ImageFormat
{
	RGB,
	BGR,
	YUV,
	YUV_NV21, // Standard picture format for the Android CameraV1 API
	BGRA
};

enum class MultiplaneImageFormat
{
	Android_YUV_420_888, // Standard picture format for the Android CameraV2 API
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
	
	/**
	 * \brief Convert the image to JPEG format.
	 *        Example usage:
	 *              const auto bytes = image.ToJpeg(90);
	 *              std::ofstream outputFile("image.jpg", std::ios::binary);
	 *        		assert(outputFile);
	 *        		outputFile.write(reinterpret_cast<const char*>(bytes.data()), bytes.size());
	 *        		outputFile.close();
	 * \param quality The quality of the JPEG image. 0 is the worst quality and 100 is the best.
	 * \return A vector of bytes representing the image in JPEG format.
	 */
	std::vector<uint8_t> ToJpeg(int quality) const;
	
	/**
	 * \brief Get a copy of the image as a vector of bytes.
	 * \return A vector of bytes representing the image in its internal format (BGR, 8 bits per channel).
	 */
	std::vector<uint8_t> GetBytes() const;

	Image(uint8_t* yPlane,
		 uint8_t* uPlane,
		 uint8_t* vPlane,
		 int width,
		 int height,
		 int yRowStride,
		 int uvRowStride,
		 int uvPixelStride,
		 MultiplaneImageFormat format);

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

	class RECOGLIBC_PRIVATE Impl;

   private:
	std::unique_ptr<Impl> pImpl;
};

}
