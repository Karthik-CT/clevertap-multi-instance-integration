//
//  NotificationViewController.swift
//  NotificationContentDemo
//
//  Created by Karthik Iyer on 25/05/23.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import CleverTapSDK
import CTNotificationContent

class NotificationViewController: CTNotificationViewController {
    
    @IBOutlet var label: UILabel?
    
    let defaults = UserDefaults(suiteName: "group.clevertapTest")
    var cleverTapAdditionalInstance : CleverTap?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
    }
    
    override func userDidPerformAction(_ action: String, withProperties properties: [AnyHashable : Any]!) {
        print("userDidPerformAction \(action) with props \(String(describing: properties))")
    }
    
    // optional: implement to get notification response
    override func userDidReceive(_ response: UNNotificationResponse?) {
        
        //here in the below code get your accountId and accountToken from the app groups this will help to initiate the selected instance of clevertap dashboard
        
        let getFlagValue = defaults?.value(forKey: "countryFlagSelected") as? String
        let countryAccountID = defaults?.value(forKey: "countryAccountID")
        let countryAccountToken = defaults?.value(forKey: "countryAccountToken")
        
        
        if (getFlagValue == "KWT") {
            let ctConfig = CleverTapInstanceConfig.init(accountId: countryAccountID as! String, accountToken: countryAccountToken as! String)
            ctConfig.logLevel = CleverTapLogLevel.debug
            ctConfig.analyticsOnly = false
            ctConfig.enablePersonalization = false
            cleverTapAdditionalInstance = CleverTap.instance(with: ctConfig)
        }
        else if (getFlagValue == "OMN") {
            let ctConfig = CleverTapInstanceConfig.init(accountId: countryAccountID as! String, accountToken: countryAccountToken as! String)
            ctConfig.logLevel = CleverTapLogLevel.debug
            ctConfig.analyticsOnly = false
            ctConfig.enablePersonalization = false
            cleverTapAdditionalInstance = CleverTap.instance(with: ctConfig)
        }
        
        print("Push Notification Payload \(String(describing: response?.notification.request.content.userInfo))")
        let notificationPayload = response?.notification.request.content.userInfo
        if (response?.actionIdentifier == "action_2") {
            cleverTapAdditionalInstance?.recordNotificationClickedEvent(withData: notificationPayload ?? "")
            print("This is from NotificationContent class")
        }
    }
    
}
