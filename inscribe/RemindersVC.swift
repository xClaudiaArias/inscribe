//
//  RemindersVC.swift
//  inscribe
//
//  Created by Claudia Arias on 12/7/22.
//

import UIKit
import CoreData

extension Date {
    func rmstring(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}


//cells
class reminderCell: UITableViewCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDt: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
}

class RemindersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var currentUser = ""

    let ctx = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // user credentials array
    var userAttr: [User]?
    var reminders: [Reminder]?
    let currentDateTime = Date()
    
    
    @IBOutlet weak var tvReminders: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        tvReminders.dataSource = self
        tvReminders.delegate = self
        self.fetchReminders()
    }

    
    func fetchReminders() {
        do {
            let request = Reminder.fetchRequest()
            let pred = NSPredicate(format: "user.username CONTAINS %@", currentUser)
            request.predicate = pred
            self.reminders = try ctx.fetch(request)
            print(currentUser, " currentUser")
           
            if self.reminders?.contains(where: { $0.user?.username == currentUser}) != nil {
                
                DispatchQueue.main.async {
                    self.tvReminders.reloadData()
                }
            }
        } catch {
            print(error)
        }
    }
    
    
    @objc func dismissOnTapOutside(){
       self.dismiss(animated: true, completion: nil)
    }
    
    // add btn
    @IBOutlet weak var btnAdd: UIButton!
    @IBAction func btnAdd(_ sender: Any) {
    
        
        let popUp =  UIAlertController(title: "Reminders", message: "Add a new reminder", preferredStyle: .alert)

                
        do {
            let fetchRequest: NSFetchRequest<User>
            fetchRequest = User.fetchRequest()
            
            let objects = try ctx.fetch(fetchRequest)
            
            for obj in objects {
                if obj.username == currentUser {
                    popUp.addTextField{(textField) in textField.placeholder = "Reminder"}
                    popUp.addTextField{(textField) in textField.placeholder = "Description"}



                    
                    let submitBtn = UIAlertAction(title: "Add Reminder", style: .default) {
                        (action) in
                        let newReminder = Reminder(context: self.ctx)
                        newReminder.title = popUp.textFields![0].text
                        newReminder.attribute = popUp.textFields![1].text
                        newReminder.date = self.currentDateTime.rmstring(format: "MM-dd-yyyy")
                        newReminder.user = obj.self
                        print(newReminder)

                        
                        do {
                            
                            if newReminder.user?.username == self.currentUser {
                                print(newReminder.user?.username == self.currentUser)
                                try self.ctx.save()
                            }

                        } catch {
                            print(error)
                        }
                        
                        
                        self.fetchReminders()
                    }
                    popUp.addAction(submitBtn)
                    
                    self.present(popUp, animated: true, completion: {
                        popUp.view.superview?.isUserInteractionEnabled = true
                        popUp.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.dismissOnTapOutside)))
                    })
                       
                }
            }
        } catch {
            print(error)
        }
         
    }
    
    // delete items by swiping
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteBtn = UIContextualAction(style: .destructive, title: "Delete") {(deleteBtn, view, completionHandler) in
            
            let reminderDelete = self.reminders![indexPath.row]
            self.ctx.delete(reminderDelete)
            
            // update database
            do {
                try self.ctx.save()
            } catch {
                
            }
            //  we need to fetch again to refresh the list
            self.fetchReminders()
        }
        
        let strikeBtn = UIContextualAction(style: .normal, title: "Complete") {(strikeBtn, view, completionHandler) in
            
            let strike = self.reminders![indexPath.row]
            
            
            
            
            
        }
                                        
        return UISwipeActionsConfiguration(actions: [deleteBtn, strikeBtn])
    }
    

    // edit item
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // row content -- item
        let rem = self.reminders![indexPath.row]
        // alert popup
        
//        change actionsheet to alert if it doesnt work 👇
        let popUp = UIAlertController(title: "Edit", message: "", preferredStyle: .alert)
        popUp.addTextField{(textField) in textField.placeholder = "Title"}
        popUp.addTextField{(textField) in textField.placeholder = "Description"}
//        popUp.addTextField{(textField) in textField.placeholder = "Date"}
        
        // getting the field values
        let lbTitle = popUp.textFields![0]
        let lbDescription = popUp.textFields![1]
//        var lbDt = self.currentDateTime.string(format: "MM-dd-yyyy")
        
        lbTitle.text = rem.title
        lbDescription.text = rem.description
//        lbDt = self.currentDateTime.string(format: "MM-dd-yyyy")
    
        
        // save it back when using the edit BUTTON
        let saveBtn = UIAlertAction(title: "Update", style: .default) { (action) in
            rem.title = popUp.textFields![0].text
            rem.attribute = popUp.textFields![1].text
            rem.date = self.currentDateTime.rmstring(format: "MM-dd-yyyy")
            // fetch reminder again to refresh data
            do {
                try self.ctx.save()
            } catch {
                
            }
            self.fetchReminders()
        }
        popUp.addAction(saveBtn)
        self.present(popUp, animated: true)
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.reminders!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reminderCell = tableView.dequeueReusableCell(withIdentifier: "remindCell", for: indexPath) as! reminderCell
        
        let remind = self.reminders![indexPath.row]
        
        reminderCell.lbTitle.text = remind.title
        reminderCell.lbDescription.text = remind.attribute
        reminderCell.lbDt.text = remind.date
        
        return reminderCell
    }
    
}
