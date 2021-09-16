//
//  EditTitleCell.swift
//  ToDay
//
//  Created by Nguyen Trung on 31/08/2021.
//

import UIKit

class EditTitleCell: UITableViewCell {
    
    typealias TitleChangeAction = (String) -> Void
    
    @IBOutlet var titleTextField: UITextField!
    
    private var titleChangeAction: TitleChangeAction?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleTextField.delegate = self
    }
    
//    Define a configure method that accepts a String and assigns it to the text property of the text field.
    func configure(title: String, changeAction: @escaping TitleChangeAction) {
        titleTextField.text = title
        self.titleChangeAction = changeAction
    }
}

extension EditTitleCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let originalText = textField.text {
            let title = (originalText as NSString).replacingCharacters(in: range, with: string)
	            titleChangeAction?(title)
        }
        return true
    }
}
