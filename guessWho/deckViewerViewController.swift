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
    static var pdecks = [[String : [String]]]()
    static var players = [[String : Any]]()
    static var singleName  = ""
    static var opp = ""
    static var wins = 0
    static var losses = 0
    static var me : Player = Player(name: "")

}
class deckViewerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var ref: DatabaseReference!
 var allDecks = [[String : [String]]]()
    var privDecks = [[String : [String]]]()
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
        
        ref.child("privDecks").observe(.childAdded, with: { (snapshot) in
            // snapshot is a dictionary with a key and a value
            
            // this gets each name from each snapshot
            let n = snapshot.value as! [String : [String]]
            // adds the name to an array if the name is not already there
            
            self.privDecks.append(n)
                self.table.reloadData()
                print(n)
            AppData.pdecks = self.privDecks
            
            })
        
        
        
    }
    
    @IBAction func privDeck(_ sender: Any) {
        let alertController = UIAlertController(title: "What's the password", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Enter Password"
            }
        let saveAction = UIAlertAction(title: "Enter", style: UIAlertAction.Style.default, handler: { alert -> Void in
                let firstTextField = alertController.textFields![0] as UITextField
            var blah = firstTextField.text!
            print(AppData.pdecks)
            for i in 0...AppData.pdecks.count{
                for (key, _) in AppData.pdecks[i]{
                    print(key)
                    print(key==blah)
                    if(key == blah){
                        AppData.key = "\(key)"
                        AppData.bruh = i
                        AppData.decks = AppData.pdecks
                        break
                    }
                    
                }
                if(AppData.decks == AppData.pdecks){
                    break
                }
            }

            
            })
        
            
            alertController.addAction(saveAction)
            
        self.present(alertController, animated: true, completion: nil)
        let falertController = UIAlertController(title: "You entered a password that does not match any pre-existing private decks", message: "", preferredStyle: UIAlertController.Style.alert)
       
        let fsaveAction = UIAlertAction(title: "Sorry I'll Try Again", style: UIAlertAction.Style.default, handler: { alert -> Void in
                
           
            })
        falertController.addAction(fsaveAction)
        
    self.present(falertController, animated: true, completion: nil)
        self.performSegue(withIdentifier: "toPlay", sender: true)

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
