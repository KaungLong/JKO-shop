//
//  ProductEntity.swift
//  JKO shop
//
//  Created by 10322 on 2024/3/2.
//

import Foundation
import Foundation

// 定義產品類別模型
struct Category: Codable {
    let id: Int
    let name: String
    let image: String
    let creationAt: Date
    let updatedAt: Date
}

// 定義產品模型
struct Product: Codable {
    let id: Int
    let title: String
    let price: Int
    let description: String
    let images: [String]
    let creationAt: Date
    let updatedAt: Date
    let category: Category
}

// 擴展Date以從字符串解析日期
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
