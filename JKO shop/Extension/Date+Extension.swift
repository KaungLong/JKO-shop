//
//  Date+Extension.swift
//  JKO shop
//
//  Created by 10322 on 2024/3/2.
//

import Foundation

extension Date {
    static let iso8601Formatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()

    static func from(iso8601String: String) -> Date? {
        return iso8601Formatter.date(from: iso8601String)
    }
}
