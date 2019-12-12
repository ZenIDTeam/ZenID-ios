// Copyright (c) Společnost pro informační technologie a právo, s.r.o.

#pragma once

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

enum class ImageDataType
{
	UInt8, // Unsigned byte
};

// Representation of an image already stored in memory in another location. The external data is not deallocated
// automatically.
class Image
{
   public:
	Image(void* data, const int width, const int height, const ImageFormat format, const ImageDataType dataType)
	    : Data(data), Width(width), Height(height), Format(format), DataType(dataType)
	{
	}

	Image(void* data,
	      const int width,
	      const int height,
	      const size_t stride,
	      const ImageFormat format,
	      const ImageDataType dataType)
	    : Data(data), Width(width), Height(height), Stride(stride), Format(format), DataType(dataType)
	{
	}

	void* Data; // Address of the first pixel.
	int Width;
	int Height;
	size_t Stride = 0; // Length of a row of pixels, including the padding. If no padding is used, this can be left as
	                   // 0. Also known as scanline or step.
	ImageFormat Format;
	ImageDataType DataType;
};

}