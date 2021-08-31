//
//  EditTitleCell.swift
//  ToDay
//
//  Created by Nguyen Trung on 31/08/2021.
//

import UIKit

class EditTitleCell: UITableViewCell {
    @IBOutlet var titleTextField: UITextField!
    
//    Define a configure method that accepts a String and assigns it to the text property of the text field.
    func configure(title: String) {
        titleTextField.text = title
    }
}
