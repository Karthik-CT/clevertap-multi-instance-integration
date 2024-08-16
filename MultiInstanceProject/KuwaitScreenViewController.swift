//
//  KuwaitScreenViewController.swift
//  MultiInstanceProject
//
//  Created by Karthik Iyer on 12/01/23.
//

import UIKit
import CleverTapSDK

class KuwaitScreenViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    let defaults = UserDefaults(suiteName: "group.clevertapTest")
    let countryAccountID = "TEST-654-Z9R-646Z"
    let countryAccountToken = "TEST-2c1-456"
    
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
        
        //save the account id and token in user defaults so that it could be used in app delegate to raise events of particular isntance
        if(cleverTapAdditionalInstance != nil){
            UserDefaults.standard.setValue(countryAccountID, forKey: "AccountId")
            UserDefaults.standard.setValue(countryAccountToken, forKey: "AccountToken")
        }
        
        cleverTapAdditionalInstance.recordEvent("Kuwait Screen Viewed")
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
        let ctConfig = CleverTapInstanceConfig.init(accountId: countryAccountID, accountToken:  countryAccountToken)
        let cleverTapAdditionalInstance = CleverTap.instance(with: ctConfig)
        let profile: Dictionary<String, Any> = [
            "Name": "Kuwait iOS",
            "Email": "ioskuwait1@test.com",
            "Identity": "ioskuwait1"
        ]

        cleverTapAdditionalInstance.onUserLogin(profile)
    }
}
