//
//  TableTableViewCell.swift
//  MemeME
//
//  Created by Abhishek Prajapati on 4/12/17.
//  Copyright © 2017 abhi. All rights reserved.
//

import UIKit

/**
 Table view cell class
 **/

class TableViewCell: UITableViewCell {

    //outlets
    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var memeLabel2: UILabel!
    @IBOutlet weak var memeLabel1: UILabel!
    @IBOutlet weak var imageBack: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //set up cell properties
    func setUpCell(meme: Meme){
        memeImage.image = meme.image
        memeLabel1.text = meme.topText
        memeLabel2.text = meme.bottomText
    }

}
