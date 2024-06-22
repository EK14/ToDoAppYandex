//
//  ParseTests.swift
//  ToDoAppTests
//
//  Created by Elina Karapetian on 21.06.2024.
//

import XCTest
@testable import ToDoApp

class ParseTests: XCTestCase {

    func testParseValidJSON() {
        let json = ["id": "1", 
                    "text": "Test task",
                    "created_at": 1617033600,
                    "importance": ItemImportance.basic.rawValue,
                    "deadline": 1617120000,
                    "done": false,
                    "changed_at": 1617033600] as [String : Any]
        
        let item = ToDoItem.parse(json: json)
        
        XCTAssertNotNil(item)
        XCTAssertEqual(item?.id, "1")
        XCTAssertEqual(item?.text, "Test task")
        XCTAssertEqual(item?.importance, .basic)
        XCTAssertEqual(item?.deadline, Date(timeIntervalSince1970: 1617120000))
        XCTAssertFalse(item?.done ?? true)
        XCTAssertEqual(item?.createdAt, Date(timeIntervalSince1970: 1617033600))
        XCTAssertEqual(item?.changedAt, Date(timeIntervalSince1970: 1617033600))
    }

    func testParseInvalidJSON() {
        let json = ["invalid_key": "invalid_value"] as [String : Any]
        let item = ToDoItem.parse(json: json)
        XCTAssertNil(item)
    }
    
    func testParseMissingText() {
        let json = ["created_at": 1617033600, 
                    "importance": ItemImportance.important.rawValue,
                    "deadline": 1617120000,
                    "done": true,
                    "changed_at": 1617033600] as [String : Any]
        
        let item = ToDoItem.parse(json: json)
        
        XCTAssertNil(item)
    }
    
    func testParseMissingCreatedAt() {
        let json = ["text": "Test task", 
                    "importance": ItemImportance.important.rawValue,
                    "deadline": 1617120000,
                    "done": true,
                    "changed_at": 1617033600] as [String : Any]
        
        let item = ToDoItem.parse(json: json)

        XCTAssertNil(item)
    }
    
    func testParseMissingImportance() {
        let json = ["text": "Test task", 
                    "created_at": 1617033600,
                    "deadline": 1617120000,
                    "done": true,
                    "changed_at": 1617033600] as [String : Any]
        
        let item = ToDoItem.parse(json: json)

        XCTAssertNil(item)
    }
    
    func testParseMissingDeadline() {
        let json = ["text": "Test task", 
                    "created_at": 1617033600,
                    "importance": ItemImportance.important.rawValue,
                    "done": true,
                    "changed_at": 1617033600] as [String : Any]
        
        let item = ToDoItem.parse(json: json)

        XCTAssertNotNil(item)
        XCTAssertNil(item?.deadline)
    }

    func testParseMissingDone() {
        let json = ["text": "Test task", 
                    "created_at": 1617033600,
                    "importance": ItemImportance.important.rawValue,
                    "deadline": 1617120000,
                    "changed_at": 1617033600] as [String : Any]
        
        let item = ToDoItem.parse(json: json)

        XCTAssertNotNil(item)
        XCTAssertFalse(item!.done)
    }

    func testParseMissingChangedAt() {
        let json = ["text": "Test task", 
                    "created_at": 1617033600,
                    "importance": ItemImportance.important.rawValue,
                    "deadline": 1617120000,
                    "done": true] as [String : Any]
        let item = ToDoItem.parse(json: json)

        XCTAssertNotNil(item)
        XCTAssertNil(item?.changedAt)
    }

    func testParseMissingID() {
        let json = ["text": "Test task", 
                    "created_at": 1617033600,
                    "importance": ItemImportance.important.rawValue,
                    "deadline": 1617120000,
                    "done": true,
                    "changed_at": 1617033600] as [String : Any]
        
        let item = ToDoItem.parse(json: json)
        
        XCTAssertNotNil(item)
        XCTAssertNotNil(item?.id)
        XCTAssertEqual(item?.text, "Test task")
        XCTAssertEqual(item?.importance, .important)
        XCTAssertEqual(item?.deadline, Date(timeIntervalSince1970: 1617120000))
        XCTAssertEqual(item?.done, true)
        XCTAssertEqual(item?.createdAt, Date(timeIntervalSince1970: 1617033600))
        XCTAssertEqual(item?.changedAt, Date(timeIntervalSince1970: 1617033600))
    }
    
    func testParseRealJSON() {
        guard let fileUrl = Bundle.main.path(forResource: "test_1", ofType: "json") else { return }
        let item = ToDoItem.parse(json: fileUrl)
        XCTAssertNotNil(item)
    }
}
