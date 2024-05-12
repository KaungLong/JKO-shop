//
//  BaseViewController.swift
//  JKO shop
//
//  Created by 10322 on 2024/3/2.
//

import Foundation
import UIKit

class BaseViewController<BaseViewPresenter>: UIViewController, BaseProtocol {
    var presenter: BaseViewPresenter!
    var refreshControl: UIRefreshControl?
    
    var shouldStopTaskWhenLeave = true
    var taskList: [Task<Void, Never>?] = []
    
    func suspendAllTasks() {
        for task in taskList {
            task?.cancel()
        }
    }

    override func viewDidDisappear(_: Bool) {
        if shouldStopTaskWhenLeave {
            suspendAllTasks()
        }
    }
    
    func defaultError(_ message: String, currentAlert: UIViewController? = nil) {
        DispatchQueue.main.async { [weak self] in
            guard let self else {
                return
            }

            // alert
            self.refreshControl?.endRefreshing()
            if let currentAlert {
                currentAlert.dismiss(animated: true) {
                    self.showFailAlert(message)
                }
            } else {
                self.showFailAlert(message)
            }
        }
    }
    
    func showFailAlert(_ message: String) {
        let alert = AlertCtrller.hintAlert(title: "failed",
                                           message: message,
                                           posText: "ok") { [weak self] _ in
            self?.refreshControl?.endRefreshing()
        }
        if presentedViewController == nil {
            present(alert, animated: true)
        }
    }
}

protocol BaseProtocol: AnyObject {
    func defaultError(_ message: String, currentAlert: UIViewController?)
}

