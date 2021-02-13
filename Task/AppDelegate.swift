//
//  AppDelegate.swift
//  Task
//
//  Created by Eslam Elshaht on 1/25/21.
//

import UIKit
import FirebaseCore
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
let gcmMessageIDKey = "gcm_Message_ID_Key"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        
        Messaging.messaging().delegate = self

        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var viewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "WebVC")
        
        let hasSkippedNotificationPage = UserDefaults.standard.bool(forKey: UserDefaultKeys.hasSkippedNotificationPage.rawValue)
        let selectedCountry = UserDefaults.standard.string(forKey: UserDefaultKeys.selectedCountry.rawValue) ?? ""
        
        if selectedCountry.isEmpty {
            viewController = mainStoryboard.instantiateViewController(withIdentifier: "CountryVC")
        } else if hasSkippedNotificationPage == false {
            viewController = mainStoryboard.instantiateViewController(withIdentifier: "NotificationVC")
        }

        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: viewController)
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification

      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)

      // Print message ID.
      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }

      // Print full message.
      print(userInfo)

      completionHandler(UIBackgroundFetchResult.newData)
    }
    
    
    
    func registerAPNSServicesForApplication(_ application: UIApplication,withBlock block: @escaping (_ granted:Bool) -> (Void)) {

        // [START register_for_notifications]
        if #available(iOS 10.0, *) {
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {granted, error in

                    if granted == true{

                        DispatchQueue.main.async {
                            application.registerForRemoteNotifications()
                        }

                        // For iOS 10 display notification (sent via APNS)
                        UNUserNotificationCenter.current().delegate = self

                    }

                    block(granted)
            })

        } else {

            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()

        }

    }
}

extension AppDelegate: MessagingDelegate{
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")

      let dataDict:[String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
}
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {

  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    let userInfo = notification.request.content.userInfo

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // Print message ID.
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }

    // Print full message.
    print(userInfo)

    // Change this to your preferred presentation option
    completionHandler([[.alert, .sound]])
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo
    // Print message ID.
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // Print full message.
    print(userInfo)

    completionHandler()
  }
}
