//
//  AppDelegate.swift
//  guessWho
//
//  Created by NATALIE DUSHANE on 3/5/24.
//

import UIKit
import FirebaseCore
import FirebaseDatabase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var ref: DatabaseReference!



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        ref = Database.database().reference()

        print("BRUHHHH")
        for i in 0 ..< AppData.names.count{
            if (AppData.names[i] == AppData.singleName){
                //AppData.names.remove(at: i)
                print("HELP")
                ref.child("names").child(AppData.key).removeValue()


            }
        }
        for i in 0 ..< AppData.names.count{
            print(AppData.names[i])
            
        }
        print("i removed the name!")

    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("hello")
    }


}

