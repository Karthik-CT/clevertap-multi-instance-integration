//
//  KuwaitScreenViewController.swift
//  MultiInstanceProject
//
//  Created by Karthik Iyer on 12/01/23.
//

import UIKit
import CleverTapSDK

class KuwaitScreenViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        CleverTap.autoIntegrate()
        CleverTap.setDebugLevel(3)
//        registerForPush()
//        CleverTap.setCredentialsWithAccountID("TEST-654-Z9R-646Z", andToken: "TEST-2c1-456")

        let ctConfig = CleverTapInstanceConfig.init(accountId: "TEST-654-Z9R-646Z", accountToken:  "TEST-2c1-456")
        ctConfig.logLevel = CleverTapLogLevel.debug
        ctConfig.disableIDFV = true
        ctConfig.analyticsOnly = false
        ctConfig.enablePersonalization = false
        //registerForPush()
        let cleverTapAdditionalInstance = CleverTap.instance(with: ctConfig)
        
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
        let ctConfig = CleverTapInstanceConfig.init(accountId: "TEST-654-Z9R-646Z", accountToken:  "TEST-2c1-456")
        let cleverTapAdditionalInstance = CleverTap.instance(with: ctConfig)
        let profile: Dictionary<String, Any> = [
            "Name": "Kuwait iOS 2",
            "Email": "kuwaitios2@test.com",
            "Identity": "kuwaitios2"
        ]

        cleverTapAdditionalInstance.onUserLogin(profile)
    }
}
