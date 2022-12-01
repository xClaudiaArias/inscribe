//
//  Login.swift
//  inscribe
//
//  Created by Claudia Arias on 11/20/22.
//

import UIKit

class Login: UIViewController {


    var username = ""
    var password = ""
    
    
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        // change btns to align left here:
        btnForgot.configuration!.contentInsets = NSDirectionalEdgeInsets(top: 8.0, leading: 8.0, bottom: 0, trailing: 0)
    }
    
    @IBOutlet weak var btnForgot: UIButton!
    @IBAction func btnForgot(_ sender: Any) {
    }

    @IBAction func btnRegister(_ sender: Any) {
    }
    
    @IBAction func btnLogin(_ sender: Any) {
    }
    
}


