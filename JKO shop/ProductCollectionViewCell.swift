//
//  ProductCollectionViewCell.swift
//  JKO shop
//
//  Created by 10322 on 2024/3/2.
//

import Foundation
import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProductCollectionViewCell"
    
    // UI组件，如图片和标签
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    // 初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(productImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 配置Cell
    func configure(with product: Product) {

        nameLabel.text = product.title
        priceLabel.text = "$\(product.price)"

        if let imageUrl = URL(string: product.images.first ?? "") {
//            productImageView.load(url: imageUrl)
        }
    }
    
    private func applyConstraints() {

    }
}
