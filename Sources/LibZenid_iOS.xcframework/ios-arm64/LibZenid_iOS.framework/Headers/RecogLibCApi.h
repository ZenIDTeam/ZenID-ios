#pragma once

#if false && (defined(__GNUC__) || defined(__clang__)) && !defined(_WIN32)
#define RECOGLIBC_PUBLIC __attribute__((__visibility__("default")))
#define RECOGLIBC_PRIVATE __attribute__((__visibility__("hidden")))
#else
#define RECOGLIBC_PUBLIC
#define RECOGLIBC_PRIVATE
#endif