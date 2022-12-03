//
//  Login.swift
//  inscribe
//
//  Created by Claudia Arias on 11/20/22.
//

import UIKit
import CoreData

class Login: UIViewController {


    var username = ""
    var password = ""
    

    
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    let ctx = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // user credentials array
    var userAttr: [User]?


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        username = tfUsername.text!
        password = tfPassword.text!
        // change btns to align left here:
        btnForgot.configuration!.contentInsets = NSDirectionalEdgeInsets(top: 8.0, leading: 8.0, bottom: 0, trailing: 0)
    }
    
    @objc func dismissOnTapOutside(){
       self.dismiss(animated: true, completion: nil)
    }

    
    @IBOutlet weak var btnForgot: UIButton!
    @IBAction func btnForgot(_ sender: Any) {
    }

    
    @IBAction func btnLogin(_ sender: Any) {
        username = tfUsername.text!
        password = tfPassword.text!
        
        do {
            let fetchRequest: NSFetchRequest<User>
            fetchRequest = User.fetchRequest()
            
            // 👇 dont delete this, you will need it
            
//            fetchRequest.predicate = NSPredicate(
//                format: "name LIKE %@", self.username
//            )
            
            let objects = try ctx.fetch(fetchRequest)
            
            for obj in objects {
                if obj.username == tfUsername.text {
                    print(obj.username!, ":", obj.password!)
                    if tfPassword.text != "" {
                        if obj.password == tfPassword.text {
                            performSegue(withIdentifier: "sgLoginAuth", sender: nil)
                        }
                        else {
                            let errorAlert = UIAlertController(title: "Password or username is incorrect.", message: "Try again!", preferredStyle: .alert)
                            self.present(errorAlert, animated: true, completion: {
                                errorAlert.view.superview?.isUserInteractionEnabled = true
                                errorAlert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.dismissOnTapOutside)))
                            })
                        }
                        
                    } else {
                        let errorAlert = UIAlertController(title: "Password can't be empty.", message: "Try again!", preferredStyle: .alert)
                        self.present(errorAlert, animated: true, completion: {
                            errorAlert.view.superview?.isUserInteractionEnabled = true
                            errorAlert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.dismissOnTapOutside)))
                        })
                    }
                    
                }
            }
            
            // 👆 NOW I JUST HAVE TO LOOP THROUGH THE ARRAY TO GET THE ELEMENT THAT MATCHEST MYT PREDICATE
            // THEN ADD A CONDITIONAL (IF-ELSE) WITH THE CORRECT SEGUE IDENTIFIER (it is not vcAuth)
            // 👉 performSegue(withIdentifier: "vcAuth", sender: nil)
            // see if u can use things from VERIFY FN for password ver
            
        } catch {
            
        }
    }
    
    
//    ------
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = (self.tabBarController?.viewControllers![0] as? UINavigationController)?.viewControllers[0] as? ViewController
        
        
    }
    

}


