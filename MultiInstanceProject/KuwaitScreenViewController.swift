//
//  KuwaitScreenViewController.swift
//  MultiInstanceProject
//
//  Created by Karthik Iyer on 12/01/23.
//

import UIKit
import CleverTapSDK

class KuwaitScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let ctConfig = CleverTapInstanceConfig.init(accountId: "Account_ID", accountToken:  "Account_Token")
        ctConfig.logLevel = CleverTapLogLevel.debug
        ctConfig.disableIDFV = true
        ctConfig.analyticsOnly = true
        ctConfig.enablePersonalization = false
        
        let cleverTapAdditionalInstance = CleverTap.instance(with: ctConfig)
        cleverTapAdditionalInstance.recordEvent("Kuwait Screen Viewed")
    }
    
    @IBAction func kuwaitOnUserLoginBtn(_ sender: Any) {
        let ctConfig = CleverTapInstanceConfig.init(accountId: "Account_ID", accountToken:  "Account_Token")
        let cleverTapAdditionalInstance = CleverTap.instance(with: ctConfig)
        let profile: Dictionary<String, Any> = [
            "Name": "Kuwait iOS 1",
            "Email": "kuwaitios1@test.com",
            "Identity": "kuwaitios1"
        ]

        cleverTapAdditionalInstance.onUserLogin(profile)
    }
    
}
