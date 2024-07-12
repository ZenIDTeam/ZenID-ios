#pragma once

#include "RecogLibCApi.h"

#include <memory>
#include <string>
#include <functional>

namespace RecogLibC RECOGLIBC_PUBLIC
{
enum class LogLevel
{
	Error = 0,
	Warning = 1,
	Info = 2,
	Debug = 3
};

// Handles logging for Zenid. By default, logs to standard output and standard error.
class ZenidLog
{
public:
	ZenidLog();
	~ZenidLog();

	// Returns the default logger, which is used for all Zenid.
	static ZenidLog& GetDefault();
	
	void Debug(const std::string& message);
	void Info(const std::string& message);
	void Warning(const std::string& message);
	void Error(const std::string& message);

	// Registers a callback that processes a log entry. The callback takes a log level and a message.
	// The first argument is the maximum log level for which the callback should be called. For example, if the first
	// argument is set to LogLevel::Warning, then the callback will be called for the "Error" and "Warning" levels.
	void AddListener(LogLevel level, std::function<void(LogLevel, const std::string&)> listener);

	// Clears all registered listeners. Can also be used to clear the default listener which sends the log to standard output and standard error.
	void ClearListeners();

	class RECOGLIBC_PRIVATE Impl;
	
private:
	std::unique_ptr<Impl> pImpl;
};
}
