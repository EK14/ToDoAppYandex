//
//  JsonTests.swift
//  ToDoAppTests
//
//  Created by Elina Karapetian on 22.06.2024.
//

import XCTest
@testable import ToDoApp

final class JsonTests: XCTestCase {

    func testJson() {
        let item = ToDoItem(text: "Test task",
                            importance: .basic,
                            done: true,
                            createdAt: Date(timeIntervalSince1970: 86400))
        let json = item.json as! [String: Any]
        XCTAssertEqual(json["text"] as? String, "Test task")
        XCTAssertNotNil(json["id"])
        XCTAssertNil(json["importance"])
        XCTAssertNil(json["deadline"])
        XCTAssertEqual(json["done"] as? Bool, true)
    }

    func testJsonWithBasicImportance() {
        let item = ToDoItem(id: "123",
                            text: "Test task",
                            importance: .basic,
                            done: false,
                            createdAt: Date(timeIntervalSince1970: 86400))
        let json = item.json as! [String: Any]
        XCTAssertEqual(json["text"] as? String, "Test task")
        XCTAssertEqual(json["id"] as? String, "123")
        XCTAssertNil(json["importance"])
        XCTAssertNil(json["deadline"])
        XCTAssertEqual(json["done"] as? Bool, false)
    }

    func testJsonWithNotBasicImportance() {
        let item = ToDoItem(id: "123",
                            text: "Test task",
                            importance: .important,
                            done: false,
                            createdAt: Date(timeIntervalSince1970: 86400))
        let json = item.json as! [String: Any]
        XCTAssertEqual(json["text"] as? String, "Test task")
        XCTAssertEqual(json["id"] as? String, "123")
        XCTAssertEqual(json["importance"] as? String, ItemImportance.important.rawValue)
        XCTAssertNil(json["deadline"])
        XCTAssertEqual(json["done"] as? Bool, false)
    }
}
