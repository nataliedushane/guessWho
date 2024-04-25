//
//  OppsViewController.swift
//  guessWho
//
//  Created by MYKAELA WALLEN on 4/17/24.
//

import UIKit
import FirebaseCore
import FirebaseDatabase
class OppsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var ref: DatabaseReference!

    
    @IBOutlet weak var opponentsTableViewOutlet: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        opponentsTableViewOutlet.delegate = self
        opponentsTableViewOutlet.dataSource = self
        ref = Database.database().reference()

        

        // Do any additional setup after loading the view.
    }
    

   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppData.names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
        cell.textLabel?.text = "\(AppData.names[indexPath.row])"
               return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AppData.opp = "\(AppData.names[indexPath.row])"
        performSegue(withIdentifier: "toDecks", sender: true)
    }
    
}
