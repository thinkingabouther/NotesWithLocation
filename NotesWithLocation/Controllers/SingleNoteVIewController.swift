//
//  SingleNoteVIewController.swift
//  NotesWithLocation
//
//  Created by Arseny Neustroev on 14/11/2019.
//  Copyright © 2019 Arseny Neustroev. All rights reserved.
//

import UIKit

class SingleNoteVIewController: UITableViewController {

    var currentNote : Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteNameField.text = currentNote?.name
        noteTextDescriptionView.text = currentNote?.textDescription
    }
    
    @IBOutlet weak var noteImageView: UIImageView!
    @IBOutlet weak var noteTextDescriptionView: UITextView!
    @IBOutlet weak var noteNameField: UITextField!
}
