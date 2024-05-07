//
//  ViewController.swift
//  guessWho
//
//  Created by NATALIE DUSHANE on 3/5/24.
//

import UIKit
import FirebaseCore
import FirebaseDatabase

class ViewController: UIViewController {
    
    var ref: DatabaseReference!
    var defaults = UserDefaults.standard


    override func viewDidLoad() {
        
        super.viewDidLoad()
        
       
        ref = Database.database().reference()
        AppData.wins = defaults.integer(forKey: "theWins")
        AppData.losses = defaults.integer(forKey: "theLosses")
        
        self.ref.child("players").observe(.childAdded, with: { (snapshot) in
            // snapshot is a dictionary with a key and a value
            
            // this gets each name from each snapshot
            let n = snapshot.value as! [String : Any]
            // adds the name to an array if the name is not already there
            AppData.players.append(n)
            print(n)
            
            
        })
        
        if(defaults.string(forKey: "theName") != nil){
            AppData.singleName = defaults.string(forKey: "theName")!
            print("\(AppData.singleName)")
        }
        else{
            
            
            let alertController = UIAlertController(title: "Sign in!", message: "", preferredStyle: UIAlertController.Style.alert)
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Enter Name"
            }
            let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
                let firstTextField = alertController.textFields![0] as UITextField
                var blah = firstTextField.text!
                AppData.key = self.ref.child("players").childByAutoId().key ?? "0"
                
                AppData.singleName = "\(blah)"
                
                
                self.defaults.set(AppData.singleName, forKey: "theName")
                AppData.me = Player(name: "\(blah)")
                print(blah)
                print(AppData.singleName)
                AppData.me.saveToFirebase()
                
                                
                
                
                
                
            })
            
            
            
            
            alertController.addAction(saveAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        

        
        ref.child("names").observe(.childRemoved, with: { (snapshot) in
            // snapshot is a dictionary with a key and a value
            
            let n = snapshot.value as! [String : Any]
            // adds the name to an array if the name is not already there
            AppData.players.append(n)
                print(n)
            
        
         
            
           // self.tableViewOutlet.reloadData()
           
        })
        // Do any additional setup after loading the view.
    }
    
    
    
    @objc func appMovedToBackground(){
        print("BRUHHHH")
        print("hello")
        ref = Database.database().reference()

        self.ref.child("players").child(AppData.key).removeValue()

        print("i removed the name!")
    
    }

    func deleteFromFirebase() {
        ref.child("players").child(AppData.key).removeValue()
    }

}

