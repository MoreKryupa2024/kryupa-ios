//
//  DateExtentions.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 11/11/24.
//

import Foundation

extension Date {
    static func getDates(forLastNDays nDays: Int) -> [WeakDayData] {
        let cal = NSCalendar.current
        // start with today
        var date = cal.date(byAdding: Calendar.Component.day, value: -1, to: Date())!

        var arrDates = [WeakDayData]()

        for _ in 0 ... (nDays-1) {
            // move back in time by one day:
            date = cal.date(byAdding: Calendar.Component.day, value: +1, to: date)!

            let weakDay = WeakDayData(id: arrDates.count + 1,
                                      day: dateFormatChange(dateFormat: "E", dates: date),
                                      numDay: dateFormatChange(dateFormat: "dd", dates: date),
                                      serverDate: dateFormatChange(dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", dates: date),
                                      serverTime: dateFormatChange(dateFormat: "HH:mm:ss", dates: date))
            arrDates.append(weakDay)
        }
        return arrDates
    }
    
    func formattedDateString(format: String? = "MMM d, h:mm a") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT:0) // UTC
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
        
    }
    
    func formattedNoTimeZoneDateString(format: String? = "MMM d, h:mm a") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
        
    }
}

func dateFormatChange(dateFormat:String, dates: Date)-> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    return dateFormatter.string(from: dates)
}

func dateFormatChangeToDate(dateFormat:String, dates: String)-> Date?{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    return dateFormatter.date(from: dates)
}

func dateFormatChangeToDate(dates: String)-> Date?{
    let dateFormatter = DateFormatter()
    return dateFormatter.date(from: dates)
}

func convertDateFormater(date: String,beforeFormat: String, afterFormat: String,beforeZone: String, afterZone: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = beforeFormat
    dateFormatter.timeZone = NSTimeZone(name: "UTC") as? TimeZone

    guard let date = dateFormatter.date(from: date) else {
        assert(false, "no date from string")
        return ""
    }

    dateFormatter.dateFormat = afterFormat
    dateFormatter.timeZone = NSTimeZone(name: "UTC") as? TimeZone
    let timeStamp = dateFormatter.string(from: date)

    return timeStamp
}
