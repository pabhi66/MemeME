//
//  MemeCollectionViewCell.swift
//  MemeME
//
//  Created by Abhishek Prajapati on 4/12/17.
//  Copyright © 2017 abhi. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //set up cell properties
    func setUpCell(meme: Meme){
        image.image = meme.image
        label1.text = meme.topText
        label2.text = meme.bottomText
    }
    
}
