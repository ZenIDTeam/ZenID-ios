#pragma once

#include <string>
#include <exception>
#include <utility>

namespace RecogLibC
{
class RecogLibCException : public std::exception
{
   public:
	explicit RecogLibCException(std::string message) : message{std::move(message)} {}

	virtual char const* what() const noexcept override { return message.c_str(); }

   private:
	std::string message;
};

class NoSuitableModelException: public RecogLibCException
{
	public:
		explicit NoSuitableModelException() : RecogLibCException{std::move("No model matches the selected filter.")} {}
	
};

class RecogLibCAssertionException : public RecogLibCException
{
public:
	explicit RecogLibCAssertionException(std::string message) : RecogLibCException{std::move(message)} {}
};
}
