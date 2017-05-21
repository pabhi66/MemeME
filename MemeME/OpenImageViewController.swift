//
//  OpenImageViewController.swift
//  MemeME
//
//  Created by Abhishek Prajapati on 4/12/17.
//  Copyright © 2017 abhi. All rights reserved.
//

import UIKit

class OpenImageViewController: UIViewController {
    
    //outlet
    @IBOutlet weak var image: UIImageView!
    
    var meme: Meme!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var topText: UITextField!
    //@IBOutlet weak var imageH: UIImageView!

    //when view appears for the first time
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit))
    }

    //when view apperas
    override func viewWillAppear(_ animated: Bool) {
        
        image.image = meme.image
        bottomText.text = meme.bottomText
        topText.text = meme.topText
    }
    
    
    //edit meme
    func edit(){
        performSegue(withIdentifier: "edit", sender: nil)
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
