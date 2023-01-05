import argparse
from pyparsing import *

# sample string with enums and other stuff
sample = """
// This file is generated automatically. Any change will be overwritten.
#pragma once
#include <cstdint>
namespace RecogLibC
{

enum class DocumentCodes : int32_t {
    IDC1 = 0,
    IDC2 = 1,
    DRV = 2,
    PAS = 3,
};

enum class SupportedLanguages : uint8_t {
    English = 0,
    Czech = 1,
    Polish = 2,
    German = 3,
};

enum class SdkSignatureProblem : int {
    HashDiffers = 0,
    TimeDiffers = 1,
    HostnameNotAllowed = 2,
    AndroidPackageNotAllowed = 3,
    IosBundleNotAllowed = 4,
    OfflineTokenUsed = 5,
};

}
"""

IGNORED_ENUMS = ['FieldID']

def convert_to_swift(c_code):
    LBRACE, RBRACE, EQ, COMMA = map(Suppress, "{}=,")
    _enum = Suppress("enum")
    _class = Suppress("class")
    _double = Suppress(":")
    enumType = Word(alphas, alphanums + "_")
    identifier = Word(alphas, alphanums + "_")
    integer = Word(nums)
    enumValue = Group(identifier("name") + Optional(EQ + integer("value")))
    enumList = Group(enumValue + ZeroOrMore(COMMA + enumValue) + ZeroOrMore(COMMA))
    enum = _enum + _class + identifier("enum") + _double + enumType + LBRACE + enumList("names") + RBRACE

    print("// This file is generated automatically. Any change will be overwritten.")
    print()

    # find instances of enums ignoring other syntax
    for item, start, stop in enum.scanString(c_code):
        if item.enum in IGNORED_ENUMS:
            continue
        print("public enum", item.enum, ": Int, CaseIterable { ")
        for entry in item.names:
            if entry.value != "":
                print("    case", entry.name, "=", entry.value)
        print("}")
        print()


def main():
    parser = argparse.ArgumentParser(description='Convert enums to Swift variant.')
    parser.add_argument('path', metavar='path-to-header-file', type=str,
                    help='Path to the header file with C enum definitions.')

    args = parser.parse_args()
    header_file_path = args.path

    header_file = open(header_file_path, 'r')
    header_file_content = header_file.read()
    convert_to_swift(header_file_content)

if __name__ == '__main__':
    main()
    #convert_to_swift(sample)

