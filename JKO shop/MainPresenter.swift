//
//  MainPresenter.swift
//  JKO shop
//
//  Created by 10322 on 2024/3/2.
//

import Foundation
import UIKit

class MainPresenter {
    private(set) weak var viewProtocol: MainViewProtocol?
    var products: [Product] = [] 
    var filteredProducts: [Product] = []

    init(viewProtocol: MainViewProtocol?) {
        self.viewProtocol = viewProtocol
    }
    
    private func loadProducts() -> [Product] {
        // 加載數據的邏輯
        return []
    }
}
