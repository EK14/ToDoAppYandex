//
//  FileCacheTests.swift
//  ToDoAppTests
//
//  Created by Elina Karapetian on 22.06.2024.
//

import XCTest
import FileCache
@testable import ToDoApp

final class FileCacheTests: XCTestCase {
    
    let cache = FileCache.shared

    func testSaveFunction() {
        cache.addTask(ToDoItem(id: "1", text: "text", importance: .important, isDone: true, createdAt: Date(timeIntervalSince1970: 86400)))
        cache.addTask(ToDoItem(id: "2", text: "text", importance: .basic, isDone: true, createdAt: Date(timeIntervalSince1970: 86400)))
        cache.save()
    }
    
    func testRemoveTaskFunction() {
        cache.addTask(ToDoItem(id: "1", text: "text", importance: .important, isDone: true, createdAt: Date(timeIntervalSince1970: 86400)))
        cache.addTask(ToDoItem(id: "2", text: "text", importance: .basic, isDone: true, createdAt: Date(timeIntervalSince1970: 86400)))
        cache.removeTask("1")
        cache.save()
    }
    
    func testChangeFilenameFunction() {
        cache.addTask(ToDoItem(id: "1", text: "text", importance: .important, isDone: true, createdAt: Date(timeIntervalSince1970: 86400)))
        cache.addTask(ToDoItem(id: "2", text: "text", importance: .basic, isDone: true, createdAt: Date(timeIntervalSince1970: 86400)))
        cache.save()
    }
    
    func testUploadFunction() {
        cache.addTask(ToDoItem(id: "1", text: "text", importance: .important, isDone: true, createdAt: Date(timeIntervalSince1970: 86400)))
        cache.addTask(ToDoItem(id: "2", text: "text", importance: .basic, isDone: true, createdAt: Date(timeIntervalSince1970: 86400)))
        cache.save()
        cache.removeTask("1")
        cache.removeTask("2")
        cache.upload()
    }

}
