//
//  ViewController.swift
//  inscribe
//
//  Created by Claudia Arias on 11/13/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
//    static let identifier = "ViewController"
//    static func nib() -> UINib {return UINib(nibName: "ViewController", bundle: nil)}
//    
    

    // users information
    @IBOutlet weak var ivUserPhoto: UIImageView!
    @IBOutlet weak var lbFirstName: UILabel!
    @IBOutlet weak var lbLastName: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    
    // date
    @IBOutlet weak var lbMonth: UILabel!
    @IBOutlet weak var lbDay: UILabel!
    @IBOutlet weak var lbYear: UILabel!
    
    // count labels
    @IBOutlet weak var lbNotesCount: UILabel!
    @IBOutlet weak var lbRemindersCount: UILabel!
    @IBOutlet weak var lbMediaCount: UILabel!
    @IBOutlet weak var lbRecentlyDeletedCount: UILabel!
    
    // coredata
    let ctx = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // user credentials array
    var userAttr: [User]?
    
    var currentUser = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        fetchData()
//        lbFirstName.text = currentUser

        // changing button alignment
        btnNotes.configuration!.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8.0, trailing: 8.0)
        btnReminders.configuration!.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8.0, trailing: 8.0)
        btnMedia.configuration!.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8.0, trailing: 8.0)
        btnRecentlyDeleted.configuration!.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8.0, trailing: 8.0)
    }
    
    
    func fetchData() {
        do {
            
            let fetchRequest: NSFetchRequest<User>
            fetchRequest = User.fetchRequest()
            
            let objects = try ctx.fetch(fetchRequest)
            
            for obj in objects {
                print(obj.username!, ":", obj.password!, " :::in ViewController")
                if currentUser == obj.username {
                    lbFirstName.text = obj.firstName!
                    lbLastName.text = obj.lastName!
                }
            }
        } catch {
            print(error)
        }
    }
    
    
    // view buttons
    // -- notes:
    @IBOutlet weak var btnNotes: UIButton!
    @IBAction func btnNotes(_ sender: Any) {
    }
    // -- reminders:
    @IBOutlet weak var btnReminders: UIButton!
    @IBAction func btnReminders(_ sender: Any) {
    }
    // -- media:
    @IBOutlet weak var btnMedia: UIButton!
    @IBAction func btnMedia(_ sender: Any) {
    }
    // -- Recently Deleted:
    @IBOutlet weak var btnRecentlyDeleted: UIButton!
    @IBAction func btnRecentlyDeleted(_ sender: Any) {
    }
}

