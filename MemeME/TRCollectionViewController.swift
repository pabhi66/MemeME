//
//  TRCollectionViewController.swift
//  MemeME
//
//  Created by Abhishek Prajapati on 5/8/17.
//  Copyright © 2017 abhi. All rights reserved.
//

import UIKit

private let reuseIdentifier = "TRMosaicCell"

class TRCollectionViewController: UICollectionViewController, TRMosaicLayoutDelegate {
    
    //get saved memes and store it in a variable
    var memes : [Meme]{
        return ContentProvider.provider.getMemes
    }

    //when application loads for the first time
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //assign collection view to TRMosaic Layout
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        let mosaicLayout = TRMosaicLayout()
        self.collectionView?.collectionViewLayout = mosaicLayout
        
        mosaicLayout.delegate = self

    }

    // MARK: UICollectionViewDataSource

    //number of sections
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    //return number of grids
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    //fill the grid with items
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
    
        // Configure the cell
        if memes.count > 0{
            let imageView = UIImageView()
            imageView.image = memes[indexPath.row].memeImage
            imageView.frame = cell.frame
            cell.backgroundView = imageView
        }
    
        return cell
    }
    
    //change grid sizes 2 small 1 big
    func collectionView(_ collectionView:UICollectionView, mosaicCellSizeTypeAtIndexPath indexPath:IndexPath) -> TRMosaicCellType {
        return indexPath.item % 3 == 0 ? TRMosaicCellType.big : TRMosaicCellType.small
    }
    
    //gird edge insets
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout: TRMosaicLayout, insetAtSection:Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    }
    
    //height for small cell
    func heightForSmallMosaicCell() -> CGFloat {
        return 150
    }
}

