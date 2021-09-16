//
//  ReminderDetailEditDataSource.swift
//  ToDay
//
//  Created by Nguyen Trung on 31/08/2021.
//

import UIKit

class ReminderDetailEditDataSource: NSObject {
    
    typealias ReminderChangeAction = (Reminder) -> Void
    
    enum ReminderSection: Int, CaseIterable {
        case title
        case dueDate
        case notes
        
        var displayText: String {
            switch self {
            case .title:
                return "Title"
            case .dueDate:
                return "Date"
            case .notes:
                return "Notes"
            }
        }
        
        var numRows: Int {
            switch self {
            case .title, .notes:
                return 1
            case .dueDate:
                return 2
            }
        }
        
        func cellIdentifier(for row: Int) -> String {
            switch self {
            case .title:
                return "EditTitleCell"
            case .dueDate:
                return row == 0 ? "EditDateLabelCell" : "EditDateCell"
            case .notes:
                return "EditNotesCell"
            }
        }
        
    }
//    Add a static computed property to return the cell identifier of the date label. The data source uses a cell identifier to dequeue cells of a specific type.
    static var dateLabelCellIdentifier: String {
        return ReminderSection.dueDate.cellIdentifier(for: 0)
    }
    
    var reminder: Reminder
    private var reminderChangeAction: ReminderChangeAction?
    
    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        return formatter
    }()
    
    init(reminder: Reminder, changeAction: @escaping ReminderChangeAction) {
        self.reminderChangeAction = changeAction
        self.reminder = reminder
    }
    
    private func dequeueAndConfigureCell(for indexPath: IndexPath, from tableView: UITableView) -> UITableViewCell {
        guard let section = ReminderSection(rawValue: indexPath.section) else {
            fatalError("Section index out of range")
        }
        let identifier = section.cellIdentifier(for: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        switch section {
        case .title:
            if let titleCell = cell as? EditTitleCell {
                titleCell.configure(title: reminder.title) {
                    tittle in self.reminder.title = tittle
                    self.reminderChangeAction?(self.reminder)
                }
            }
        case .dueDate:
            if indexPath.row == 0 {
                cell.textLabel?.text = formatter.string(from: reminder.dueDate)
//                cell.textLabel?.text = reminder.dueDate.description
            } else {
                if let dueDateCell = cell as? EditDateCell {
                    dueDateCell.configure(date: reminder.dueDate) {
                        date in
                        self.reminder.dueDate = date
                        self.reminderChangeAction?(self.reminder)
                        let indexPath = IndexPath(row: 0, section: section.rawValue)
                        tableView.reloadRows(at: [indexPath], with: .automatic)

                    }
                }
            }
        case .notes:
            if let notesCell = cell as? EditNotesCell {
                notesCell.configure(notes: reminder.notes){ notes in
                    self.reminder.notes = notes
                    self.reminderChangeAction?(self.reminder)
            
                }
            }

        }
        return cell
    }
}
extension ReminderDetailEditDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        ReminderSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ReminderSection(rawValue: section)?.numRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        fatalError()
        return dequeueAndConfigureCell(for: indexPath, from: tableView)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = ReminderSection(rawValue: section) else {
            fatalError("Section index out of range")
        }
        return section.displayText
    }
//    If a cell is editable, the table view can display controls to remove or reorder the cell. Return false so that these controls are never displayed in this view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
