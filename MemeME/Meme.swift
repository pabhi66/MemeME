//
//  Meme.swift
//  MemeME
//
//  Created by Abhishek Prajapati on 4/3/17.
//  Copyright © 2017 abhi. All rights reserved.
//

import UIKit

class Meme: NSObject, NSCoding {
    
    struct Keys {
        static let Image = "Image"
        static let MemedImage = "MemedImage"
        static let TopText = "Top"
        static let BottomText = "Bottom"
    }
    
    var image: UIImage!
    var memeImage: UIImage!
    var topText: String!
    var bottomText: String!
    
    init(image: UIImage, memeImage: UIImage, topText: String, bottomText: String) {
        self.image = image
        self.memeImage = memeImage
        self.topText = topText
        self.bottomText = bottomText
    }
    
//    override init() {}
    
    required init(coder aDecoder: NSCoder) {
        if let imgObj = aDecoder.decodeObject(forKey: Keys.Image) as? UIImage{
            image = imgObj;
        }
        if let MemimgObj = aDecoder.decodeObject(forKey: Keys.MemedImage) as? UIImage{
            memeImage = MemimgObj;
        }
        if let top = aDecoder.decodeObject(forKey: Keys.TopText) as? String{
            topText = top;
        }
        if let bottom = aDecoder.decodeObject(forKey: Keys.BottomText) as? String{
            bottomText = bottom;
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(image, forKey: Keys.Image)
        aCoder.encode(memeImage, forKey: Keys.MemedImage)
        aCoder.encode(topText, forKey: Keys.TopText)
        aCoder.encode(bottomText, forKey: Keys.BottomText)
    }
    
}
