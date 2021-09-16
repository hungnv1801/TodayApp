//
//  EditNotesCell.swift
//  ToDay
//
//  Created by Nguyen Trung on 31/08/2021.
//

import UIKit

class EditNotesCell: UITableViewCell {
    
    typealias NotesChangeAction = (String) -> Void
    
    @IBOutlet var notesTextView: UITextView!
    
    private var notesChangeAction: NotesChangeAction?
    
    override func awakeFromNib() {
            super.awakeFromNib()
            notesTextView.delegate = self
        }
    
    func configure(notes: String?, changeAction: NotesChangeAction?) {
        notesTextView.text = notes
        self.notesChangeAction = changeAction
    }
    
}

extension EditNotesCell: UITextViewDelegate {
    //Đoạn này thực thi cái gì
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if let originalText = textView.text {
                let title = (originalText as NSString).replacingCharacters(in: range, with: text)
                notesChangeAction?(title)
            }
            return true
        }
}
