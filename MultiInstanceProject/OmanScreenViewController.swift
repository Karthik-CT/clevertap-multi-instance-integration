//
//  OmanScreenViewController.swift
//  MultiInstanceProject
//
//  Created by Karthik Iyer on 12/01/23.
//

import UIKit
import CleverTapSDK
import UserNotifications
class OmanScreenViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        CleverTap.autoIntegrate()
        CleverTap.setDebugLevel(3)
        //        registerForPush()
        //        CleverTap.setCredentialsWithAccountID("TEST-654-Z9R-646Z", andToken: "TEST-2c1-456")
        
        let ctConfig = CleverTapInstanceConfig.init(accountId: "TEST-W8W-6WR-846Z", accountToken:  "TEST-206-0b0")
        ctConfig.logLevel = CleverTapLogLevel.debug
        ctConfig.analyticsOnly = false
        ctConfig.enablePersonalization = false
        //registerForPush()
        let cleverTapAdditionalInstance = CleverTap.instance(with: ctConfig)
        cleverTapAdditionalInstance.enableDeviceNetworkInfoReporting(true)
        cleverTapAdditionalInstance.notifyApplicationLaunched(withOptions: nil)
        
        //save the account id and token in user defaults so that it could be used in app delegate to raise events of particular isntance
        if(cleverTapAdditionalInstance != nil){
            //user deafaults
            UserDefaults.standard.setValue("TEST-W8W-6WR-846Z", forKey: "AccountId")
            UserDefaults.standard.setValue("TEST-206-0b0", forKey: "AccountToken")
            
            //app groups
            let defaults = UserDefaults(suiteName: "group.clevertapTest")
            defaults!.set("TEST-W8W-6WR-846Z", forKey: "AccountId")
            defaults!.set("TEST-206-0b0", forKey: "AccountToken")
        }
        
        cleverTapAdditionalInstance.recordEvent("oman Screen Viewed")
        var returnValue2 =  UserDefaults.standard.data(forKey: "DeviceTokenKey")
        print("token is ",returnValue2)
        cleverTapAdditionalInstance.setPushToken((returnValue2)!)
        cleverTapAdditionalInstance.notifyApplicationLaunched(withOptions: nil)
    }
    
    func registerForPush() {
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
    
    @IBAction func kuwaitOnUserLoginBtn(_ sender: Any) {
        let ctConfig = CleverTapInstanceConfig.init(accountId: "TEST-W8W-6WR-846Z", accountToken:  "TEST-206-0b0")
        let cleverTapAdditionalInstance = CleverTap.instance(with: ctConfig)
        let profile: Dictionary<String, Any> = [
            "Name": "Oman iOS 2",
            "Email": "oman2@test.com",
            "Identity": "omanios2"
        ]
        
        cleverTapAdditionalInstance.onUserLogin(profile)
    }
    
    
}
