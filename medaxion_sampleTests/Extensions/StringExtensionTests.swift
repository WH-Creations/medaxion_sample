//
//  StringExtensionTests.swift
//  medaxion_sampleTests
//
//  Created by Casey West on 11/10/23.
//

import XCTest
@testable import medaxion_sample

class StringExtensionTests: XCTestCase {

    // Test MD5 hashing of an empty string
    func testMD5EmptyString() {
        let emptyString = ""
        let hashed = emptyString.md5
        XCTAssertEqual(hashed, "d41d8cd98f00b204e9800998ecf8427e", "MD5 hash of an empty string should match known value")
    }

    // Test MD5 hashing of a regular string
    func testMD5RegularString() {
        let regularString = "Hello, world!"
        let hashed = regularString.md5
        XCTAssertEqual(hashed, "6cd3556deb0da54bca060b4c39479839", "MD5 hash of 'Hello, world!' should match known value")
    }

    // Test MD5 hashing of a string with special characters
    func testMD5SpecialCharacters() {
        let specialString = "#$%^&*()_+"
        let hashed = specialString.md5
        XCTAssertEqual(hashed, "172ef468aeebe0534168c90fb8034782", "MD5 hash of special characters should match known value")
    }

    // Additional test cases...
}
