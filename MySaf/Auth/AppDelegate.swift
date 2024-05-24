//
//  AppDelegate.swift
//  MySaf
//
//  Created by Muktar Hussein on 23/05/2024.
//
import UIKit
import UserNotifications


class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        guard
            let urlString = response.notification.request.content.userInfo["url"] as? String,
            let url = URL(string: urlString)
        else { return }
        handleNotificationURL(url: url)
    }

    func handleNotificationURL(url: URL) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .navigateToNotification, object: url)
        }
    }
}

extension Notification.Name {
    static let navigateToNotification = Notification.Name("navigateToNotification")
}


