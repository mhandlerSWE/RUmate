//
//  FeedCollectionViewCell.swift
//  RUmateApp
//
//  Created by Aryan Patel on 8/8/21.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemLabel: UILabel!
    
    func configure(with itemName: String){
        itemLabel.text = itemName
        
    }
    
    
}
