//
//  OmanScreenViewController.swift
//  MultiInstanceProject
//
//  Created by Karthik Iyer on 12/01/23.
//

import UIKit
import CleverTapSDK

class OmanScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let ctConfig = CleverTapInstanceConfig.init(accountId: "TEST-RK4-66R-966Z", accountToken:  "TEST-266-432")
        ctConfig.logLevel = CleverTapLogLevel.debug
        ctConfig.disableIDFV = true
        ctConfig.analyticsOnly = true
        ctConfig.enablePersonalization = false
        
        let cleverTapAdditionalInstance = CleverTap.instance(with: ctConfig)
        cleverTapAdditionalInstance.recordEvent("Oman Screen Viewed")
    }
    
    @IBAction func omanOnUserLoginBtn(_ sender: Any) {
        let ctConfig = CleverTapInstanceConfig.init(accountId: "TEST-RK4-66R-966Z", accountToken:  "TEST-266-432")
        let cleverTapAdditionalInstance = CleverTap.instance(with: ctConfig)
        let profile: Dictionary<String, Any> = [
            "Name": "Oman iOS 1",
            "Email": "omanios1@test.com",
            "Identity": "omanios1"
        ]

        cleverTapAdditionalInstance.onUserLogin(profile)
        //push notification
        cleverTapAdditionalInstance.recordNotificationViewedEvent(withData: <#T##Any#>)
    }
    

}
