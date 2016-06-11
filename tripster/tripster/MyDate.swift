//
//  MyDate.swift
//  tripster
//
//  Created by Napol Rachatasumrit on 6/12/16.
//  Copyright © 2016 Napol Rachatasumrit. All rights reserved.
//

import Foundation

class MyDate: Comparable{
    var month: Int
    var day: Int
    
    init(month: Int, day: Int) {
        // Initialize stored properties.
        self.month = month
        self.day = day
    }
    
    init(date: NSDate) {
        var month:Int
        var day:Int
        
        (month, day) = MyDate.getDate(date)
        self.month = month
        self.day = day
    }
    
    func getValue() -> Int {
        return self.month * 100 + self.day
    }
    
    func getDateString() -> String {
        return "\(self.day)-\(self.month)"
    }
    
    private static func getDate(date: NSDate) -> (Int, Int) {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        
        return (components.month, components.day)
    }
    
}

func < (lhs: MyDate, rhs: MyDate) -> Bool {
    if lhs.month < rhs.month {
        return true
    } else if lhs.month > rhs.month {
        return false
    } else {
        if lhs.day < rhs.day {
            return true
        } else {
            return false
        }
    }
}

func == (lhs: MyDate, rhs: MyDate) -> Bool {
    return (lhs.month == rhs.month) && (lhs.day == rhs.day)
}

