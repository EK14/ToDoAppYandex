//  Created by Elina Karapetian on 15.06.2024.

import Foundation

struct ToDoItem {
    let id: String
    var text: String
    var importance: ItemImportance
    var deadline: Date?
    var isDone: Bool
    let createdAt: Date
    let changedAt: Date?
    var color: String?
    
    init(id: String? = UUID().uuidString,
         text: String,
         importance: ItemImportance,
         deadline: Date? = nil,
         isDone: Bool,
         createdAt: Date = Date.now,
         changedAt: Date? = nil,
         color: String? = nil) {
        self.id = id ?? UUID().uuidString
        self.text = text
        self.importance = importance
        self.deadline = deadline
        self.isDone = isDone
        self.createdAt = createdAt
        self.changedAt = changedAt
        self.color = color
    }
}

extension ToDoItem {
    // Сomputed property for generating json
    var json: Any {
        var jsonDict: [String: Any] = [
            "text": text,
        ]
        
        jsonDict["id"] = id

        // Don't save importance in json if it's "basic"
        if importance != .basic {
            jsonDict["importance"] = importance.rawValue
        }

        // Save deadline only if it is specified
        if let deadline = deadline {
            jsonDict["deadline"] = deadline.timeIntervalSince1970
        }
        
        jsonDict["created_at"] = createdAt.timeIntervalSince1970

        jsonDict["isDone"] = isDone
        
        return jsonDict
    }
    
    // - Parameter json: A JSON object in the form of a URL or a dictionary
    // - Returns: A ToDoItem object if the JSON is valid, or nil otherwise
    static func parse(json: Any) -> ToDoItem? {
        // Check if the input is a URL or a dictionary
        if let json = json as? URL {
            do {
                let data = try Data(contentsOf: json)
                return ToDoItem.createItem(data: data)
            } catch {
                print(error.localizedDescription)
            }
        } else if let json = json as? [String: Any] {
            print(Date(timeIntervalSince1970: 6.7))
            guard let data = try? JSONSerialization.data(withJSONObject: json) else {
                return nil
            }
            return ToDoItem.createItem(data: data)
        }
        return nil
    }
    
    // - Parameter data: A Data object containing the JSON data
    // - Returns: A ToDoItem instance if the JSON data is valid and contains all required fields, or nil otherwise
    private static func createItem(data: Data) -> ToDoItem? {
        guard let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return nil
        }
        
        let id = jsonDict["id"] as? String
        
        guard let text = jsonDict["text"] as? String,
              let createdAt = jsonDict["created_at"] as? TimeInterval,
              let importanceString = jsonDict["importance"] as? String,
              let importance = ItemImportance(rawValue: importanceString) else {
            return nil
        }
        
        let deadline = jsonDict["deadline"] as? TimeInterval
        
        let done = jsonDict["done"] as? Bool ?? false
        
        let changedAt = jsonDict["changed_at"] as? TimeInterval
        
        return ToDoItem(id: id, text: text, importance: importance, deadline: deadline.map { Date(timeIntervalSince1970: $0) }, isDone: done, createdAt: Date(timeIntervalSince1970: createdAt), changedAt: changedAt.map { Date(timeIntervalSince1970: $0) })
    }
}

extension ToDoItem {
    static func parseCSV(csvName: String) -> [ToDoItem]? {
        var toDoItems = [ToDoItem]()
        
        guard let filePath = Bundle.main.path(forResource: csvName, ofType: "csv") else { return nil }
        
        var data = ""
        do {
            data = try String(contentsOfFile: filePath)
        } catch {
            print(error.localizedDescription)
            return nil
        }
        
        var rows = data.components(separatedBy: "\n")
        
        rows.removeFirst()
        
        for row in rows {
            let csvColumn = row.components(separatedBy: ",")
            let item = ToDoItem.init(text: csvColumn[0],
                                     importance: ItemImportance(rawValue: csvColumn[1]) ?? .basic,
                                     isDone: Bool(csvColumn[2]) ?? false,
                                     createdAt: Date(timeIntervalSince1970: TimeInterval(Int(csvColumn[3]) ?? 0)))
            toDoItems.append(item)
        }
        return toDoItems
    }
}
