#pragma once

#include "ZenidEnums.generated.h"
#include "Optional.h"


#include <vector>
#include <string>


namespace RecogLibC
{
class DocumentFilter
{
public:
	Optional<DocumentRole> Role;
	Optional<Country> Country;
	Optional<PageCodes> Page;
	Optional<DocumentCodes> DocumentCode;
	Optional<std::string> ModelID;
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


	AcceptableInput(Optional<DocumentCodes> documentCode, Optional<PageCodes> pageCode = {})
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
