#pragma once

namespace RecogLibC
{
class RecogLibCException : public std::exception
{
   public:
	RecogLibCException(const std::string message) : message{std::move(message)} {}

	const char* what() const throw() { return "C++ Exception"; }

   private:
	std::string message;
};
}