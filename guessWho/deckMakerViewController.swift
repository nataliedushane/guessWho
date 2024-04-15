//
//  deckMakerViewController.swift
//  guessWho
//
//  Created by NATALIE DUSHANE on 3/5/24.
//

import UIKit
import FirebaseCore
import FirebaseDatabase

class deckMakerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var ref: DatabaseReference!

    @IBOutlet weak var newField: UITextField!
    
    @IBOutlet weak var table: UITableView!
    var newDeck = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        ref = Database.database().reference()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func add(_ sender: Any) {
        newDeck.append(newField.text!)
        newField.text! = ""
        table.reloadData()
    }
    
    @IBAction func saveDeck(_ sender: Any) {
        let alertController = UIAlertController(title: "Name the deck", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Enter Name"
            }
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
                let firstTextField = alertController.textFields![0] as UITextField
            var blah = [firstTextField.text! : self.newDeck]
            print(blah)
            self.ref.child("decks").childByAutoId().setValue(blah)
            self.newDeck = []
            self.table.reloadData()
            })
        
            
            alertController.addAction(saveAction)
            
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func savePrivDeck(_ sender: Any) {
        let alertController = UIAlertController(title: "Give the deck a password", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Enter Password"
            }
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
                let firstTextField = alertController.textFields![0] as UITextField
            var blah = [firstTextField.text! : self.newDeck]
            print(blah)
            self.ref.child("privDecks").childByAutoId().setValue(blah)
            self.newDeck = []
            self.table.reloadData()
            })
        
            
            alertController.addAction(saveAction)
            
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newDeck.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
        cell?.textLabel?.text = "\(newDeck[indexPath.row])"
        return cell!
    }
    

}
