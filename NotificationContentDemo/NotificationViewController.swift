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
        var accountId =  UserDefaults.standard.string(forKey: "AccountId")!
        var accountToken =  UserDefaults.standard.string(forKey: "AccountToken")!
        let ctConfig = CleverTapInstanceConfig.init(accountId: accountId, accountToken:  accountToken)
        ctConfig.logLevel = CleverTapLogLevel.debug
        ctConfig.analyticsOnly = false
        ctConfig.enablePersonalization = false
        let cleverTapAdditionalInstance = CleverTap.instance(with: ctConfig)

        print("Push Notification Payload \(String(describing: response?.notification.request.content.userInfo))")
        let notificationPayload = response?.notification.request.content.userInfo
        if (response?.actionIdentifier == "action_2") {
            cleverTapAdditionalInstance.recordNotificationClickedEvent(withData: notificationPayload ?? "")
        }
    }

}
