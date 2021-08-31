////
////  ReminderDetailViewController.swift
////  ToDay
////
////  Created by Nguyen Trung on 25/08/2021.
////
import UIKit
//
//Creating a Detail View Controller
class ReminderDetailViewController: UITableViewController {
//    enum ReminderRow: Int, CaseIterable {
//        case title
//        case date
//        case time
//        case notes
//
//        func displayText(for reminder: Reminder?) -> String? {
//
//            switch self {
//            case .title:
//                return reminder?.title
//            case .date:
//                return reminder?.dueDate.description
//            case .time:
//                return reminder?.dueDate.description
//            case .notes:
//                return reminder?.notes
//            }
//        }
//        //Tạo thuộc tính có tên để trả về hình ảnh cho hàng.cellImage
//        var cellImage: UIImage? {
//            switch self {
//                case .title:
//                    return nil
//                case .date:
//                    return UIImage(systemName: "calendar.circle")
//                case .time:
//                    return UIImage(systemName: "clock")
//                case .notes:
//                    return UIImage(systemName: "square.and.pencil")
//            }
//        }
//    }
    private var reminder: Reminder?
    private var detailViewDataSource: ReminderDetailViewDataSource?
    func configure(with reminder: Reminder) {
        self.reminder = reminder
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let reminder = reminder else {
            fatalError("No reminder found for detail view")
        }
        detailViewDataSource = ReminderDetailViewDataSource(reminder: reminder)
        tableView.dataSource = detailViewDataSource	
    }
}

extension ReminderDetailViewController {
//    static let reminderDetailCellIdentifier = "ReminderDetailCell"
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return ReminderRow.allCases.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell = tableView.dequeueReusableCell(withIdentifier: Self.reminderDetailCellIdentifier, for: indexPath)
//            let row = ReminderRow(rawValue: indexPath.row)
//            cell.textLabel?.text = row?.displayText(for: reminder)
//            cell.imageView?.image = row?.cellImage
//            return cell
//    }
}


