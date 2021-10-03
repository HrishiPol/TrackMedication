//
//  NotificationManager.swift
//  TrackMedicine
//
//  Created by Hrishikesh Pol on 2/10/21.
//

import Foundation
import UserNotifications

struct Notification {
    var id: NotificationIdentifiers
    var title:String
    var datetime:DateComponents
}

enum NotificationIdentifiers: String {
    case morning
    case afternoon
    case evening
    case none
}

class NotificationManager {
    static let shared = NotificationManager()
    var notifications = [Notification]()
    
    func schedule() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            switch settings.authorizationStatus {
            case .notDetermined:
                let center = UNUserNotificationCenter.current()
                center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
                    if granted {
                        self.createNotifications()
                    }
                }
            case .authorized, .provisional:
                self.createNotifications()
            default:
                break
            }
        }
    }
    
    func createNotifications() {
        if !self.checkIfAlreadyScheduleForTime(identifier: NotificationIdentifiers.morning.rawValue) {
            //11
            self.notifications.append(Notification(id: NotificationIdentifiers.morning,
                                              title: "Morning medications are pending",
                                              datetime: DateComponents(calendar: Calendar.current, hour: 11, minute: 0)))
        } else {
            // Remove if medicine taken
        }
        if !self.checkIfAlreadyScheduleForTime(identifier: NotificationIdentifiers.afternoon.rawValue) {
            //2
            self.notifications.append(Notification(id: NotificationIdentifiers.afternoon,
                                              title: "Afternoon medications are pending",
                                              datetime: DateComponents(calendar: Calendar.current, hour: 14, minute: 0)))
        } else {
            
        }
        if !self.checkIfAlreadyScheduleForTime(identifier: NotificationIdentifiers.evening.rawValue) {
            // 8
            self.notifications.append(Notification(id: NotificationIdentifiers.evening,
                                              title: "Evening medications are pending",
                                              datetime: DateComponents(calendar: Calendar.current, hour: 20, minute: 0)))
        } else {
            
        }
        self.scheduleNotifications()
    }
    
    func checkIfAlreadyScheduleForTime(identifier: String) -> Bool {
        var isAlreadyScheduled = false
        UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: { (requests) in
            for request in requests {
                if request.identifier == identifier {
                    //Notification already exists. Do stuff.
                    isAlreadyScheduled = true
                } else if request === requests.last {
                    isAlreadyScheduled = false
                }
            }
        })
        return isAlreadyScheduled
    }
    
    func scheduleNotifications() {
        
        for notification in notifications {
            let center = UNUserNotificationCenter.current()
            let content = UNMutableNotificationContent()
            content.title = notification.title
            content.categoryIdentifier = notification.id.rawValue
            content.sound = UNNotificationSound.default
            let trigger = UNCalendarNotificationTrigger(dateMatching: notification.datetime, repeats: true)
            let request = UNNotificationRequest(identifier: notification.id.rawValue, content: content, trigger: trigger)
            center.add(request)
        }
    }
}
