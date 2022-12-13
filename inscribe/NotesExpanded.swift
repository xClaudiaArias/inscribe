//
//  NotesExpanded.swift
//  inscribe
//
//  Created by Claudia Arias on 11/20/22.
//

import UIKit
import CoreData


extension Date {
    func ntxstring(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

class NotesExpanded: UIViewController {
    
    
    var currentUser = ""
    
    let ctx = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // user credentials array
    var userAttr: [User]?
    var notes: [Note]?
    
    let notesVC = Notes()
    let currentDateTime = Date()
    
    
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var tfNoteTitle: UITextField!
    @IBOutlet weak var tfNote: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lbDate.text = self.currentDateTime.ntxstring(format: "MM-dd-yyyy")

    }

    
    
    func createNote() {
        do {
            let reqUser: NSFetchRequest<User>
            reqUser = User.fetchRequest()
            
            let userObj = try ctx.fetch(reqUser)
            
            for obj in userObj {
                if obj.username == currentUser {
                    do {
                        let newNote = Note(context: self.ctx)
                        let fetchRequest: NSFetchRequest<Note>
                        fetchRequest = Note.fetchRequest()
                        
                        newNote.title = tfNoteTitle.text
                        newNote.note = tfNote.text
                        newNote.user = obj.self
                        newNote.date = self.currentDateTime.ntxstring(format: "MM-dd-yyyy")
                        
                        let objects = try ctx.fetch(fetchRequest)
                        try self.ctx.save()
                        
                        
                        self.navigationController?.popViewController(animated: true)
                        self.dismiss(animated: true, completion: nil)
                        
                        
                    } catch {
                        print(error)
                    }
                }
            }
        } catch {
            print(error)
        }
    }
    


    @IBAction func btnSave(_ sender: Any) {
        createNote()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "saveNoteBtn" {
//            let ntVC = segue.destination as? Notes
//
////            do {
////                try self.notes = ctx.fetch(Note.fetchRequest())
////                DispatchQueue.main.async {
////                    ntVC?.fetchNotes()
////                }
////            } catch {
////
////            }
//
//        }
//    }
    
}

