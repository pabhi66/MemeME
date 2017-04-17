//
//  CollectionView.swift
//  MemeME
//
//  Created by Abhishek Prajapati on 4/12/17.
//  Copyright © 2017 abhi. All rights reserved.
//

import UIKit

class CollectionView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var selectMeme: Meme!

    //get saved memes and store it in a variable
    var memes : [Meme]{
        return ContentProvider.provider.getMemes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //collectionView.contentInset = UIEdgeInsets.zero
        collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectMeme = memes[indexPath.row]
        performSegue(withIdentifier: "showMeme2", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMeme2"{
            if let OpenImage = segue.destination as? OpenImageViewController{
                OpenImage.meme = selectMeme
            }
        }
        
    }

}
