//
//  AppDelegate.swift
//  MultiInstanceProject
//
//  Created by Karthik Iyer on 11/01/23.
//

import UIKit
import CleverTapSDK
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate,CleverTapPushNotificationDelegate, CleverTapURLDelegate {
    
    var window: UIWindow?
    //Multi Instance SDK Code
    // var cleverTapAdditionalInstance:CleverTap!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Thread.sleep(forTimeInterval: 2.0)
        
        registerForPush()
        
        CleverTap.autoIntegrate()
        CleverTap.setDebugLevel(CleverTapLogLevel.debug.rawValue)
        
        //        CleverTap.setDebugLevel(CleverTapLogLevel.debug.rawValue)
        //
        let defaults = UserDefaults.init(suiteName: "group.clevertapTest")
        guard let appgroups_accountId = defaults?.value(forKey: "countryAccountID") as? String,
              let appgroups_accountToken = defaults?.value(forKey: "countryAccountToken") as? String else {
            print("CleverTap account details not set in UserDefaults!")
            return true // Continue app launch to allow ViewController to set defaults
        }
        
        let ctConfig = CleverTapInstanceConfig(accountId: appgroups_accountId, accountToken: appgroups_accountToken)
        
        
        //        let ctConfig = CleverTapInstanceConfig.init(accountId: "TEST-W8W-6WR-846Z", accountToken: "TEST-206-0b0")
        //        ctConfig.logLevel = CleverTapLogLevel.debug
        //        ctConfig.analyticsOnly = false
        //        ctConfig.enablePersonalization = false
        //
        let cleverTapAdditionalInstance = CleverTap.instance(with: ctConfig)
        
        //        DispatchQueue.main.async {
        cleverTapAdditionalInstance.setUrlDelegate(self)
        //            print("Delegate successfully set for CleverTap instance.")
        //        }
        
        return true
    }
    
    public func shouldHandleCleverTap(_ url: URL?, for channel: CleverTapChannel) -> Bool {
        print("Handling URL: \(url!) for channel: \(channel)")
        return true
    }
    
    //    private func application(application: UIApplication,
    //                   didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
    //    NSLog("%@: registered for remote notifications: %@", self.description, deviceToken.description)
    //  CleverTap.sharedInstance()?.setPushToken(deviceToken as Data)
    //}
    
    func registerForPush() {
        
        let action1 = UNNotificationAction(identifier: "action_1", title: "Back", options: [])
        let action2 = UNNotificationAction(identifier: "action_2", title: "Next", options: [])
        //let action3 = UNNotificationAction(identifier: "action_3", title: "View In App", options: [])
        let categorywithAction = UNNotificationCategory(identifier: "CTNotification", actions: [action1, action2], intentIdentifiers: [], options: [])
        let categoryNoAction = UNNotificationCategory(identifier: "CTNotification2", actions: [], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([categoryNoAction,categorywithAction])
        
        // Register for Push notifications
        UNUserNotificationCenter.current().delegate = self
        // request Permissions
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .badge, .alert], completionHandler: {granted, error in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        })
        
    }
    
    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool
    {
        // Get URL components from the incoming user activity.
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
              let incomingURL = userActivity.webpageURL,
              let components = NSURLComponents(url: incomingURL, resolvingAgainstBaseURL: true) else {
            return false
        }
        
        // Check for specific URL components that you need.
        guard let path = components.path,
              let params = components.queryItems else {
            return false
        }
        print("path = \(path)")
        
        if let albumName = params.first(where: { $0.name == "albumname" } )?.value,
           let photoIndex = params.first(where: { $0.name == "index" })?.value {
            
            print("album = \(albumName)")
            print("photoIndex = \(photoIndex)")
            return true
            
        } else {
            print("Either album name or photo index missing")
            return false
        }
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
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        NSLog("%@: failed to register for remote notifications: %@", self.description, error.localizedDescription)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        NSLog("%@: registered for remote notifications: %@", self.description, deviceToken.description)
        
        //set token here in user defaults and receive it in respective view cotnroller
        UserDefaults.standard.setValue(deviceToken as Data, forKey: "DeviceTokenKey")
        //CleverTap.sharedInstance()?.setPushToken(deviceToken as Data)
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        //CleverTap.sharedInstance()?.handleNotification(withData: response.notification.request.content.userInfo, openDeepLinksInForeground: true)
        //CleverTap.sharedInstance()?.recordNotificationViewedEvent(withData: response.notification.request.content.userInfo)
        
        //fetch the the account id and token from the User Defaults for the selected instance
        //            var accountId =  UserDefaults.standard.string(forKey: "AccountId")!
        //            var accountToken =  UserDefaults.standard.string(forKey: "AccountToken")!
        
        //fetch the the account id and token from the app groups for the selected instance
        let defaults = UserDefaults.init(suiteName: "group.clevertapTest")
        let appgroups_accountId = defaults?.value(forKey: "countryAccountID") as! String
        let appgroups_accountToken = defaults?.value(forKey: "countryAccountToken") as! String
        
        let ctConfig = CleverTapInstanceConfig.init(accountId: appgroups_accountId, accountToken:  appgroups_accountToken)
        let cleverTapAdditionalInstance = CleverTap.instance(with: ctConfig)
        cleverTapAdditionalInstance.recordNotificationClickedEvent(withData: response.notification.request.content.userInfo)
        NSLog("%@: did receive notification response: %@", self.description, response.notification.request.content.userInfo)
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        //CleverTap.sharedInstance()?.handleNotification(withData: notification.request.content.userInfo, openDeepLinksInForeground: true)
        NSLog("%@: will present notification: %@", self.description, notification.request.content.userInfo)
        //CleverTap.sharedInstance()?.recordNotificationViewedEvent(withData: notification.request.content.userInfo)
        completionHandler([.badge, .sound, .alert])
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        NSLog("%@: did receive remote notification completionhandler: %@", self.description, userInfo)
        completionHandler(UIBackgroundFetchResult.noData)
    }
    
    func pushNotificationTapped(withCustomExtras customExtras: [AnyHashable : Any]!) {
        NSLog("pushNotificationTapped: customExtras: ", customExtras)
    }
}

