//
//  ContentProvider.swift
//  MemeME
//
//  Created by Abhishek Prajapati on 4/12/17.
//  Copyright © 2017 abhi. All rights reserved.
//

import Foundation

class ContentProvider{
    
    //content provider
    static let provider = ContentProvider()
    
    //meme array
    private var memes = [Meme]()
    
    //get and set memes
    var getMemes:[Meme]{
        get {
            return memes
        }
        set {
            memes = newValue;
        }
    }
    
    //save the meme to array
    func saveMeme(_ meme: Meme){
        memes.append(meme)
    }
    
    //delete meme from an array
    func deleteMeme(_ index: Int){
        memes.remove(at: index)
    }
    
}
