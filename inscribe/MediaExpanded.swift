//
//  MediaExpanded.swift
//  inscribe
//
//  Created by Claudia Arias on 11/20/22.
//

import UIKit

class MediaExpanded: UIViewController {
    
    // image identifier
    static let identifier = "MediaExpanded"
    static func nib() -> UINib {return UINib(nibName: "MediaExpanded", bundle: nil)}
    
    // fields
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var ivMediaExp: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnDelete(_ sender: Any) {
    }
    
}

