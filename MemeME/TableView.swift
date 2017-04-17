//
//  tableView.swift
//  MemeME
//
//  Created by Abhishek Prajapati on 4/12/17.
//  Copyright © 2017 abhi. All rights reserved.
//

import Foundation
import UIKit

class TableView : UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    var selectMeme: Meme!

    //get saved memes and store it in a variable
    var memes : [Meme]{
        return ContentProvider.provider.getMemes
    }
    
    private func loadData(){
        if let ourData = NSKeyedUnarchiver.unarchiveObject(withFile: CreateMeme.filePath) as? [Meme]{
            ContentProvider.provider.getMemes = ourData;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.contentInset = UIEdgeInsets.zero
        tableView.reloadData()
    }
    
    //define number of cells
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    

    //fill in cells
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let meme = memes[indexPath.row]
        var colorArray = [UIColor.black, UIColor.green, UIColor.red, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.brown, UIColor.darkGray, UIColor.gray, UIColor.cyan, UIColor.magenta, UIColor.clear]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell{
            cell.setUpCell(meme: meme)
            let randomInt = Int(arc4random()) % colorArray.count
            cell.backgroundColor = colorArray[randomInt]
            cell.memeLabel1.textColor = UIColor.white
            cell.memeLabel2.textColor = UIColor.white
            return cell
        }else{
            return TableViewCell()
        }
        
    }
    
    //delete meme
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ContentProvider.provider.deleteMeme(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            NSKeyedArchiver.archiveRootObject(ContentProvider.provider.getMemes, toFile: CreateMeme.filePath)
        }
    }
    
    
    //when cell is selected open the image
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectMeme = memes[indexPath.row]
        performSegue(withIdentifier: "showMeme", sender: nil)
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMeme"{
            if let OpenImage = segue.destination as? OpenImageViewController{
                OpenImage.meme = selectMeme
            }
        }
        
    }

}
