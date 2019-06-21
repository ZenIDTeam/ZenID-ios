#pragma once

// This file is generated automatically. Any change will be overwritten.

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
	AT_IdentityCard_2000 = 15,
	AT_IDC_2002 = 16,
	AT_IDC_2005 = 17,
	AT_IDC_2010 = 18,
	AT_PAS_2006 = 20,
	AT_DRV_2006 = 21,
	AT_DRV_2013 = 22,
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
};

enum class DocumentRole : uint8_t
{
	Idc = 0,
	Pas = 1,
	Drv = 2,
};

}
