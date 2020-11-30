// Copyright (c) Společnost pro informační technologie a právo, s.r.o.
// This file is generated automatically. Any change will be overwritten.

#pragma once

#include <cstdint>

namespace RecogLibC
{

enum class DocumentCodes : uint8_t
{
	IDC1 = 0,
	IDC2 = 1,
	DRV = 2,
	PAS = 3,
	SK_IDC_2008plus = 4,
	SK_DRV_2004_08_09 = 5,
	SK_DRV_2013 = 6,
	SK_DRV_2015 = 7,
	SK_PAS_2008_14 = 8,
	SK_IDC_1993 = 9,
	SK_DRV_1993 = 10,
	PL_IDC_2015 = 11,
	DE_IDC_2010 = 12,
	DE_IDC_2001 = 13,
	HR_IDC_2013_15 = 14,
	AT_IDE_2000 = 15,
	AT_IDC_2002_05_10 = 18,
	AT_PAS_2006_14 = 20,
	AT_DRV_2006 = 21,
	AT_DRV_2013 = 22,
	CZ_RES_2011_14 = 23,
	CZ_RES_2006_T = 24,
	CZ_RES_2006_07 = 25,
	CZ_GUN_2014 = 26,
};

enum class PageCodes : uint8_t
{
	F = 0,
	B = 1,
};

enum class Country : uint8_t
{
	Cz = 0,
	Sk = 1,
	At = 2,
	Hu = 3,
	Pl = 4,
	De = 5,
	Hr = 6,
};

enum class DocumentRole : uint8_t
{
	Idc = 0,
	Pas = 1,
	Drv = 2,
	Res = 3,
	Gun = 4,
};

enum class SupportedLanguages : uint8_t
{
	English = 0,
	Czech = 1,
	Polish = 2,
	German = 3,
};

enum class DocumentVerifierState : int
{
	NoMatchFound = 0,
	AlignCard = 1,
	HoldSteady = 2,
	Blurry = 3,
	ReflectionPresent = 4,
	Ok = 5,
	Hologram = 6,
	Dark = 7,
};

enum class SelfieVerifierState : int
{
	Ok = 0,
	NoFaceFound = 1,
};

enum class HologramState : int
{
	NoMatchFound = 0,
	TiltLeft = 1,
	TiltRight = 2,
	TiltUp = 3,
	TiltDown = 4,
	RotateClockwise = 5,
	RotateCounterClockwise = 6,
	Ok = 7,
};

}
