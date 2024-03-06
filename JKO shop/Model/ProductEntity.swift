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

    enum CodingKeys: String, CodingKey {
        case id, name, image
        case creationAt = "creationAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        image = try container.decode(String.self, forKey: .image)

        let creationAtString = try container.decode(String.self, forKey: .creationAt)
        let updatedAtString = try container.decode(String.self, forKey: .updatedAt)
        
        guard let creationDate = ISO8601DateFormatter.withFractionalSeconds.date(from: creationAtString),
              let updateDate = ISO8601DateFormatter.withFractionalSeconds.date(from: updatedAtString) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: container.codingPath, debugDescription: "日期字符串格式不正确"))

        }

        creationAt = creationDate
        updatedAt = updateDate
    }
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

    enum CodingKeys: String, CodingKey {
        case id, title, price, description, images, category
        case creationAt = "creationAt"
        case updatedAt = "updatedAt"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        price = try container.decode(Int.self, forKey: .price)
        description = try container.decode(String.self, forKey: .description)
        images = try container.decode([String].self, forKey: .images)
        category = try container.decode(Category.self, forKey: .category)

        let creationAtString = try container.decode(String.self, forKey: .creationAt)
        let updatedAtString = try container.decode(String.self, forKey: .updatedAt)
        
        guard let creationDate = ISO8601DateFormatter.withFractionalSeconds.date(from: creationAtString),
              let updateDate = ISO8601DateFormatter.withFractionalSeconds.date(from: updatedAtString) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: container.codingPath, debugDescription: "日期字符串格式不正确"))

        }

        creationAt = creationDate
        updatedAt = updateDate
    }
}

extension ISO8601DateFormatter {
    static let withFractionalSeconds: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
}
