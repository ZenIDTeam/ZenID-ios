#pragma once

#include <utility>
#include <cassert>


namespace RecogLibC
{
// Optional for compatibility with C++14 and earlier.
template <typename T>
class Optional
{
public:
	Optional()
	{
	}

	Optional(T value)
		: pair(std::pair<T, bool>{std::move(value), true})
	{
	}

	T& operator*()
	{
		assert(isSet());
		return getValue();
	}

	const T& operator*() const
	{
		assert(isSet());
		return getValue();
	}

	T* operator->() const
	{
		assert(isSet());
		return &getValue();
	}

	operator bool() const
	{
		return isSet();
	}

private:

	const T& getValue() const {return pair.first;}
	T& getValue() {return pair.first;}

	const bool& isSet() const {return pair.second;}
	bool& isSet() {return pair.second;}	
	
	std::pair<T, bool> pair;
};
}
