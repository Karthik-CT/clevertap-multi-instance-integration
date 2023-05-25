//
//  NotificationService.swift
//  NotificationServiceDemo
//
//  Created by Karthik Iyer on 25/05/23.
//

import UserNotifications
import CTNotificationService
import CleverTapSDK

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        
        //here in the below code get your accountId and accountToken from the app groups this will help to initiate the selected instance of clevertap dashboard
        let ctConfig = CleverTapInstanceConfig.init(accountId: "TEST-654-Z9R-646Z", accountToken:  "TEST-2c1-456")
        ctConfig.logLevel = CleverTapLogLevel.debug
        ctConfig.disableIDFV = true
        ctConfig.analyticsOnly = false
        ctConfig.enablePersonalization = false
        let cleverTapAdditionalInstance = CleverTap.instance(with: ctConfig)
        
        cleverTapAdditionalInstance.recordEvent("NotificationServiceEventForPushImpression")
        
        
        //here in the below code get your identity, emailid and phone_number from the app groups
        let profile: Dictionary<String, Any> = [
            "Identity": "kuwaitios2",
            "Email": "kuwaitios2@test.com",]
        cleverTapAdditionalInstance.onUserLogin(profile)
        // call to record the Notification viewed
        cleverTapAdditionalInstance.recordNotificationViewedEvent(withData:request.content.userInfo)
        super.didReceive(request, withContentHandler: contentHandler)

    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
