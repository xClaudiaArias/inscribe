//
//  IndividualNotesVC.swift
//  inscribe
//
//  Created by Claudia Arias on 12/9/22.
//

import UIKit

extension Date {
    func intstring(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

class IndividualNotesVC: UIViewController {
    
    var currentUser = ""
    var currentNote = ""
    
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbPost: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

}
