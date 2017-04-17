//
//  OpenImageViewController.swift
//  MemeME
//
//  Created by Abhishek Prajapati on 4/12/17.
//  Copyright © 2017 abhi. All rights reserved.
//

import UIKit

class OpenImageViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    
    var meme: Meme!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        image.image = meme.memeImage
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let navController = self.navigationController {
            navController.popToRootViewController(animated: true)
        }
    }

    //edit meme
    func edit(){
        performSegue(withIdentifier: "edit", sender: self)
    }
    
    //perform segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit" {
            if let meme = segue.destination as? CreateMeme {
                meme.editImage = self.meme.image
                meme.editTopText = self.meme.topText
                meme.editBottomText = self.meme.bottomText
            }
        }
    }
}
