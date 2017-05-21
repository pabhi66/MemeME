//
//  StackViewController.swift
//  MemeME
//
//  Created by Abhishek Prajapati on 4/24/17.
//  Copyright © 2017 abhi. All rights reserved.
//

import UIKit
//import VBPiledView

class StackViewController: UIViewController , VBPiledViewDataSource {

    @IBOutlet weak var PiledView: VBPiledView!
    var selectMeme: Meme!
    
    //get saved memes and store it in a variable
    var memes : [Meme]{
        return ContentProvider.provider.getMemes
    }
    
    fileprivate var _subViews = [UIView]()
    var size: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.PiledView.expandedContentHeightInPercent = 70 // expanded content height -> 70% of screen
        self.PiledView.collapsedContentHeightInPercent = 15 // collapsed content heigt of single item -> 15% of screen
        
        update()
        
        PiledView.dataSource = self
        
    }
    
    func update(){
        for meme in memes{
            _subViews.append(UIImageView(image: meme.memeImage))
        }
        
        for image in _subViews{
            image.contentMode = UIViewContentMode.scaleAspectFill
            image.clipsToBounds = true
            image.backgroundColor = UIColor.gray
            
        }
        size = memes.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if size < memes.count || size < memes.count{
            update()
        }
        
    }
    
    func piledView(_ numberOfItemsForPiledView: VBPiledView) -> Int {
        return memes.count
    }
    
    func piledView(_ viewForPiledView: VBPiledView, itemAtIndex index: Int) -> UIView {
        return _subViews[index]
    }
    
    


}
