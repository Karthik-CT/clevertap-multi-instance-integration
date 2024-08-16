//
//  NotificationService.swift
//  NotificationServiceDemo
//
//  Created by Karthik Iyer on 25/05/23.
//

import UserNotifications
import CTNotificationService
import CleverTapSDK

class NotificationService: CTNotificationServiceExtension {
    
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    
    let defaults = UserDefaults(suiteName: "group.clevertapTest")
    var cleverTapAdditionalInstance : CleverTap?
    
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        
        //here in the below code get your accountId and accountToken from the app groups this will help to initiate the selected instance of clevertap dashboard
        //        let ctConfig = CleverTapInstanceConfig.init(accountId: "TEST-W8W-6WR-846Z", accountToken:  "TEST-206-0b0")
        //        ctConfig.logLevel = CleverTapLogLevel.debug
        //        ctConfig.analyticsOnly = false
        //        ctConfig.enablePersonalization = false
        //        let cleverTapAdditionalInstance = CleverTap.instance(with: ctConfig)
        //
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
        
        cleverTapAdditionalInstance?.recordEvent("NotificationServiceEventForPushImpression")
        
        
        //here in the below code get your identity, emailid and phone_number from the app groups
        //        let profile: Dictionary<String, Any> = [
        //            "Identity": "kuwaitios6",
        //            "Email": "kuwaitios6@test.com",]
        //        cleverTapAdditionalInstance.onUserLogin(profile)
        // call to record the Notification viewed
        cleverTapAdditionalInstance?.recordNotificationViewedEvent(withData:request.content.userInfo)
        //        cleverTapAdditionalInstance.recordNotificationViewedEvent(withData:"kuwaitios4")
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
