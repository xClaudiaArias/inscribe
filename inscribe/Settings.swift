//
//  Settings.swift
//  inscribe
//
//  Created by Claudia Arias on 11/20/22.
//

import UIKit
import CoreData

extension Date {
    func ststring(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

class Settings: UIViewController {
    
    var currentUser = ""


    let ctx = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // user credentials array
    var userAttr: [User]?
    let currentDateTime = Date()
    
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
        lbDate.text = self.currentDateTime.ststring(format: "MM-dd-yyyy")
        fetchUser()
        // Do any additional setup after loading the view.
        btnChangePFP.configuration!.contentInsets = NSDirectionalEdgeInsets(top: 8.0, leading: 8.0, bottom: 0, trailing: 0)
    }
    
    func fetchUser() {
        
        do {
            let fetchRequest: NSFetchRequest<User>
            fetchRequest = User.fetchRequest()
            
            let objects = try ctx.fetch(fetchRequest)
            
            for obj in objects {
                if obj.username == currentUser {
                    lbFirst.text = obj.firstName
                    lbLast.text = obj.lastName
                    lbDate.text = self.currentDateTime.ststring(format: "MM-dd-yyyy")
                }
            }
        } catch {
            print(error)
        }
    }
    

    
    
    func updateUser() {
        do {
            let fetchRequest: NSFetchRequest<User>
            fetchRequest = User.fetchRequest()
        
            let objects = try ctx.fetch(fetchRequest)

            for obj in objects {
                if obj.username == currentUser {
                    if tfPassword.text == tfConfirmPss.text {
                        obj.firstName = tfFirstName.text
                        obj.lastName = tfLastName.text
                        obj.email = tfEmail.text
                        obj.username = tfUsername.text
                        obj.password = tfPassword.text
                        
                        do {
                            try self.ctx.save()
                        } catch {
                            print(error)
                        }
                    } else {
                        print("Goodbyeee")
                    }
                }
            }
        } catch {
            print(error)
        }
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
        self.updateUser()
    }
    
}

