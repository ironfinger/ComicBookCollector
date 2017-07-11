//
//  ViewController.swift
//  comicBookCollector
//
//  Created by Thomas Houghton on 09/07/2017.
//  Copyright © 2017 Thomas Houghton. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var comicBooks : [ComicBook] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.backgroundColor = UIColor.black
        navigationController?.navigationBar.barTintColor = UIColor.black
    }
    
    func setupNavBar() {
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().tintColor = .blue
        UINavigationBar.appearance().isTranslucent = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            comicBooks = try context.fetch(ComicBook.fetchRequest())
        } catch {
            print("Error")
        }
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = 150
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comicBooks.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
        if comicBooks[indexPath.row].comicComplete != true {
            cell.backgroundColor = UIColor.red
        }else{
            cell.backgroundColor = UIColor.green
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let comicBook = comicBooks[indexPath.row]
        if comicBooks[indexPath.row].comicComplete != true {
            cell.textLabel?.text = comicBook.title
        }else{
            cell.textLabel?.text = " ✅ \(comicBook.title)"
        }
        cell.textLabel?.text = comicBook.title!
        cell.imageView?.image = UIImage(data: comicBook.image as! Data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comicBook = comicBooks[indexPath.row]
        performSegue(withIdentifier: "comicBookSegue", sender: comicBook)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! AddComicBookViewController
        nextVC.comicBook = sender as? ComicBook
    }
}
