//
//  Reminders.swift
//  inscribe
//
//  Created by Claudia Arias on 11/20/22.
//

import UIKit

//cells
class reminderCell: UITableViewCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbDesc: UILabel!
}

class Reminders: UIViewController {
    

    @IBOutlet weak var lbDate: UILabel!
    
    
    @IBOutlet weak var tvReminder: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var btnAddReminder: UIButton!
    @IBAction func btnAddReminder(_ sender: Any) {
    }
    
}

