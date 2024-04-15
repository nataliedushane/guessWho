//
//  deckViewerViewController.swift
//  guessWho
//
//  Created by NATALIE DUSHANE on 3/6/24.
//

import UIKit
import FirebaseCore
import FirebaseDatabase
class AppData{
    static var decks = [[String : [String]]]()
    static var key = ""
    static var bruh = 0
}
class deckViewerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var ref: DatabaseReference!
 var allDecks = [[String : [String]]]()
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        ref = Database.database().reference()
        table.dataSource = self
        table.delegate = self
        
        
        ref.child("decks").observe(.childAdded, with: { (snapshot) in
            // snapshot is a dictionary with a key and a value
            
            // this gets each name from each snapshot
            let n = snapshot.value as! [String : [String]]
            // adds the name to an array if the name is not already there
            
            self.allDecks.append(n)
                self.table.reloadData()
                print(n)
            AppData.decks = self.allDecks
            
            })
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var keys = [String]()
        for (key, _) in allDecks[indexPath.row]{
            keys.append(key)
        }
        
        print(keys)
        AppData.key = "\(keys[0])"
        AppData.bruh = indexPath.row
        performSegue(withIdentifier: "toPlay", sender: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allDecks.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "bruh")
        let firstKey = Array(allDecks[indexPath.row].keys)[0]
        cell?.textLabel?.text = "\(firstKey)"
        return cell!
    }

}
