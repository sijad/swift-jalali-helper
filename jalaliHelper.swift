//
//  jalaliHelper.swift
//  todayShamsi
//
//  Created by Sajjad Hashemian on 4/17/15.
//  Copyright (c) 2015 Sajjad Hashemian. All rights reserved.
//

import Foundation

class jalaliHelper {
    
    private let comp: NSDateComponents
    
    private let g_days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    private let j_days_in_month = [31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 29]
    
    private let j_months_name = ["فروردین", "اردیبهشت", "خرداد", "تیر", "امرداد", "شهریور", "مهر", "آبان", "آذر", "دی", "بهمن", "اسفند"]
    private let j_days_name = ["یکشنبه", "دوشنبه", "سه شنبه", "چهارشنبه", "پنجشنبه", "جمعه", "شنبه"]
    
    private(set) var yy: Int!
    private(set) var mm: Int!
    private(set) var dd: Int!
    
    init() {
        let cale = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        comp = cale!.components([.Year, .Day, .Month, .Weekday], fromDate: NSDate())
        jajaliInit()
    }
    
    init(fromDate: NSDate) {
        let cale = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        comp = cale!.components([.Year, .Day, .Month, .Weekday], fromDate: fromDate)
        jajaliInit()
    }
    
    func jajaliInit() -> Void {
        let gy = comp.year-1600
        let gm = comp.month-1
        let gd = comp.day-1
        
        var g_day_no = (365 * gy)
        g_day_no += Int((gy + 3) / 4)
        g_day_no -= Int((gy + 99) / 100)
        g_day_no += Int((gy + 399) / 400)
        
        for i in 0..<gm {
            g_day_no += g_days_in_month[i]
        }
        
        if (gm>1 && ((gy%4 == 0 && gy%100 != 0) || (gy%400==0))) {
            g_day_no++
        }
        
        g_day_no += gd
        
        var j_day_no = g_day_no-79
        
        let j_np = Int(j_day_no/12053)
        
        j_day_no = j_day_no % 12053
        
        var jy = 979+33*j_np+4*Int(j_day_no/1461)
        
        j_day_no %= 1461
        
        if (j_day_no >= 366) {
            jy += Int((j_day_no-1) / 365)
            j_day_no = (j_day_no-1) % 365
        }
        
        var jm: Int = 0
        
        for i in 0..<11 {
            if(j_day_no < j_days_in_month[i]) {
                break
            }
            ++jm
            j_day_no -= j_days_in_month[i]
        }
        
        self.yy = jy
        self.mm = ++jm
        self.dd = ++j_day_no
    }
    
    func toJalali() -> (y: Int, m:Int, d:Int) {
        return (yy, mm, dd)
    }
    
    func getMonth() -> String {
        return j_months_name[self.mm!-1]
    }
    
    func getDay() -> String {
        return j_days_name[comp.weekday-1]
    }
}
