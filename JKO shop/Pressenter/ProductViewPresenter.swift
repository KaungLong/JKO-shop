//
//  ProductViewPresenter.swift
//  JKO shop
//
//  Created by 10322 on 2024/3/2.
//

import Foundation

class ProductViewPresenter {
    private(set) weak var viewProtocol: ProductViewProtocol?
    var products: [Product] = []
    var filteredProducts: [Product] = []

    init(viewProtocol: ProductViewProtocol?) {
        self.viewProtocol = viewProtocol
    }
    
    private func loadProducts() -> [Product] {
        // 加載數據的邏輯
        return []
    }
}
