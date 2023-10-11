#pragma once

#include "RecogLibCApi.h"
#include "ZenidEnums.generated.h"

#include <vector>
#include <string>
#include <optional>

namespace RecogLibC RECOGLIBC_PUBLIC
{
class DocumentFilter
{
public:
	std::optional<DocumentRole> Role;
	std::optional<Country> Country;
	std::optional<PageCodes> Page;
	std::optional<DocumentCodes> DocumentCode;
	std::optional<std::string> ModelID;

	bool operator==(const DocumentFilter& other) const {
		return Role == other.Role 
			&& Country == other.Country 
			&& Page == other.Page
			&& DocumentCode == other.DocumentCode
			&& ModelID == other.ModelID;
	}

	bool operator!=(const DocumentFilter& other) const {
		return !(*this == other);
	}
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
		if (filter.Country || filter.Page || filter.Role || filter.DocumentCode || filter.ModelID)
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
