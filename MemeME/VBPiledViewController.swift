//
//  VBPiledViewController.swift
//  MemeME
//
//  Created by Abhishek Prajapati on 5/8/17.
//  Copyright © 2017 abhi. All rights reserved.
//

import UIKit

class VBPiledViewController: UIViewController, VBPiledViewDataSource {
    
    //outlets
    @IBOutlet var piledView: VBPiledView!
    
    var numMemes = 0;
    
    //get saved memes and store it in a variable
    var memes : [Meme]{
        return ContentProvider.provider.getMemes
    }
    
    //ui view images
    fileprivate var _subViews = [UIView]()
    
    //view loads the first time
    override func viewDidLoad() {
        super .viewDidLoad()
        
        //convert uiImage to UiImageView
        numMemes = memes.count
        for x in memes{
            _subViews.append(UIImageView(image: x.memeImage))
        }
        
        //scale the image and change background color
        for v in _subViews{
            v.contentMode = UIViewContentMode.scaleAspectFill
            v.clipsToBounds = true
            v.backgroundColor = UIColor.gray
        }
        
        piledView.dataSource = self
    }
    
    //when view appears
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        
        //set piledview height of display pic and rest of piled pics
        self.piledView.expandedContentHeightInPercent = 85 // expanded content height -> 70% of screen
        self.piledView.collapsedContentHeightInPercent = 15 // collapsed content heigt of single item -> 15% of screen
        
        //convert images and scale it
        if memes.count > numMemes{
            for x in memes{
                _subViews.append(UIImageView(image: x.memeImage))
            }
            
            for v in _subViews{
                v.contentMode = UIViewContentMode.scaleToFill
                v.clipsToBounds = true
                v.backgroundColor = UIColor.gray
            }
        }
        

    }
    
    //return number of items in the view
    func piledView(_ numberOfItemsForPiledView: VBPiledView) -> Int {
        return memes.count
    }
    
    //set items in piled view
    func piledView(_ viewForPiledView: VBPiledView, itemAtIndex index: Int) -> UIView {
        return _subViews[index]
    }

}
