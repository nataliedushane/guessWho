//
//  playViewController.swift
//  guessWho
//
//  Created by NATALIE DUSHANE on 3/7/24.
//

import UIKit

class playViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    
    @IBOutlet weak var personLabel: UILabel!
    
    
    @IBOutlet weak var collect: UICollectionView!
    
    var colors = [UIColor]()

    override func viewDidLoad() {
        super.viewDidLoad()
        for bruh in AppData.decks[AppData.bruh][AppData.key]!{
            colors.append(UIColor(red: 247, green: 154, blue: 110, alpha: 0))
        }
        collect.delegate = self
        collect.dataSource = self
       
       
        
        
        let rand  = Int.random(in: 0...AppData.decks[AppData.bruh][AppData.key]!.count - 1)
        let per = AppData.decks[AppData.bruh][AppData.key]![rand]
        let alertController = UIAlertController(title: "Your person is: \(per)", message: "", preferredStyle: UIAlertController.Style.alert)
        self.personLabel.text = "You have: \(per)"
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
    
    
    
    
}
