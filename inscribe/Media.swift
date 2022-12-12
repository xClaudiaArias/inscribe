//
//  Media.swift
//  inscribe
//
//  Created by Claudia Arias on 11/20/22.
//

import UIKit


extension Date {
    func mdstring(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

class Media: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    let currentDateTime = Date()
    
    @IBOutlet weak var cvMedia: UICollectionView!
    
    @IBOutlet weak var lbDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbDate.text = self.currentDateTime.mdstring(format: "MM-dd-yyyy")
        // Do any additional setup after loading the view.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 105
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cvCell = cvMedia.dequeueReusableCell(withReuseIdentifier: "mediaCell", for: indexPath) as? MediaCellVC
        
        return cvCell!
    }

}

