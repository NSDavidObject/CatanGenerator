//
//  DoubleArrayPositionTests.swift
//  CatanTests
//
//  Created by David Elsonbaty on 9/30/17.
//  Copyright © 2017 David Elsonbaty. All rights reserved.
//

import XCTest

class DoubleArrayPositionTests: XCTestCase {

    func testFirstPosition() {
        let doubleArray = [[], [], [1, 2]]
        let firstPosition = DoubleArrayPosition.firstPosition(in: doubleArray)
        XCTAssertEqual(firstPosition, DoubleArrayPosition(positionX: 0, positionY: 2))
    }
}
