//
//  ViewController.swift
//  ToDay
//
//  Created by Nguyen Trung on 24/08/2021.
//

import UIKit

class ReminderListViewController: UITableViewController {

    private var reminderListDataSource: ReminderListDataSource?
    static let showDetailSegueIdentifier = "ShowReminderDetailSegue"

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Self.showDetailSegueIdentifier,
            let destination = segue.destination as? ReminderDetailViewController,
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) {
            let reminder = Reminder.testData[indexPath.row]
            destination.configure(with: reminder)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        reminderListDataSource = ReminderListDataSource()
        tableView.dataSource = reminderListDataSource
    }
}

extension ReminderListViewController {
    
//    static let reminderListCellIdentifier = "ReminderListCell"
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return Reminder.testData.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.reminderListCellIdentifier, for: indexPath) as? ReminderListCell else {
//                fatalError("Unable to dequeue ReminderCell")
//            }
//        let reminder = Reminder.testData[indexPath.row]
//        cell.configure(title: reminder.title, dateText: reminder.dueDate.description, isDone: reminder.isComplete, doneButtonAction: {
//            Reminder.testData[indexPath.row].isComplete.toggle()
//            tableView.reloadRows(at: [indexPath], with: .none)
//        })
//
//        let image = reminder.isComplete ? UIImage(systemName: "circle.fill") : UIImage(systemName: "circle")
//        cell.titleLabel.text = reminder.title
//        cell.dateLabel.text = reminder.dueDate.description
//        cell.doneButton.setBackgroundImage(image, for: .normal)
////        cell.doneButtonAction = {
////            Reminder.testData[indexPath.row].isComplete.toggle()
////            tableView.reloadRows(at: [indexPath], with: .none)
////        }
//        return cell
//        }
}
