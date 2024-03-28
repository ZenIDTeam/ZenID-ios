//
//  SupportedLanguages+ExtensionsTests.swift
//  RecogLib_iOSTests
//
//  Created by Vladimir Belohradsky on 18.03.2024.
//  Copyright © 2024 ZenID. All rights reserved.
//

import XCTest
@testable import RecogLib_iOS

final class SupportedLanguages_ExtensionsTests: XCTestCase {


    func testLanguage_GivenValue_ExpectCorrectValue() throws {
        let langDE = Locale(identifier: "de-DE")
        let langCZ = Locale(identifier: "cs-CZ")
        let langPL = Locale(identifier: "pl-PL")
        let langEN = Locale(identifier: "en-US")
        
        XCTAssertEqual(SupportedLanguages.language(from: langDE), SupportedLanguages.German)
        XCTAssertEqual(SupportedLanguages.language(from: langCZ), SupportedLanguages.Czech)
        XCTAssertEqual(SupportedLanguages.language(from: langPL), SupportedLanguages.Polish)
        XCTAssertEqual(SupportedLanguages.language(from: langEN), SupportedLanguages.English)
    }


}
