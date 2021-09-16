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
    
    typealias ReminderChangeAction = (Reminder) -> Void
    
    private var reminder: Reminder?
    //    private var detailViewDataSource: ReminderDetailViewDataSource?
    private var tempReminder: Reminder?
    private var dataSource: UITableViewDataSource?
    private var reminderEditAction: ReminderChangeAction?
    private var reminderAddAction: ReminderChangeAction?
    private var isNew = true
    
    
    
    func configure(with reminder: Reminder, isNew: Bool = true, addAction: ReminderChangeAction? = nil, editAction: ReminderChangeAction? = nil) {
        self.reminder = reminder
        self.isNew = isNew
        self.reminderEditAction = editAction
        self.reminderAddAction = addAction
//        Check xem ViewLoaded đã đc tải vào bộ nhớ chưa 
        if isViewLoaded {
            setEditing(isNew, animated: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setEditing(isNew, animated: false)
        navigationItem.setRightBarButton(editButtonItem, animated: false)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ReminderDetailEditDataSource.dateLabelCellIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navigationController = navigationController, !navigationController.isToolbarHidden {
            navigationController.setToolbarHidden(true, animated: animated)
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        guard let reminder = reminder else {
            fatalError("No reminder found for detail view")
        }
        //        Add an if statement that sets the data source based on the edit mode. If editing is true, set the dataSource property to a new edit data source.
        if editing {
            dataSource = ReminderDetailEditDataSource(reminder: reminder) {
                reminder in
                self.tempReminder = reminder
                self.editButtonItem.isEnabled = true
            }
            navigationItem.title = isNew ? NSLocalizedString("Edit Reminder", comment: "edit reminder nav title") : NSLocalizedString("Edit Reminder", comment: "edit reminder nav title")
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTrigger))
        } else {
            if let tempReminder = tempReminder {
                self.reminder = tempReminder
                self.tempReminder = nil
                reminderEditAction?(tempReminder)
                dataSource = ReminderDetailViewDataSource(reminder: tempReminder)
            } else {
                dataSource = ReminderDetailViewDataSource(reminder: reminder)
            }
            navigationItem.title = NSLocalizedString("View Reminder", comment: "view reminder nav title")
//            dataSource = ReminderDetailViewDataSource(reminder: reminder)
            navigationItem.leftBarButtonItem = nil
            editButtonItem.isEnabled = true
        }
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    @objc
    func  cancelButtonTrigger() {
        
        tempReminder = nil
        setEditing(false, animated: true)
    }
}


