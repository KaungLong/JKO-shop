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

    init(viewProtocol: MainViewProtocol?) {
        self.viewProtocol = viewProtocol
    }

}

protocol MainViewProtocol: BaseProtocol {
    func reloadData()
}
