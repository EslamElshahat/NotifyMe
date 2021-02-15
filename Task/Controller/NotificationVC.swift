//
//  Notification.swift
//  Task
//
//  Created by Eslam Elshaht on 1/25/21.
//

import Firebase
import FirebaseFirestore
import FirebaseMessaging
import UIKit
import UserNotifications


class NotificationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true

    }
    
    
    @IBAction func webView(_ sender: Any) {
        
        let myApplication = UIApplication.shared.delegate as! AppDelegate
            myApplication.registerAPNSServicesForApplication(UIApplication.shared) { (granted) -> (Void) in
                
                if #available(iOS 10.0, *) {

                    if granted {

                    }else {

                    }

                }else {
                }
            }

        UserDefaults.standard.set(true, forKey: UserDefaultKeys.hasSkippedNotificationPage.rawValue)
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebVC") as? WebVC
        navigationController?.pushViewController(vc!, animated: true)
        
    }
      

}
