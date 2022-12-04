//
//  NotesExpanded.swift
//  inscribe
//
//  Created by Claudia Arias on 11/20/22.
//

import UIKit
import CoreData

class NotesExpanded: UIViewController {
    
    var currentUser = ""
    
    let ctx = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // user credentials array
    var userAttr: [User]?
    var notes: [Notes]?

    
    
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var tfNoteTitle: UITextField!
    
    
    @IBOutlet weak var tfNote: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnSave(_ sender: Any) {
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
                        
                        let objects = try ctx.fetch(fetchRequest)
                        try self.ctx.save()
                        
                    } catch {
                        print(error)
                    }
                }
            }
            
            do {
                try self.ctx.save()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
}

