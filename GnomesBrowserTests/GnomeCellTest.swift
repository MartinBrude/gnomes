//
//  GnomeCellTest.swift
//  GnomesBrowserTests
//
//  Created by Martin on 25/11/2018.
//  Copyright © 2018 M. All rights reserved.
//

import XCTest
@testable import GnomesBrowser

class GnomeCellTest: XCTestCase {

    func testCustomViewContainsAView() {
        let bundle = Bundle(for: GnomeCell.self)
        guard let _ = bundle.loadNibNamed("GnomeCell", owner: nil)?.first as? GnomeCell else {
            return XCTFail("GnomeCell nib can't be loaded")
        }
        XCTAssertNotNil(bundle)
    }

    func testCellAttributes() {
        let bundle = Bundle(for: GnomeCell.self)
        guard let cell = bundle.loadNibNamed("GnomeCell", owner: nil)?.first as? GnomeCell else {
            return XCTFail("GnomeCell nib can't be loaded")
        }
        cell.awakeFromNib()
        XCTAssertNotNil(cell.gnomeImageView.kf.indicatorType)
    }
}

