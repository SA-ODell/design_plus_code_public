//
//  AppDelegate.swift
//  DesignCodeApp
//
//  Created by Meng To on 2017-07-13.
//  Copyright © 2017 Meng To. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications
import Fabric
import Crashlytics
import Firebase
import LifetimeTracker
import netfox
import UserNotifications
import FirebaseInstanceID
import FirebaseMessaging
import Ambience
import AVKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        _ = Ambience.shared
        
        Ambience.shared.insert([
            .invert(upper: 0.2),
            .regular(lower: 0.1, upper: 1.0),
            .contrast(lower: nil),
        ])

        // Realm starting bundle
        Realm.copyDefaultRealmToDocumentsDirectory()
        
        // Fabric
        // Fabric.with([Crashlytics.self])
        
        // Firebase
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        // FirebaseApp.configure()
        
        // Remote Config
        RemoteConfig.shared.fetchItems {}
        
        // Subscriptions
//        SubscriptionManager.shared.verifyRecipit()
        
        #if DEBUG
//            LifetimeTracker.setup(onUpdate: LifetimeTrackerDashboardIntegration(visibility: .alwaysVisible).refreshUI)
        #endif
        
        #if STAGING
            NFX.sharedInstance().start()
        #endif

        // Images
        ChapterImageHandler.shared.prepareImages()
        
        // Purchases
        PurchasesManager.shared.startPurchases()
        
        // Restore background downloads
        _ = DownloadManager.shared
        
        // Set playback
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        } catch {}

        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        SyncService.sync()
    }
}

// MARK: - Push Notifications
extension AppDelegate: UNUserNotificationCenterDelegate, MessagingDelegate {

    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        // TODO: - Store it on our own server?
    }
    
    // The callback to handle data message received via FCM for devices running iOS 10 or above.
    func application(received remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
}
