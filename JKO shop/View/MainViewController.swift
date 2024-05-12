//
//  MainController.swift
//  JKO shop
//
//  Created by 10322 on 2024/3/2.
//

import UIKit
import SnapKit

class MainController: BaseViewController<MainPresenter> {
    let searchController = UISearchController(searchResultsController: nil)
    var productViewController: ProductViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainPresenter(viewProtocol: self)
        setupNavigation()
        setupSearchController()
        setupProductViewController()
        setupUI()
    }
    
    private func setupNavigation() {
        self.title = "JKO Shop"
    }

    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Products"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupProductViewController() {
        productViewController = ProductViewController()
        addChild(productViewController)
        view.addSubview(productViewController.view)
        productViewController.didMove(toParent: self)
    }
    
    private func setupUI() {
        view.backgroundColor = .brown
        
        productViewController.view.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
    }

}

extension MainController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
      
    }
}

extension MainController: MainViewDelegate {
    func reloadData() {

    }
}



