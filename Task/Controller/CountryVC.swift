//
//  ViewController.swift
//  Task
//
//  Created by Eslam Elshaht on 1/25/21.
//

import UIKit

enum UserDefaultKeys: String {
    case selectedCountry
    case hasSkippedNotificationPage
}

class CountryVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true

        title = "APP"
    }
    
    func storeSelectedCountryToUserDefaults(_ value: String?) {
        UserDefaults.standard.set(value, forKey: UserDefaultKeys.selectedCountry.rawValue)
    }

    @IBAction func saudiCountryPressed(_ sender: UIButton) {
       
        storeSelectedCountryToUserDefaults(sender.titleLabel?.text)
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationVC") as? NotificationVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func egyCountryPressed(_ sender: UIButton) {
        storeSelectedCountryToUserDefaults(sender.titleLabel?.text)
        UserDefaults.standard.set(true, forKey: UserDefaultKeys.hasSkippedNotificationPage.rawValue)
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebVC") as? WebVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func uaeCountryPressed(_ sender: UIButton) {
        storeSelectedCountryToUserDefaults(sender.titleLabel?.text)
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationVC") as? NotificationVC
        navigationController?.pushViewController(vc!, animated: true)
    }
}

