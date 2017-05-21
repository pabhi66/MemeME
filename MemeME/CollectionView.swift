//
//  CollectionView.swift
//  MemeME
//
//  Created by Abhishek Prajapati on 4/12/17.
//  Copyright © 2017 abhi. All rights reserved.
//

import UIKit

class CollectionView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    //outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewH: UICollectionView!
    var selectMeme: Meme!

    //get saved memes and store it in a variable
    var memes : [Meme]{
        return ContentProvider.provider.getMemes
    }
    

    //when view loads for the first time assign collection view delegates
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionViewH.delegate = self
        collectionViewH.dataSource = self
    }
    
    //when device rotates change layout
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            viewDidAppear(true)
        } else {
            viewDidAppear(true)
        }
    }
    
    //when view appears and if device is rotated change the layout
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Get device orientation
        let orientation: UIDeviceOrientation = UIDevice.current.orientation
        
        // Layout screen
        if orientation.isPortrait {
            UIView.animate(withDuration: 0.25) { () -> Void in
                self.collectionViewH.isHidden = true;
                self.collectionView.isHidden = false;
                self.collectionView.reloadData()
            }
        }
        else if orientation.isLandscape {
            UIView.animate(withDuration: 0.25) { () -> Void in
                self.collectionViewH.isHidden = false;
                self.collectionView.isHidden = true;
                self.collectionView.reloadData()
            }
        }
    }
    
    //number of items in collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    //fill collection view with some item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let meme = memes[indexPath.row]
        var colorArray = [UIColor.black, UIColor.green, UIColor.red, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.brown, UIColor.darkGray, UIColor.gray, UIColor.cyan, UIColor.magenta, UIColor.clear]
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? CollectionViewCell{
            cell.setUpCell(meme: meme)
            let randomInt = Int(arc4random()) % colorArray.count
            cell.backgroundColor = colorArray[randomInt]
            return cell
        }else{
            return CollectionViewCell()
        }
    }
    
    //go to different activity when clicked on an item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectMeme = memes[indexPath.row]
        performSegue(withIdentifier: "showMeme2", sender: self)
    }
    
    //prepare to go to differnt view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMeme2"{
            if let OpenImage = segue.destination as? OpenImageViewController{
                OpenImage.meme = selectMeme
            }
        }
        
    }

}
