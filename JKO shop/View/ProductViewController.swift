//
//  ProductViewController.swift
//  JKO shop
//
//  Created by 10322 on 2024/3/2.
//

import Foundation
import UIKit

class ProductViewController: BaseViewController<ProductViewPresenter> {
    var products: [Product] = []
    
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ProductViewPresenter(viewDelegate: self)
        
        setupCollectionView()
        setupUI()
        
        presenter.loadProducts()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.size.width/2 - 10, height: view.frame.size.width/2 + 60)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else {
            return
        }
        
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }
    
    private func setupUI() {
        collectionView!.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

extension ProductViewController: ProductViewDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.products = self.presenter.filteredProducts
            self.collectionView?.reloadData()
        }
    }
}

extension ProductViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        let detailVC = ProductDetailViewController()
        // 假设ProductDetailViewController有一个product属性或者初始化方法来设置产品信息
        detailVC.product = product
        // 这里选择推送或模态展示，根据你的导航结构而定
        // 如果你使用的是UINavigationController，可以这样推送：
        navigationController?.pushViewController(detailVC, animated: true)
        
        // 如果没有使用UINavigationController或者你想要模态展示，可以这样：
        // present(detailVC, animated: true, completion: nil)
    }
}

extension ProductViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else {
            fatalError("Unable to dequeue ProductCollectionViewCell")
        }
        let product = products[indexPath.row]
        cell.configure(with: product)
        return cell
    }
}

