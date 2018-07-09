//
//  ListNotesTableViewCell.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 10/18/15.
//  Copyright © 2015 Make School. All rights reserved.
//

import UIKit

class ListNotesTableViewCell: UITableViewCell {
    @IBOutlet weak var toDoTitleLabel: UILabel!
    @IBOutlet weak var toDoTimeCreated: UILabel!
    @IBOutlet weak var markAsCompleted: UIButton!
    var onButtonTouched: ((ListNotesTableViewCell) -> Void)? = nil
    @IBAction func onCheckBox(_ sender: Any) {
        markAsCompleted.isSelected = !markAsCompleted.isSelected
        onButtonTouched?(self)
    }
    
    
}

