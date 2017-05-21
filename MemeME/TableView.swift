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
    
    //outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewH: UITableView!
    
    //selected meme variable
    var selectMeme: Meme!

    //get saved memes and store it in a variable
    var memes : [Meme]{
        return ContentProvider.provider.getMemes
    }
    
    //load data when app starts
    private func loadData(){
        if let ourData = NSKeyedUnarchiver.unarchiveObject(withFile: CreateMeme.filePath) as? [Meme]{
            ContentProvider.provider.getMemes = ourData;
        }
    }
    
    //when view loads for the first time
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.delegate = self
        tableView.dataSource = self
        tableViewH.delegate = self
        tableViewH.dataSource = self
    }
    
    //when screen is rotated
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            viewDidAppear(true)
        } else {
            viewDidAppear(true)
        }
    }
    
    //when view appears
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        // Get device orientation
        let orientation: UIDeviceOrientation = UIDevice.current.orientation
        
        // Layout screen
        if orientation.isPortrait {
            UIView.animate(withDuration: 0.25) { () -> Void in
                self.tableViewH.isHidden = true;
                self.tableView.isHidden = false;
                self.tableView.contentInset = UIEdgeInsets.zero
                self.tableView.reloadData()
            }
        } else if orientation.isLandscape {
            UIView.animate(withDuration: 0.25) { () -> Void in
                self.tableViewH.isHidden = false;
                self.tableView.isHidden = true;
                self.tableViewH.contentInset = UIEdgeInsets.zero
                self.tableViewH.reloadData()
            }
        }
    }
    
    //define number of cells
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    

    //fill in cells
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let meme = memes[indexPath.row]
        var colorArray = [UIColor.black, UIColor.green, UIColor.red, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.brown, UIColor.darkGray, UIColor.gray, UIColor.cyan, UIColor.magenta]
        
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
