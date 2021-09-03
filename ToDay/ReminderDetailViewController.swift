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
    
    private var reminder: Reminder?
    //    private var detailViewDataSource: ReminderDetailViewDataSource?
    private var dataSource: UITableViewDataSource?
    func configure(with reminder: Reminder) {
        self.reminder = reminder
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setEditing(false, animated: false)
        navigationItem.setRightBarButton(editButtonItem, animated: false)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ReminderDetailEditDataSource.dateLabelCellIdentifier)

//        guard let reminder = reminder else {
//            fatalError("No reminder found for detail view")
//        }
        dataSource = ReminderDetailViewDataSource(reminder: reminder!)
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        guard let reminder = reminder else {
            fatalError("No reminder found for detail view")
        }
        //        Add an if statement that sets the data source based on the edit mode. If editing is true, set the dataSource property to a new edit data source.
        if editing {
            dataSource = ReminderDetailEditDataSource(reminder: reminder)
        } else {
            dataSource = ReminderDetailViewDataSource(reminder: reminder)
        }
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


