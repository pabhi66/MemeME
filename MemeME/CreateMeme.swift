//
//  ViewController.swift
//  MemeME
//
//  Created by Abhishek Prajapati on 4/2/17.
//  Copyright © 2017 abhi. All rights reserved.
//

import UIKit

class CreateMeme: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate {
    
    //image view outlet
    @IBOutlet weak var imageView: UIImageView!
    
    //camera button outlet
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    //top text outlet
    @IBOutlet weak var topText: UITextField!
    
    //bottom text outlet
    @IBOutlet weak var bottomText: UITextField!
    
    //Top toolbar outlet
    @IBOutlet weak var topToolbar: UIToolbar!
    
    //bottom toolbar outlet
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    //meme me title outlet
    @IBOutlet weak var memeTitle: UILabel!
    
    //share/save button outlet
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    //instructions outlet
    @IBOutlet weak var instruction: UILabel!
    var memedImage: UIImage!
    
    //saveButton outlet
    @IBOutlet weak var saveButtonOutlet: UIBarButtonItem!
    
    //edit buttons
    var editImage : UIImage!
    var editTopText: String?
    var editBottomText: String?
    
    //save to file manager
    static var filePath: String{
        let manager = FileManager.default;
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first;
        return (url?.appendingPathComponent("Data").path)!;
    }
    
    
    //make the status bar color to light since the background is black
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    
    //when the view loads for the first time
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //change background color of the activity
        self.view.backgroundColor = UIColor.black
        
        //check if camara is available in the device if not disable it
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        //connect text field to text field delegate
        topText.delegate = self
        bottomText .delegate = self
        
        //hide text
        topText.isHidden = true;
        bottomText.isHidden = true;
        saveButtonOutlet.isEnabled = false;
        
        
        //default text attrubutes
        let TextAttributes = [
            NSStrokeColorAttributeName: UIColor.black,
            NSForegroundColorAttributeName: UIColor.white ,
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName: -2.0] as [String : Any]
        
        topText.defaultTextAttributes = TextAttributes
        bottomText.defaultTextAttributes = TextAttributes
        
        //align text
        topText.textAlignment = NSTextAlignment.center
        bottomText.textAlignment = NSTextAlignment.center
        
        //disable share button (enable it after an image is selected)
        shareButton.isEnabled = false;
        
        if editImage != nil{
            imageView.image = editImage
            shareButton.isEnabled = true;
            topText.isHidden = false;
            bottomText.isHidden = false;
            instruction.isHidden = true;
            saveButtonOutlet.isEnabled = true;
            
            if let top = editTopText, let bottom = editBottomText{
                topText.text = top
                bottomText.text = bottom
            }
        }
        
        
        
        
    }
    
    //when the view appers
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //check if editing meme
        if editImage != nil{
            imageView.image = editImage
            shareButton.isEnabled = true;
            topText.isHidden = false;
            bottomText.isHidden = false;
            instruction.isHidden = true;
            saveButtonOutlet.isEnabled = true;
            
            if let top = editTopText, let bottom = editBottomText{
                topText.text = top
                bottomText.text = bottom
            }
        }
        
        //check if camera is availabe in a device
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        //suscribe to keyboard and notifications
        subscribeToKeyboardNotifications()
        
    }
    
    //when the view disappers
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //unsuscribe to notifications
        unsubscribeFromKeyboardNotifications()
    }
    
    //memory warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //keyboard will show
    func keyboardWillShow(_ notification:Notification) {
            view.frame.origin.y = 0 - getKeyboardHeight(notification)
    }
    
    //get keyboard height
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    //keyboard will hide
    func keyboardWillHide(_ notification: Notification) {
            view.frame.origin.y = 0
    }
    
    //suscribe to keyboard notification
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    //unsubscrive to keyboard notifications
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }



    //share button pressed
    @IBAction func shareButton(_ sender: Any) {
        //save the meme image
        let image = generateMemedImage()
        
        //get share controller
        let shareController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        //present the share controller
        present(shareController, animated: true, completion: nil)
        
        //if meme imaged captured successfully then create a meme object and save it using sharedPreference
        shareController.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.save()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

    //open image chooser when albums pressed
    @IBAction func choosePicFromAlbum(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)

    }
    
    //choose an image and assign it to imageview
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //choose an image and assign it to imageview
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageView.contentMode = .scaleAspectFit
            imageView.image = image;
        }
        
        //enable share and show meme text for editable and hide instruction
        shareButton.isEnabled = true;
        topText.isHidden = false;
        bottomText.isHidden = false;
        instruction.isHidden = true;
        saveButtonOutlet.isEnabled = true;
        
        //dismiss the image chooser
        dismiss(animated: true, completion: nil)
    }
    
    
    //dismiss the image chooser
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //open camera
    @IBAction func openCamera(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: Any){
        //save the meme image
        self.save()
    }
    
    //clear text field text
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM"{
            textField.text = ""
        }
    }
    
    //Dismiss keyboard when enter is hit.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //save the meme
    func save() {
        // Create the meme object
        let image = generateMemedImage()
        let meme = Meme(image: imageView.image!, memeImage: image, topText: topText.text!, bottomText: bottomText.text!)
        
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //appDelegate.memes.append(meme)
        
        ContentProvider.provider.saveMeme(meme)
        
        NSKeyedArchiver.archiveRootObject(ContentProvider.provider.getMemes, toFile: CreateMeme.filePath)
    }
    
    //captures the screen to generate final meme image
    func generateMemedImage() -> UIImage {
        
        HideToolbar(true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        HideToolbar(false)
        
        return memedImage
    }
    
    //show hid toolbar
    func HideToolbar(_ state: Bool) {
        memeTitle.isHidden = state
        topToolbar.isHidden = state
        bottomToolbar.isHidden = state
    }
    
}

