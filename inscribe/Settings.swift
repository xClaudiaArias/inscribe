//
//  Settings.swift
//  inscribe
//
//  Created by Claudia Arias on 11/20/22.
//

import UIKit

class Settings: UIViewController {
    
    
    @IBOutlet weak var ivPFP: UIImageView!
    @IBOutlet weak var lbFirst: UILabel!
    @IBOutlet weak var lbLast: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    
    // edit profile
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfDescription: UITextField!
    
    // edit account information
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirmPss: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btnChangePFP.configuration!.contentInsets = NSDirectionalEdgeInsets(top: 8.0, leading: 8.0, bottom: 0, trailing: 0)
    }
    
    // change pfp btn
    @IBOutlet weak var btnChangePFP: UIButton!
    @IBAction func btnChangePFP(_ sender: Any) {
    }
    
    // save profile btn
    @IBAction func btnSaveProfile(_ sender: Any) {
    }
    
    // save account changes btn
    @IBAction func btnSaveAccount(_ sender: Any) {
    }
    
}

