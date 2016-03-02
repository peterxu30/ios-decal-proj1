//
//  ToDoItemCollection.swift
//  To-Do List
//
//  Created by Peter Xu on 2/27/16.
//  Copyright © 2016 Peter Xu. All rights reserved.
//

import UIKit

class ToDoItemCollection {
    
    let toDoItemCalendar = NSCalendar.currentCalendar()
    
    struct ToDoItem {
        var toDoText: String
        var toDoCreatedDate: NSDate
        var toDoCompleted: Bool
        var toDoID: String
        
        mutating func markToDoItem(mark: Bool) {
            toDoCompleted = mark
        }
    }
    
    private var toDoItemArray = Array<ToDoItem>()
    
    func createNewToDoItem(toDoText: String) {
        let newToDoItem = ToDoItem(toDoText: toDoText, toDoCreatedDate: NSDate(), toDoCompleted: false, toDoID: NSUUID().UUIDString)
        toDoItemArray.append(newToDoItem)
    }
    
    func getToDoItemAtIndex(index: Int) -> ToDoItem {
        return toDoItemArray[index]
    }
    
    func markToDoItem(item: ToDoItem, mark: Bool) {
        print(item.toDoText)
        let toDoID = item.toDoID
        for index in 0..<toDoItemArray.count {
            if toDoItemArray[index].toDoID == toDoID {
                toDoItemArray[index].markToDoItem(mark)
                break
            }
        }
        print(toDoItemArray[0].toDoCompleted)
    }
    
    func markToDoItemAsCompleted(item: ToDoItem) {
        markToDoItem(item, mark: true)
    }
    
    func markToDoItemAsUncompleted(item: ToDoItem) {
        markToDoItem(item, mark: false)
    }
    
    func deleteToDoItemAtIndex(index: Int) {
        toDoItemArray.removeAtIndex(index)
    }
    
    func deleteToDoItem(toDoItem: ToDoItem) {
        let index = 0
        while index < toDoItemArray.count {
            if toDoItem.toDoID == toDoItemArray[index].toDoID {
                break
            }
        }
        deleteToDoItemAtIndex(index)
    }
    
    func removeOverDayOldToDoItems() {
        let currentDate = NSDate()
//        print(currentDate)
        func isDateOlderThanCurrent(item: ToDoItem) -> Bool {
//            print("Created: \(item.toDoCreatedDate)")
            return toDoItemCalendar.compareDate(item.toDoCreatedDate, toDate: currentDate, toUnitGranularity: .Day) == .OrderedSame
        }
        toDoItemArray = toDoItemArray.filter(isDateOlderThanCurrent)
    }
    
    func count() -> Int {
        return toDoItemArray.count
    }
    
    func countNumberCompletedTasksInPastDay() -> Int {
        func isToDoItemCompleted(item: ToDoItem) -> Bool {
            print(item.toDoCompleted)
            return item.toDoCompleted
        }
        removeOverDayOldToDoItems()
        return toDoItemArray.filter(isToDoItemCompleted).count
    }
}
