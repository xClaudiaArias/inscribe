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
            print(self.notes.self, " self.notes.self")
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
    
    
    // view note btn
    
    @IBAction func btnViewNote(_ sender: Any) {
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

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvNotes.dequeueReusableCell(withIdentifier: "tvCell", for: indexPath) as! tvCellOrg
        
        let user_notes = self.notes![indexPath.row]

        cell.lbNoteTitle.text = user_notes.title
        cell.lbDescription.text = user_notes.note
        cell.lbDate.text = self.currentDateTime.vcstring(format: "MM-dd-yyyy")
        
        


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
            }
        }
    }

}

