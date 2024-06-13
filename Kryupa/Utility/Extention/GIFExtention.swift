//
//  GIFExtention.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 21/05/24.
//

import Foundation
import SwiftUI
import WebKit

struct GifImageView: UIViewRepresentable {
    private let name: String
    init(_ name: String) {
        self.name = name
    }
func makeUIView(context: Context) -> WKWebView {
        let webview = WKWebView()
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        let data = try! Data(contentsOf: url)
        webview.load(data, mimeType: "image/gif", characterEncodingName: "UTF-8", baseURL: url.deletingLastPathComponent())
        return webview
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }
}

extension Notification.Name {
    static let setLobbyScreen = Notification.Name("SetLobbyScreen")
    static let setCareGiverHomeScreen = Notification.Name("setCareGiverHomeScreen")
    static let setCareSeekerHomeScreen = Notification.Name("setCareSeekerHomeScreen")
    static let logout = Notification.Name("logout")
}


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
}

func dateFormatChange(dateFormat:String, dates: Date)-> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    return dateFormatter.string(from: dates)
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
