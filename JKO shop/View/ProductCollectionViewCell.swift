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

    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        // 設置一個預設的占位圖像
        imageView.image = UIImage(named: "placeholder")
        return imageView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(productImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(activityIndicator)

        applyConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    func configure(with product: Product) {
        nameLabel.text = product.title
        priceLabel.text = "$\(product.price)"

        activityIndicator.startAnimating()
        print("product.images:\(product.images)")
        guard let imageUrlString = product.images.first?.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: ""),
              let imageUrl = URL(string: imageUrlString) else {
            print("無效圖片url:\(product.title)")
            return
        }

        activityIndicator.startAnimating()

        NetworkService.shared.loadImage(url: imageUrl) { [weak self] image in
            self?.activityIndicator.stopAnimating()
            guard let self = self, let loadedImage = image else {
                print("圖片加載失敗:\(product.title)")
//                 self.imageView.image = UIImage(named: "defaultImage")
                return
            }
            self.productImageView.image = loadedImage
        }
    }
    
    private func applyConstraints() {
        productImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(productImageView.snp.width)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(10)
        }

        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(10)
            make.bottom.lessThanOrEqualToSuperview().inset(10)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(productImageView)
        }
    }
}
