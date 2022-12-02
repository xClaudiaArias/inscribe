//
//  Register.swift
//  inscribe
//
//  Created by Claudia Arias on 11/20/22.
//

import UIKit

class Register: UIViewController {
    
    var fName = ""
    var lName = ""
    var email = ""
    var username = ""
    var password = ""
    
    
    let ctx = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // user credentials array
    var userAttr: [User]?
    
    
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfPasswordConfirm: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    // segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "sgLoginInstead" {
            let loginVC = segue.destination as! Login
        }
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        
    }
    
    @objc func dismissOnTapOutside(){
       self.dismiss(animated: true, completion: nil)
    }
    
    func validEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
    
    func checkPassword(_ thePassword: String) -> Bool {
        let passregex = "^(?=.*[A-Z])(?=.*[!@#$\\.&*])(?=.*[a-z].*[a-z].*[a-z]).{8,20}$"
        
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passregex)
        return passwordPred.evaluate(with: thePassword)
    }
    
    
    @IBAction func btnRegister(_ sender: Any) {
        let newUser = User(context: self.ctx)
        
        newUser.firstName = tfFirstName.text
        newUser.lastName = tfLastName.text
        newUser.email = tfEmail.text
        newUser.username = tfUsername.text
        newUser.password = tfPassword.text
        
        let isValidEmail = validEmail(tfEmail.text!)
        let isValidPass = checkPassword(tfPassword.text!)
        
        print(isValidPass, " isValidPass")
        
        if tfFirstName.text == "" ||
            tfLastName.text == "" ||
            tfEmail.text == "" ||
            tfUsername.text == "" ||
            tfPassword.text == "" ||
            tfPasswordConfirm.text == "" {
            let missingFieldAlert = UIAlertController(title: "Please fill in all the fields.", message: "Try again!", preferredStyle: .alert)
            self.present(missingFieldAlert, animated: true, completion: {
                missingFieldAlert.view.superview?.isUserInteractionEnabled = true
                missingFieldAlert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.dismissOnTapOutside)))
            })
        } else {
            if isValidPass {
                if newUser.password == tfPasswordConfirm.text {
                    if newUser.email!.contains(".com") || isValidEmail { //new line
                        print(newUser)
                        do {
                            try self.ctx.save()
                        } catch {
                            print(error)
                        }
                    } else {
                        let emailAlert = UIAlertController(title: "Please use a valid email", message: "Try again!", preferredStyle: .alert)
                        self.present(emailAlert, animated: true, completion: {
                            emailAlert.view.superview?.isUserInteractionEnabled = true
                            emailAlert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.dismissOnTapOutside)))
                        })
                    } // nl
                } else {
                    let errorAlert = UIAlertController(title: "Passwords do not to match", message: "Try again!", preferredStyle: .alert)
                    self.present(errorAlert, animated: true, completion: {
                        errorAlert.view.superview?.isUserInteractionEnabled = true
                        errorAlert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.dismissOnTapOutside)))
                    })
                }
                
            } else {
                let validPassAlert = UIAlertController(title: "Password must be 8 characters or more. Password must include a special symbol. Password must contain at least one capital letter.", message: "Try again!", preferredStyle: .alert)
                self.present(validPassAlert, animated: true, completion: {
                    validPassAlert.view.superview?.isUserInteractionEnabled = true
                    validPassAlert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.dismissOnTapOutside)))
                })
            }
        }
            
    }
}

