//
//  Media.swift
//  inscribe
//
//  Created by Claudia Arias on 11/20/22.
//

import UIKit

// needs extension class here


class Media: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    @IBOutlet weak var cvMedia: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
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

