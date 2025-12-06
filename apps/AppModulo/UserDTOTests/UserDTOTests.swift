//
//  UserDTOTests.swift
//  UserDTOTests
//
//  Created by Yibriam on 29/11/25.
//

import XCTest

@testable import AppModulo

final class UserDTOTests: XCTestCase {
    func testUserDecoder() throws {
        let repository = UserLocalRepository()
        let users = try repository.getUsers(by: "")
        
        XCTAssertNotNil(users)
        XCTAssertEqual(users?.count, 1)
        XCTAssertEqual(users?.first?.address.latitude, "-43.9509")
    }

}
