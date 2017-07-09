//
//  ComicBookViewController.swift
//  ComicBookCollector
//
//  Created by Thomas Houghton on 04/07/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit

class ComicBookViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var comicBookImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func photosTap(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        comicBookImageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTap(_ sender: Any) {

    }
    
    @IBAction func addBtn(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let comicBook = ComicBook(context: context)
        comicBook.title = titleTextField.text!
        comicBook.image = UIImagePNGRepresentation(comicBookImageView.image!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
}
