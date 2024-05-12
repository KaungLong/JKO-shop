//
//  ProductDetailViewController.swift
//  JKO shop
//
//  Created by 10322 on 2024/3/6.
//

import Foundation
import UIKit
import SnapKit

class ProductDetailViewController: UIViewController {
    var product: Product?
    private var imageSliderCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageSlider()
    }
    
    private func setupImageSlider() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.size.width, height: 200) // 根据需要调整高度
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        imageSliderCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        imageSliderCollectionView.register(ImageSliderCell.self, forCellWithReuseIdentifier: ImageSliderCell.identifier)
        imageSliderCollectionView.dataSource = self
        imageSliderCollectionView.delegate = self
        imageSliderCollectionView.isPagingEnabled = true
        imageSliderCollectionView.showsHorizontalScrollIndicator = false

        view.addSubview(imageSliderCollectionView)
        imageSliderCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(200) // 根据需要调整
        }
    }
}

// MARK: UICollectionViewDataSource
extension ProductDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageSliderCell.identifier, for: indexPath) as? ImageSliderCell else {
            fatalError("Unable to dequeue ImageSliderCell")
        }

        print("product?.images.first:\(String(describing: product?.images.first))")

        if let imagesJsonString = product?.images.first {
            // 移除字串兩端可能存在的JSON格式符號
            let trimmedString = imagesJsonString.trimmingCharacters(in: CharacterSet(charactersIn: "[\\]\""))
            
            // 嘗試通過\",\"來分割字串，獲取URLs數組
            let imageUrlStrings = trimmedString.components(separatedBy: "\",\"").map { $0.replacingOccurrences(of: "\\", with: "") }
            
            print("imageUrlStrings:\(imageUrlStrings)")
            
            if imageUrlStrings.count > indexPath.row {
                let imageUrl = imageUrlStrings[indexPath.row]
                print("imageUrlStrings.count:\(imageUrlStrings.count)")
                cell.configure(with: imageUrl)
            } else {
                print("索引超出圖片URLs數組範圍")
                // 可以選擇在這裡設置一個預設圖片
            }
        } else {
            print("無法獲取或解析images JSON字串")
            // 可以選擇在這裡設置一個預設圖片
        }

        return cell
    }

}

// MARK: UICollectionViewDelegate
extension ProductDetailViewController: UICollectionViewDelegate {
    //TODO: 後面新增點擊進入圖片瀏覽頁面
}



class ImageSliderCell: UICollectionViewCell {
    static let identifier = "ImageSliderCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with imageUrl: String) {
        guard let url = URL(string: imageUrl) else {
            print("Invalid URL for image: \(imageUrl)")
            return
        }
        
        NetworkService.shared.loadImage(url: url) { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView.image = image ?? UIImage(named: "placeholder")
            }
        }
    }
}
