//
//  playViewController.swift
//  guessWho
//
//  Created by NATALIE DUSHANE on 3/7/24.
//

import UIKit

class playViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var defaults = UserDefaults.standard

    
    @IBOutlet weak var personLabel: UILabel!
    
    @IBOutlet weak var oppLabel: UILabel!
    
    @IBOutlet weak var collect: UICollectionView!
    
    var colors = [UIColor]()
    var ref: DatabaseReference!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        for bruh in AppData.decks[AppData.bruh][AppData.key]!{
            colors.append(UIColor(red: 247, green: 154, blue: 110, alpha: 0))
        }
        collect.delegate = self
        collect.dataSource = self
        
       
        oppLabel.text = "Your opp is: \(AppData.opp)"
        
        
        let rand  = Int.random(in: 0...AppData.decks[AppData.bruh][AppData.key]!.count - 1)
        let per = AppData.decks[AppData.bruh][AppData.key]![rand]
        let alertController = UIAlertController(title: "Your person is: \(per)", message: "", preferredStyle: UIAlertController.Style.alert)
        self.personLabel.text = "You have: \(per)"
        AppData.me.personYouHave = per
        self.ref.child("users").child(AppData.key).setValue(["personYouHave": AppData.me.personYouHave])

        let saveAction = UIAlertAction(title: "Perf", style: UIAlertAction.Style.default, handler: { alert -> Void in
                
           
            })
        alertController.addAction(saveAction)
        
    self.present(alertController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(colors[indexPath.row] == UIColor.gray){
            colors[indexPath.row] = UIColor(red: 247, green: 154, blue: 110, alpha: 0)
        }
        else{
            colors[indexPath.row] = UIColor.gray
        }
        collect.reloadData()
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(AppData.decks[AppData.bruh][AppData.key]!.count)
        return AppData.decks[AppData.bruh][AppData.key]!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! CazyCell
       
        print(AppData.decks[AppData.bruh][AppData.key]!)
        let help = AppData.decks[AppData.bruh][AppData.key]!
        let new = help[indexPath.row]
        print(new)
       cell.labelOutlet.text = new
        cell.contentView.backgroundColor = colors[indexPath.row]

        return cell
    }
    
    
    
    @IBAction func endGameAction2(_ sender: UIButton) {
        alert()
        customBack(UIViewController.self)
    
    }
    
    @IBAction func guessAction(_ sender: UIButton) {
        
        
    }
    
    
    
    
    
    
    func alert(){
        let alert = UIAlertController(title: "Did you win!", message:"", preferredStyle: .alert)
                
              alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { _ in
                  AppData.losses += 1
                  self.defaults.set(AppData.losses, forKey: "theLosses")
              }))
              alert.addAction(UIAlertAction(title: "Yes",
                                            style: UIAlertAction.Style.default,
                                            handler: {(_: UIAlertAction!) in
                  AppData.wins += 1
                  self.defaults.set(AppData.wins, forKey: "theWins")

              }))
        
        DispatchQueue.main.async {
            self.present(alert, animated: false, completion: nil)
        }  
        
        
    }
    
    func alertForGuess(){
        
        let alertController = UIAlertController(title: "Guess", message: "Who do you think they have?", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Name"
        }
        let saveAction = UIAlertAction(title: "Guess", style: UIAlertAction.Style.default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            var blah = firstTextField.text!
          
            
            AppData.me.guess = "\(blah)"
            self.ref.child("users").child(AppData.key).setValue(["guess": AppData.me.guess])

            
            self.defaults.set(AppData.singleName, forKey: "theName")
            
            print(blah)
            print(AppData.singleName)
           
            
                            
            
            
            
            
        })
        
        
        
        
        alertController.addAction(saveAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
  func customBack(_ sender: Any) {
       _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    
    
    
    
}
