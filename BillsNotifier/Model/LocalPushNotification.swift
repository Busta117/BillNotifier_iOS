//
//  LocalPushNotification.swift
//  BillsNotifier
//
//  Created by Santiago Bustamante on 3/16/19.
//  Copyright © 2019 Busta. All rights reserved.
//

import UIKit
import UserNotifications
import DateToolsSwift

struct Notification {
    var id: String
    var date: Date
    var title: String
    var subtitle: String
    var count: Int
    
    static func notifications(for claro: ClaroBill) -> [Notification] {
        
        // 3 days before
        var date1 = claro.expireDate
        date1 = date1.add(TimeChunk(seconds: 0, minutes: 0, hours: 10, days: 0, weeks: 0, months: 0, years: 0))
        date1 = date1.subtract(TimeChunk(seconds: 0, minutes: 0, hours: 0, days: 3, weeks: 0, months: 0, years: 0))
        
        let subtitle1 = "Parcero, la factura " + (claro.accountType == .mobile ? "del celular \(claro.accountId)" : "Hogar(\(claro.city)) \(claro.accountId)") + " vence en 3 dias, el valor es de \(CurrencyFormatter.shared.format(claro.value)!)"
        let notification1 = Notification(id: "\(claro.id)", date: date1, title: "Claro", subtitle: subtitle1, count: 0)
        
        // 2 days before
        let date2 = date1.add(TimeChunk(seconds: 0, minutes: 0, hours: 0, days: 1, weeks: 0, months: 0, years: 0))
        let subtitle2 = "Parcero, la factura " + (claro.accountType == .mobile ? "del celular \(claro.accountId)" : "Hogar(\(claro.city)) \(claro.accountId)") + " vence en 2 dias, el valor es de \(CurrencyFormatter.shared.format(claro.value)!)"
        let notification2 = Notification(id: "\(claro.id)", date: date2, title: "Claro", subtitle: subtitle2, count: 1)
        
        // same day
        let date3 = date2.add(TimeChunk(seconds: 0, minutes: 0, hours: 0, days: 2, weeks: 0, months: 0, years: 0))
        let subtitle3 = "Parcero, la factura " + (claro.accountType == .mobile ? "del celular \(claro.accountId)" : "Hogar(\(claro.city)) \(claro.accountId)") + " vence HOY!!, el valor es de \(CurrencyFormatter.shared.format(claro.value)!)"
        let notification3 = Notification(id: "\(claro.id)", date: date3, title: "Claro", subtitle: subtitle3, count: 2)
        
        return [notification1, notification2, notification3]
    }
    
    
    static func notifications(for epm: [EPMBill]) -> [Notification] {
        
        var notifications = [Notification]()
        
        epm.forEach { bill in
            
            // 3 days before
            var date1 = bill.expireDate
            date1 = date1.add(TimeChunk(seconds: 0, minutes: 0, hours: 10, days: 0, weeks: 0, months: 0, years: 0))
            date1 = date1.subtract(TimeChunk(seconds: 0, minutes: 0, hours: 0, days: 3, weeks: 0, months: 0, years: 0))
            
            let subtitle1 = "Parcero, la factura \(bill.id) (contrato \(bill.contractNumber)) vence en 3 dias, el valor es de \(CurrencyFormatter.shared.format(bill.value)!)"
            let notification1 = Notification(id: "\(bill.id)", date: date1, title: "EPM", subtitle: subtitle1, count: 0)
            notifications.append(notification1)
            
            // 2 days before
            let date2 = date1.add(TimeChunk(seconds: 0, minutes: 0, hours: 0, days: 1, weeks: 0, months: 0, years: 0))
            let subtitle2 = "Parcero, la factura \(bill.id) (contrato \(bill.contractNumber)) vence en 2 dias, el valor es de \(CurrencyFormatter.shared.format(bill.value)!)"
            let notification2 = Notification(id: "\(bill.id)", date: date2, title: "EPM", subtitle: subtitle2, count: 1)
            notifications.append(notification2)
            
            // same day
            let date3 = date2.add(TimeChunk(seconds: 0, minutes: 0, hours: 0, days: 2, weeks: 0, months: 0, years: 0))
            let subtitle3 = "Parcero, la factura \(bill.id) (contrato \(bill.contractNumber)) vence Hoy!!, el valor es de \(CurrencyFormatter.shared.format(bill.value)!)"
            let notification3 = Notification(id: "\(bill.id)", date: date3, title: "EPM", subtitle: subtitle3, count: 2)
            notifications.append(notification3)
            
        }
        
        
        return notifications
    }
    
    static func notifications(for bill: Bill) -> [Notification] {
        
        
        var date1 = bill.dueDate
        let today = Date()
        
        if date1 < today && bill.isMonthly {

            let dateCurrentMonth = Date(year: date1.year, month: today.month, day: date1.day)
            if dateCurrentMonth < Date(year: today.year, month: today.month, day: today.day) {
                date1 = dateCurrentMonth.add(TimeChunk(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 1, years: 0))
            } else {
                date1 = dateCurrentMonth
            }
        }
        
        
        // 3 days before
        date1 = date1.add(TimeChunk(seconds: 0, minutes: 0, hours: 10, days: 0, weeks: 0, months: 0, years: 0))
        date1 = date1.subtract(TimeChunk(seconds: 0, minutes: 0, hours: 0, days: 3, weeks: 0, months: 0, years: 0))
        
        let subtitle1 = "Parcero, la factura de \(bill.billTitle) vence en 3 dias"
        let notification1 = Notification(id: "\(bill.number)", date: date1, title: "Factura", subtitle: subtitle1, count: 0)
        
        // 2 days before
        let date2 = date1.add(TimeChunk(seconds: 0, minutes: 0, hours: 0, days: 1, weeks: 0, months: 0, years: 0))
        let subtitle2 = "Parcero, la factura de \(bill.billTitle) vence en 2 dias"
        let notification2 = Notification(id: "\(bill.number)", date: date2, title: "Factura", subtitle: subtitle2, count: 1)
        
        // same day
        let date3 = date2.add(TimeChunk(seconds: 0, minutes: 0, hours: 0, days: 2, weeks: 0, months: 0, years: 0))
        let subtitle3 = "Parcero, la factura de \(bill.billTitle) vence HOY!!"
        let notification3 = Notification(id: "\(bill.number)", date: date3, title: "Factura", subtitle: subtitle3, count: 2)
        
        return [notification1, notification2, notification3]
    }
    
}

class LocalPushNotification {

    class func setup(for notification: Notification) {
        
        let content = UNMutableNotificationContent()
        content.title = notification.title
        content.body = notification.subtitle
        content.sound = UNNotificationSound.default
        
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: notification.date)
        
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let notificationId = "\(notification.id)-\(notification.count)"
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationId])
        
        let request = UNNotificationRequest(identifier: notificationId, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
}
