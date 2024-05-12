//
//  MainPresenter.swift
//  JKO shop
//
//  Created by 10322 on 2024/3/2.
//

import Foundation
import UIKit

class MainPresenter {
    private(set) weak var viewProtocol: MainViewDelegate?
    
    var shouldStopTaskWhenLeave = true
    var taskList: [Task<Void, Never>?] = []
    
    func suspendAllTasks() {
        for task in taskList {
            task?.cancel()
        }
    }
    
    init(viewProtocol: MainViewDelegate?) {
        self.viewProtocol = viewProtocol
    }

}

protocol MainViewDelegate: BaseProtocol {
    func reloadData()
}
