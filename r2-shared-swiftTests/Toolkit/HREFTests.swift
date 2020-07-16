//
//  HREFTests.swift
//  r2-shared-swift
//
//  Created by Mickaël Menu on 15/07/2020.
//
//  Copyright 2020 Readium Foundation. All rights reserved.
//  Use of this source code is governed by a BSD-style license which is detailed
//  in the LICENSE file present in the project repository where this source code is maintained.
//

import XCTest
@testable import R2Shared

class HREFTests: XCTestCase {
    
    func testNormalization() {
        assert("", base: "/folder/", equals: "/folder/")
        assert("/", base: "/folder/", equals: "/")
        
        assert("foo/bar.txt", base: "", equals: "/foo/bar.txt")
        assert("foo/bar.txt", base: "/", equals:"/foo/bar.txt")
        assert("foo/bar.txt", base: "/file.txt", equals:"/foo/bar.txt")
        assert("foo/bar.txt", base: "/folder", equals:"/foo/bar.txt")
        assert("foo/bar.txt", base: "/folder/", equals:"/folder/foo/bar.txt")
        assert("foo/bar.txt", base: "http://example.com/folder/file.txt", equals:"http://example.com/folder/foo/bar.txt")
        assert("foo/bar.txt", base: "http://example.com/folder", equals:"http://example.com/foo/bar.txt")
        assert("foo/bar.txt", base: "http://example.com/folder/", equals:"http://example.com/folder/foo/bar.txt")
        
        assert("/foo/bar.txt", base: "", equals: "/foo/bar.txt")
        assert("/foo/bar.txt", base: "/", equals:"/foo/bar.txt")
        assert("/foo/bar.txt", base: "/file.txt", equals:"/foo/bar.txt")
        assert("/foo/bar.txt", base: "/folder", equals:"/foo/bar.txt")
        assert("/foo/bar.txt", base: "/folder/", equals:"/foo/bar.txt")
        assert("/foo/bar.txt", base: "http://example.com/folder/file.txt", equals:"http://example.com/foo/bar.txt")
        assert("/foo/bar.txt", base: "http://example.com/folder", equals:"http://example.com/foo/bar.txt")
        assert("/foo/bar.txt", base: "http://example.com/folder/", equals:"http://example.com/foo/bar.txt")
        
        assert("../foo/bar.txt", base: "", equals: "/../foo/bar.txt")
        assert("../foo/bar.txt", base: "/", equals:"/../foo/bar.txt")
        assert("../foo/bar.txt", base: "/file.txt", equals:"/../foo/bar.txt")
        assert("../foo/bar.txt", base: "/folder", equals:"/../foo/bar.txt")
        assert("../foo/bar.txt", base: "/folder/", equals:"/foo/bar.txt")
        assert("../foo/bar.txt", base: "http://example.com/folder/file.txt", equals:"http://example.com/foo/bar.txt")
        assert("../foo/bar.txt", base: "http://example.com/folder", equals:"http://example.com/../foo/bar.txt")
        assert("../foo/bar.txt", base: "http://example.com/folder/", equals:"http://example.com/foo/bar.txt")
        
        assert("foo/../bar.txt", base: "", equals: "/bar.txt")
        assert("foo/../bar.txt", base: "/", equals:"/bar.txt")
        assert("foo/../bar.txt", base: "/file.txt", equals:"/bar.txt")
        assert("foo/../bar.txt", base: "/folder", equals:"/bar.txt")
        assert("foo/../bar.txt", base: "/folder/", equals:"/folder/bar.txt")
        assert("foo/../bar.txt", base: "http://example.com/folder/file.txt", equals:"http://example.com/folder/bar.txt")
        assert("foo/../bar.txt", base: "http://example.com/folder", equals:"http://example.com/bar.txt")
        assert("foo/../bar.txt", base: "http://example.com/folder/", equals:"http://example.com/folder/bar.txt")

        assert("http://absolute.com/foo/bar.txt", base: "/", equals: "http://absolute.com/foo/bar.txt")
        assert("http://absolute.com/foo/bar.txt", base: "https://example.com/", equals:"http://absolute.com/foo/bar.txt")
        
        // Anchor and query parameters are preserved
        assert("foo/bar.txt#anchor", base: "/", equals:"/foo/bar.txt#anchor")
        assert("foo/bar.txt?query=param#anchor", base: "/", equals:"/foo/bar.txt?query=param#anchor")
        assert("/foo/bar.txt?query=param#anchor", base: "/", equals:"/foo/bar.txt?query=param#anchor")
        assert("http://absolute.com/foo/bar.txt?query=param#anchor", base: "/", equals:"http://absolute.com/foo/bar.txt?query=param#anchor")
        
        // HREF that is just an anchor
        assert("#anchor", base: "", equals: "/#anchor")
        assert("#anchor", base: "/", equals:"/#anchor")
        assert("#anchor", base: "/file.txt", equals:"/file.txt#anchor")
        assert("#anchor", base: "/folder", equals:"/folder#anchor")
        assert("#anchor", base: "/folder/", equals:"/folder/#anchor")
        assert("#anchor", base: "http://example.com/folder/file.txt", equals:"http://example.com/folder/file.txt#anchor")
        assert("#anchor", base: "http://example.com/folder", equals:"http://example.com/folder#anchor")
        assert("#anchor", base: "http://example.com/folder/", equals:"http://example.com/folder/#anchor")
    }
    
    private func assert(_ href: String, base: String, equals expected: String, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(HREF(href, relativeTo: base).string, expected, file: file, line: line)
    }

}