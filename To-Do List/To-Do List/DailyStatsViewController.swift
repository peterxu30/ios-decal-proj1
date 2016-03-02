//
//  DailyStatsViewController.swift
//  To-Do List
//
//  Created by Peter Xu on 3/1/16.
//  Copyright © 2016 Peter Xu. All rights reserved.
//

import UIKit

class DailyStatsViewController: UIViewController {
    
    var toDoList: ToDoItemCollection!
    
    @IBOutlet weak var numberOfCompletedTasksLabel: UILabel!
    @IBOutlet weak var productivityScoring: UILabel!
    
//    override func viewWillAppear(animated: Bool) {
//        toDoList.removeOverDayOldToDoItems()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let numTasksCompleted = toDoList.countNumberCompletedTasksInPastDay()
        // Do any additional setup after loading the view, typically from a nib.
        numberOfCompletedTasksLabel.text = String(numTasksCompleted)
        
        var score = "Not bad."
        switch numTasksCompleted {
        case 0:
            score = "Are you even alive?"
        case 1...3:
            score = "Break's over, pal."
        case 4...6:
            score = "Well, look at you."
        case 6...10:
            score = "Woah, we got a badass over here."
        default:
            score = "You're just flirting with me now aren't you?"
        }
        productivityScoring.text = score
    }

}
