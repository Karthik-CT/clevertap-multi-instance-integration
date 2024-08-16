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
    
    let defaults = UserDefaults(suiteName: "group.clevertapTest")
    let countryAccountID = "TEST-W8W-6WR-846Z"
    let countryAccountToken = "TEST-206-0b0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        CleverTap.autoIntegrate()
        CleverTap.setDebugLevel(3)
        //        registerForPush()
        
        defaults!.set(countryAccountID, forKey: "countryAccountID")
        defaults!.set(countryAccountToken, forKey: "countryAccountToken")
        
        let ctConfig = CleverTapInstanceConfig.init(accountId: countryAccountID , accountToken:  countryAccountToken)
        ctConfig.logLevel = CleverTapLogLevel.debug
        ctConfig.analyticsOnly = false
        ctConfig.enablePersonalization = false
        
        //registerForPush()
        let cleverTapAdditionalInstance = CleverTap.instance(with: ctConfig)
        
        cleverTapAdditionalInstance.enableDeviceNetworkInfoReporting(true)
        cleverTapAdditionalInstance.notifyApplicationLaunched(withOptions: nil)
        
        //save the account id and token in user defaults so that it could be used in app delegate to raise events of particular isntance
        if(cleverTapAdditionalInstance != nil){
            UserDefaults.standard.setValue(countryAccountID, forKey: "AccountId")
            UserDefaults.standard.setValue(countryAccountToken, forKey: "AccountToken")
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
    
    @IBAction func omanOnUserLoginBtn(_ sender: Any) {
        let ctConfig = CleverTapInstanceConfig.init(accountId: countryAccountID, accountToken:  countryAccountToken)
        let cleverTapAdditionalInstance = CleverTap.instance(with: ctConfig)
        let profile: Dictionary<String, Any> = [
            "Name": "Oman iOS",
            "Email": "iosoman1@test.com",
            "Identity": "iosoman1"
        ]
        
        cleverTapAdditionalInstance.onUserLogin(profile)
    }
    
    
}
