//
//  AddComicBookViewController.swift
//  comicBookCollector
//
//  Created by Thomas Houghton on 09/07/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit

class AddComicBookViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var addUpdateBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var comicBookImage: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var comicCompleteBtn: UIButton!
    
    var imagePicker = UIImagePickerController()
    var comicBook : ComicBook? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        self.titleTextField.delegate = self
        
        if comicBook != nil {
            print("We have a game.")
            comicBookImage.image = UIImage(data: comicBook!.image as! Data)
            titleTextField.text = comicBook?.title
            addUpdateBtn.setTitle("Update", for: .normal)
        }else{
            print("We have no game")
            deleteBtn.isHidden = true
            comicCompleteBtn.isHidden = true
        }
        
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dissmissKeyboard")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func photosBtn(_ sender: Any) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        comicBookImage.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func comicCompleteBtn(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        comicBook!.comicComplete = true
        navigationController?.popViewController(animated: true)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    @IBAction func addComicBookBtn(_ sender: Any) {
        if comicBook != nil {
            comicBook!.title = titleTextField.text!
            comicBook!.image = UIImagePNGRepresentation(comicBookImage.image!)
            navigationController?.popViewController(animated: true)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }else{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let comicBook = ComicBook(context: context)
            comicBook.title = titleTextField.text!
            comicBook.image = UIImagePNGRepresentation(comicBookImage.image!)
            comicBook.comicComplete = false
            navigationController?.popViewController(animated: true)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
}
    
    @IBAction func deleteBtn(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(comicBook!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    func dissmissKeyboard() {
        view.endEditing(true)
    }
}
