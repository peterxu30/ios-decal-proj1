//
//  ViewController.swift
//  To-Do List
//
//  Created by Peter Xu on 2/23/16.
//  Copyright © 2016 Peter Xu. All rights reserved.
//

import UIKit

class ToDoListTableViewController: UITableViewController {

    var toDoList: ToDoItemCollection!
    
    override func viewWillAppear(animated: Bool) {
        reloadData()
    }
    
    func reloadData() {
        toDoList.removeOverDayOldToDoItems()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        toDoList = ToDoItemCollection()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func unwindToToDoListTableViewController(segue: UIStoryboardSegue) {
    
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ToDoItemCell", forIndexPath: indexPath) as! ToDoListTableViewCell
        print("Row: \(indexPath.row)")
        let currentToDoItem = toDoList.getToDoItemAtIndex(indexPath.row)
        cell.toDoItem = currentToDoItem
        cell.textLabel?.text = currentToDoItem.toDoText
        return cell
    }
    
    func resetCellLabelAndAccessory(cell: ToDoListTableViewCell) {
        cell.textLabel?.textColor = .blackColor()
        cell.accessoryType = .None
    }
    
    func setAllCellTextFieldsToBlack(tableView: UITableView) {
        for cell in tableView.visibleCells {
            cell.textLabel?.textColor = .blackColor()
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        setAllCellTextFieldsToBlack(self.tableView)
        if (segue.identifier == "ToAddNewToDoItemSegue") {
            let navVC = segue.destinationViewController as! UINavigationController
            let tableVC = navVC.viewControllers.first as! AddToDoItemViewController
            tableVC.toDoList = toDoList
        }
        if (segue.identifier == "ToDailyStatsSegue") {
            let destinationVC = segue.destinationViewController as! DailyStatsViewController
            destinationVC.toDoList = toDoList
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?  {

        let cell = tableView.cellForRowAtIndexPath(indexPath) as! ToDoListTableViewCell

        let checkAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Completed" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in

            cell.accessoryType = .Checkmark
            self.toDoList.markToDoItemAsCompleted(cell.toDoItem)
        })
        checkAction.backgroundColor = .blueColor()
        
        let uncheckAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Not Completed" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in

            cell.accessoryType = .None
            self.toDoList.markToDoItemAsUncompleted(cell.toDoItem)
        })
        uncheckAction.backgroundColor = .orangeColor()

        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            // 4
            self.toDoList.deleteToDoItem(cell.toDoItem)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Top)
            self.resetCellLabelAndAccessory(cell)
            self.reloadData()
        })
        
        if (cell.accessoryType == .Checkmark) {
            return [uncheckAction, deleteAction]
        }
        return [checkAction,deleteAction]
    }
    
}
