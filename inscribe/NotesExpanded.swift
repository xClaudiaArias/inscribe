//
//  NotesExpanded.swift
//  inscribe
//
//  Created by Claudia Arias on 11/20/22.
//

import UIKit

class NotesExpanded: UIViewController {
    
    
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var tfNoteTitle: UITextField!
    
    
    @IBOutlet weak var tfNote: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnSave(_ sender: Any) {
    }
    
}

