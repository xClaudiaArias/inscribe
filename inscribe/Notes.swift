//
//  Notes.swift
//  inscribe
//
//  Created by Claudia Arias on 11/20/22.
//

import UIKit
import CoreData

class tvCellOrg: UITableViewCell {
    @IBOutlet weak var lbNoteTitle: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var btnViewNote: UIButton!
}

extension Date {
    func ntstring(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

class Notes: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    var currentUser = ""
    var noteTitle = ""
    var post = ""
    var dt = ""
    let currentDateTime = Date()
    
    // user profile
    @IBOutlet weak var ivUserPhoto: UIImageView!
    @IBOutlet weak var lbFirstName: UILabel!
    @IBOutlet weak var lbLastName: UILabel!
    @IBOutlet weak var lbDates: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    
    // user context
    
    let ctx = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var userAttr: [User]?
    var notes: [Note]?

    
    // tableview
    
    @IBOutlet weak var tvNotes: UITableView!



    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbDates.text = self.currentDateTime.ntstring(format: "MM-dd-yyyy")
        tvNotes.delegate = self
        tvNotes.dataSource = self
        self.fetchNotes()
        
        // changing button alignment
        btnAddNew.configuration!.contentInsets = NSDirectionalEdgeInsets(top: 8.0, leading: 8.0, bottom: 0, trailing: 0)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.fetchNotes()
        
    }
    


    func fetchNotes() {
        do {
            // ----- user
            
            let fetchRequest: NSFetchRequest<User>
            fetchRequest = User.fetchRequest()

            let objects = try ctx.fetch(fetchRequest)
            
            for obj in objects {
                if obj.username == currentUser {
                    lbFirstName.text = obj.firstName
                    lbLastName.text = obj.lastName
                }
            }
            
            // -----
            
            let request = Note.fetchRequest()
            let pred = NSPredicate(format: "user.username CONTAINS %@", currentUser)
            request.predicate = pred
            self.notes = try ctx.fetch(request)

            if self.notes?.contains(where: { $0.user?.username == currentUser}) != nil {
                DispatchQueue.main.async {
                    self.tvNotes.reloadData()
                }
            }

            }
         catch {
            print(error)
        }
    }
    

    // add new btn
    @IBOutlet weak var btnAddNew: UIButton!
    @IBAction func btnAddNew(_ sender: Any) {
        self.fetchNotes()
    }
    

    // table view functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.notes!.count
    }
    
    // height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let nt = self.notes![indexPath.row]
        
        noteTitle = nt.title!
        post = nt.note!
        dt = nt.date!
        
        performSegue(withIdentifier: "sgViewNote", sender: UITableView())
        
    }
    


    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteBtn = UIContextualAction(style: .destructive, title: "Delete") {(deleteBtn, view, completionHandler) in
            
            let noteDelete = self.notes![indexPath.row]
            self.ctx.delete(noteDelete)
            
            // update database
            do {
                try self.ctx.save()
            } catch {
                
            }
            //  we need to fetch again to refresh the list
            self.fetchNotes()
            
        }
        
        let editBtn = UIContextualAction(style: .normal, title: "Edit") {(editBtn, view, completionHandler) in
            
            let editNote = self.notes![indexPath.row]
            
            //            ______________________________________
            
            
            //        change actionsheet to alert if it doesnt work 👇
            let popUp = UIAlertController(title: "Edit", message: "", preferredStyle: .alert)
            popUp.addTextField{(textField) in textField.placeholder = "Title"}
            popUp.addTextField{(textField) in textField.placeholder = "Note"}
            
            
            // getting the field values
            let lbTitle = popUp.textFields![0]
            let lbNote = popUp.textFields![1]
            
            
            lbTitle.text = editNote.title
            lbNote.text = editNote.note
            
            let saveBtn = UIAlertAction(title: "Update", style: .default) { (action) in
                editNote.title = popUp.textFields![0].text
                editNote.note = popUp.textFields![1].text
                
                do {
                    try self.ctx.save()
                } catch {
                    
                }
                self.fetchNotes()
            }
            popUp.addAction(saveBtn)
            self.present(popUp, animated: true)

            do {
                try self.ctx.save()
            } catch {
                
            }

            self.fetchNotes()
            
        }
        
        return UISwipeActionsConfiguration(actions: [deleteBtn, editBtn])
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvNotes.dequeueReusableCell(withIdentifier: "tvCell", for: indexPath) as! tvCellOrg
        
        let user_notes = self.notes![indexPath.row]

        cell.lbNoteTitle.text = user_notes.title
        cell.lbDescription.text = user_notes.note
        cell.lbDate.text = user_notes.date
        
        


        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "sgAddNew" {
            if let vc = segue.destination as? NotesExpanded {
                vc.currentUser = currentUser
            }
        }
        
        if segue.identifier == "sgViewNote" {
            if let vn = segue.destination as? IndividualNotesVC {
                vn.currentUser = currentUser
                vn.noteTitle = noteTitle
                vn.dt = dt
                vn.post = post
            }
        }
    }

}
