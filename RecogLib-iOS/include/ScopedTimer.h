#pragma once

#include <chrono>
#include <string>
#include <ostream>
#include <sstream>
#include <iostream>

namespace RecogLibC
{

class ScopedTimer
{
   public:
	ScopedTimer(std::string logLine);
	~ScopedTimer();

	void End();

	std::string GetText() const;

   private:
	std::string logLine;
	bool hasEnded = false;
	std::chrono::steady_clock::time_point startTime = std::chrono::high_resolution_clock::now();
	std::chrono::steady_clock::time_point endTime;
};

inline ScopedTimer::ScopedTimer(std::string logLine) : logLine(std::move(logLine))
{
}

inline ScopedTimer::~ScopedTimer()
{
	End();
}

inline void ScopedTimer::End()
{
	if (hasEnded) return;
	hasEnded = true;
	endTime = std::chrono::high_resolution_clock::now();
	std::cout << GetText() << std::endl;
}

inline std::string ScopedTimer::GetText() const
{
	using namespace std::chrono;
	const auto duration =
	    duration_cast<milliseconds>((hasEnded ? endTime : high_resolution_clock::now()) - startTime).count();
	std::stringstream ss;
	ss << logLine << " (" << duration << " ms).";
	return ss.str();
}
}
