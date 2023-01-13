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
        let ctConfig = CleverTapInstanceConfig.init(accountId: "TEST-W8W-6WR-846Z", accountToken:  "TEST-206-0b0")
        ctConfig.logLevel = CleverTapLogLevel.debug
        ctConfig.disableIDFV = true
        ctConfig.analyticsOnly = true
        ctConfig.enablePersonalization = false
        
        let cleverTapAdditionalInstance = CleverTap.instance(with: ctConfig)
        cleverTapAdditionalInstance.recordEvent("Kuwait Screen Viewed")
    }
    
    @IBAction func kuwaitOnUserLoginBtn(_ sender: Any) {
        let ctConfig = CleverTapInstanceConfig.init(accountId: "TEST-W8W-6WR-846Z", accountToken:  "TEST-206-0b0")
        let cleverTapAdditionalInstance = CleverTap.instance(with: ctConfig)
        let profile: Dictionary<String, Any> = [
            "Name": "Kuwait iOS 1",
            "Email": "kuwaitios1@test.com",
            "Identity": "kuwaitios1"
        ]

        cleverTapAdditionalInstance.onUserLogin(profile)
    }
    
}
