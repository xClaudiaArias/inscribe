//
//  Notes.swift
//  inscribe
//
//  Created by Claudia Arias on 11/20/22.
//

import UIKit

class tvCellOrg: UITableViewCell {
    @IBOutlet weak var lbNoteTitle: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
}

class Notes: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // user profile
    @IBOutlet weak var ivUserPhoto: UIImageView!
    @IBOutlet weak var lbFirstName: UILabel!
    @IBOutlet weak var lbLastName: UILabel!
    @IBOutlet weak var lbDates: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    
    // tableview
    
    @IBOutlet weak var tvNotes: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // changing button alignment
        btnAddNew.configuration!.contentInsets = NSDirectionalEdgeInsets(top: 8.0, leading: 8.0, bottom: 0, trailing: 0)
    }
    
    
    // add new btn
    @IBOutlet weak var btnAddNew: UIButton!
    @IBAction func btnAddNew(_ sender: Any) {
    }
    
    // table view functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    // height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        fix later
        let cellOrg =
        tvNotes.dequeueReusableCell(withIdentifier: "tvCell", for: indexPath) as! tvCellOrg
        
        return cellOrg
        
    }
    
}

