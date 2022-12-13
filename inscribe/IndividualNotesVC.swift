//
//  IndividualNotesVC.swift
//  inscribe
//
//  Created by Claudia Arias on 12/9/22.
//

import UIKit
import CoreData

class IndividualNotesVC: UIViewController {
    
    var currentUser = ""
    var noteTitle = ""
    var dt = ""
    var post = ""

    @IBOutlet weak var lbNoteTitle: UILabel!
    @IBOutlet weak var lbDt: UILabel!
    @IBOutlet weak var lbPost: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbNoteTitle.text = noteTitle
        lbDt.text = dt
        lbPost.text = post
        // Do any additional setup after loading the view.
    }
    

}
