//
//  ProductViewPresenter.swift
//  JKO shop
//
//  Created by 10322 on 2024/3/2.
//

import Foundation
import UIKit

class ProductViewPresenter {
    private(set) weak var viewDelegate: ProductViewDelegate?
    var products: [Product] = []
    var filteredProducts: [Product] = []

    init(viewDelegate: ProductViewDelegate?) {
        self.viewDelegate = viewDelegate
    }
    
    func loadProducts() {
        NetworkService.shared.request(endpoint: .getAllProduct, decodingTo: [Product].self) { [weak self] result in
            switch result {
            case .success(let products):
                print("成功獲取列表: \(products.count)個產品")
                DispatchQueue.main.async {
                    self?.products = products
                    self?.filteredProducts = products // 假設您想要初始顯示所有產品
                    self?.viewDelegate?.reloadData()
                }
            case .failure(let error):
                print("請求失敗: \(error)")
                self?.viewDelegate?.defaultError("無法加載產品，請稍後再試。", currentAlert: UIAlertController())
            }
        }
    }
}

protocol ProductViewDelegate: BaseProtocol {
    func reloadData()
}
