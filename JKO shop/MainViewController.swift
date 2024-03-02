//
//  MainController.swift
//  JKO shop
//
//  Created by 10322 on 2024/3/2.
//

import UIKit

class MainController: UIViewController {
    var presenter: MainPresenter!
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupSearchController()

        presenter = MainPresenter(viewProtocol: self)
   
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
}

extension MainController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
      
    }
}

extension MainController: MainViewProtocol {
    func reloadData() {

    }
}

protocol MainViewProtocol: AnyObject {
    func reloadData()
}

