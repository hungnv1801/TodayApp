//
//  ViewController.swift
//  ToDay
//
//  Created by Nguyen Trung on 24/08/2021.
//

import UIKit

class ReminderListViewController: UITableViewController {

    static let showDetailSegueIdentifier = "ShowReminderDetailSegue"
    static let mainStoryboardName = "Main"
    static let detailViewControllerIdentifier = "ReminderDetailViewController"
    
    private var reminderListDataSource: ReminderListDataSource?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Self.showDetailSegueIdentifier,
            let destination = segue.destination as? ReminderDetailViewController,
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) {
            let rowIndex = indexPath.row
            guard let reminder = reminderListDataSource?.reminder(at: rowIndex) else {
                fatalError("Couldn't find data source for reminder list.")
            }
            
//            let reminder = Reminder.testData[indexPath.row]
            destination.configure(with: reminder, editAction: { reminder in
                self.reminderListDataSource?.update(reminder, at: rowIndex)
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        reminderListDataSource = ReminderListDataSource()
        tableView.dataSource = reminderListDataSource
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navigationcontroller = navigationController,
           navigationcontroller.isToolbarHidden {
            navigationcontroller.setToolbarHidden(false, animated: animated)
        }
    }
    
    @IBAction func addButtonTriggered(_ sender: UIBarButtonItem) {
        addReminder()
    }
    
    private func addReminder() {
        let storyboard = UIStoryboard(name: Self.mainStoryboardName, bundle: nil)
        let detailViewController: ReminderDetailViewController = storyboard.instantiateViewController(identifier: Self.detailViewControllerIdentifier)
        let reminder = Reminder(title: "New Reminder", dueDate: Date())
        detailViewController.configure(with: reminder, isNew: true, addAction: { reminder in
        })
        let navigationController = UINavigationController(rootViewController: detailViewController)
        present(navigationController, animated: true, completion: nil)
        
    }
}

