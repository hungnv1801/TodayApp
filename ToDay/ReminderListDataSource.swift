//
//  ReminderListDataSource.swift
//  ToDay
//
//  Created by Nguyen Trung on 27/08/2021.
//

import UIKit

class ReminderListDataSource: NSObject {
    private lazy var dateFormatter = RelativeDateTimeFormatter()
}

extension ReminderListDataSource: UITableViewDataSource {
    
    static let reminderListCellIdentifier = "ReminderListCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Reminder.testData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:   ReminderListDataSource.reminderListCellIdentifier, for: indexPath) as? ReminderListCell else {
            fatalError("Unable to dequeue ReminderCell")
        }
        let reminder = Reminder.testData[indexPath.row]
        let image = reminder.isComplete ? UIImage(systemName: "circle.fill") : UIImage(systemName: "circle")
        let dateText = dateFormatter.localizedString(for: reminder.dueDate, relativeTo: Date())
        // Thay vì set giá trị cho từng label, button... như này thì dùng hàm, truyền các giá trị đó vào hàm để cell nó tự xử
        cell.configure(title: reminder.title, dateText: reminder.dueDate.description, isDone: reminder.isComplete, doneButtonAction: {
            Reminder.testData[indexPath.row].isComplete.toggle()
            tableView.reloadRows(at: [indexPath], with: .none)
        })
//        cell.titleLabel.text = reminder.title
//        cell.dateLabel.text = reminder.dueDate.description
//        cell.doneButton.setBackgroundImage(image, for: .normal)
//        cell.doneButtonAction = {
//            Reminder.testData[indexPath.row].isComplete.toggle()
//            tableView.reloadRows(at: [indexPath], with: .none)
//        }
        return cell
    }
    
}
