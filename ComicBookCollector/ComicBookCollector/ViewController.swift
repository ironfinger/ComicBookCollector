//
//  ViewController.swift
//  ComicBookCollector
//
//  Created by Thomas Houghton on 04/07/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var addBtn: UIBarButtonItem!
    
    @IBAction func addBtn(_ sender: Any) {
        do {
            try performSegue(withIdentifier: "addSegue", sender: nil)
        } catch {
            print("ERROR")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

