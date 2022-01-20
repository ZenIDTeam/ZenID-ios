#pragma once

#include "ZenidEnums.generated.h"


#include <vector>
#include <string>
#include <optional>


namespace RecogLibC
{
class DocumentFilter
{
public:
	std::optional<DocumentRole> Role;
	std::optional<Country> Country;
	std::optional<PageCodes> Page;
	std::optional<DocumentCodes> DocumentCode;
	std::optional<std::string> ModelID;
};

class AcceptableInput
{
public:
	
	std::vector<DocumentFilter> PossibleDocuments;
	
	AcceptableInput()
	{
	}

	AcceptableInput(DocumentFilter filter)
	{
		PossibleDocuments.push_back(filter);
	}

	AcceptableInput(std::initializer_list<DocumentCodes> documentCodes)
	{
		for (const auto& documentCode : documentCodes)
		{
			DocumentFilter filter;
			filter.DocumentCode = documentCode;
			PossibleDocuments.push_back(filter);
		}
	}

	AcceptableInput(std::initializer_list<Country> countries)
	{
		for (const auto& country : countries)
		{
			DocumentFilter filter;
			filter.Country = country;
			PossibleDocuments.push_back(filter);
		}
	}


	AcceptableInput(const std::optional<DocumentCodes>& documentCode, const std::optional<PageCodes>& pageCode = {})
	{
		if (documentCode || pageCode)
		{
			DocumentFilter filter;
			filter.DocumentCode = documentCode;
			filter.Page = pageCode;
			PossibleDocuments.push_back(filter);
		}
	}
};
}
