//
//  RemindersVC.swift
//  inscribe
//
//  Created by Claudia Arias on 12/7/22.
//

import UIKit
import CoreData

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
           
//            print(self.reminders?.contains(where: { $0.user?.username == self.currentUser}), "blahbah")
            
            if self.reminders?.contains(where: { $0.user?.username == currentUser}) != nil {
                
                DispatchQueue.main.async {
                    self.tvReminders.reloadData()
                }
            }
        } catch {
            print(error)
        }
    }
    
    
    
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
                    popUp.addTextField{(textField) in textField.placeholder = "Date"}
                    
                    let submitBtn = UIAlertAction(title: "Add Reminder", style: .default) {
                        (action) in
                        let newReminder = Reminder(context: self.ctx)
                        newReminder.title = popUp.textFields![0].text
                        newReminder.attribute = popUp.textFields![1].text
                        newReminder.date = popUp.textFields![2].text
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
                    self.present(popUp, animated: true)

                       
                }
            }
        } catch {
            print(error)
        }
         
    }
    
    // delete items by swiping
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") {(action, view, completionHandler) in
            
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
                                        
        return UISwipeActionsConfiguration(actions: [action])
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
        popUp.addTextField{(textField) in textField.placeholder = "Date"}
        
        // getting the field values
        let lbTitle = popUp.textFields![0]
        let lbDescription = popUp.textFields![1]
        let lbDt = popUp.textFields![2]
        
        lbTitle.text = rem.title
        lbDescription.text = rem.description
        lbDt.text = rem.date
        
        // save it back when using edit BUTTON
        let saveBtn = UIAlertAction(title: "Update", style: .default) { (action) in
            rem.title = popUp.textFields![0].text
            rem.attribute = popUp.textFields![1].text
            rem.date = popUp.textFields![2].text
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
