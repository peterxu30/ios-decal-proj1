//
//  ToDoItem.swift
//  To-Do List
//
//  Created by Peter Xu on 2/23/16.
//  Copyright © 2016 Peter Xu. All rights reserved.
//

import UIKit

struct Player {
    var toDo: String?
    var done: Bool?
    var timeDone: Int?
    
    init(toDo: String?) {
        self.name = toDo
        self.done = false
        self.timeDone = nil
    }
}
