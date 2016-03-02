//
//  AddToDoItemViewController.swift
//  To-Do List
//
//  Created by Peter Xu on 2/27/16.
//  Copyright © 2016 Peter Xu. All rights reserved.
//

import UIKit

class AddToDoItemViewController: UIViewController {
    
    var toDoList: ToDoItemCollection!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var toDoItemText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoItemText.layer.borderWidth = 2.0
    }
    
    func saveToDoItem() {
//        print("I worked")
        if toDoItemText.text != "" {
            toDoList.createNewToDoItem(toDoItemText.text)
//            print(toDoList.count())
        } else {
//            print("Not so fast")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        print("I twerked")
//        if (segue.identifier == "ToAddNewToDoItemSegue") {
//        print(sender!)
//            saveToDoItem()
        let button = sender as! UIBarButtonItem
        if button == saveButton {
            saveToDoItem()
        }
            let destinationVC = segue.destinationViewController as! ToDoListTableViewController
            destinationVC.toDoList = toDoList
//        }
    }

}
