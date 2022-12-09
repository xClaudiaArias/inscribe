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
    
    var currentUser = ""


    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    let ctx = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
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

    
    @IBOutlet weak var btnLogin: UIButton!
    @IBAction func btnLogin(_ sender: Any) {
        username = tfUsername.text!
        password = tfPassword.text!
        
        do {
            let fetchRequest: NSFetchRequest<User>
            fetchRequest = User.fetchRequest()
        
            let objects = try ctx.fetch(fetchRequest)

            for obj in objects {
                if obj.username == tfUsername.text {
                    print(obj.username!, ":", obj.password!)
                    if tfPassword.text != "" {
                        if obj.password == tfPassword.text {
                            username = obj.username!
                            currentUser = username
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "sgLogin", sender: UIButton())
                            }

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
            
        } catch {
            
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "sgLogin" {
            let tabBarController = segue.destination as! UITabBarController
            //view controller
            let navBarController = tabBarController.viewControllers?[0] as! UINavigationController

            if let vc = navBarController.topViewController as? ViewController {
                    vc.currentUser = currentUser
            }
            
            // notes vc
            let noteNav = tabBarController.viewControllers?[1] as! UINavigationController
            let mediaNav = tabBarController.viewControllers?[2] as! UINavigationController
            let remindersNav = tabBarController.viewControllers?[3] as! UINavigationController
            let settingsNav = tabBarController.viewControllers?[4] as! UINavigationController
            
            if let noteVC = noteNav.topViewController as? Notes {
                noteVC.currentUser = currentUser
            }
            
//            print(tabBarController.viewControllers, " tabBar Controllers")
//            print(remindersNav, " remindersNavvvvvv")
            
            
            if let remindersVC = remindersNav.topViewController as? RemindersVC {
                remindersVC.currentUser = currentUser
            }
            
            if let settingsVC = settingsNav.topViewController as? Settings {
                settingsVC.currentUser = currentUser
            }
            

        }
    }
    
}


