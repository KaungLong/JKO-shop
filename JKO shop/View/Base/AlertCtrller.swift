//
//  AlertCtrller.swift
//  JKO shop
//
//  Created by 10322 on 2024/3/3.
//

import Foundation
import UIKit
import Lottie

class AlertCtrller{
    /// single hint alert, for cancel/do something
    public static func hintAlert(title: String,
                                 message: String? = nil,
                                 preferredStyle: UIAlertController.Style = .alert,
                                 negText: String? = nil,
                                 posText: String? = nil,
                                 posAction: ((UIAlertAction) -> Void)? = nil) -> UIAlertController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        if let negText = negText {
            alert.addAction(UIAlertAction(title: negText, style: .cancel, handler: nil))
        }
        
        if let posText = posText {
            alert.addAction(UIAlertAction(title: posText, style: .default, handler: posAction))
        }
        return alert
    }
    
    /// loading alert
    static func waitingAlert(title: String,
                             animation: LottieAnimationView? = nil,
                                    traitStyle: UIUserInterfaceStyle = .light) -> UIAlertController{
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        // animation
        if let animation = animation {
            alert.view.addSubview(animation)
        }else{
            var loading = LottieAnimation.named("loading_3", bundle: Bundle.main)
            if traitStyle == .dark{
                loading = LottieAnimation.named("loading_3_dark", bundle: Bundle.main)
            }
            
            let animationView = LottieAnimationView()
            animationView.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
            animationView.center = CGPoint(x: 135, y: 90) // alertView's width is 270
            animationView.animation = loading
            animationView.loopMode = .loop
            animationView.backgroundBehavior = .pauseAndRestore
            animationView.play()
            alert.view.addSubview(animationView)
        }
        
        let constHeight = NSLayoutConstraint(item: alert.view!, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .height, multiplier: 1, constant: 140)
        alert.view.addConstraint(constHeight)
        
        return alert
    }
    
    /// progress alert
    public static func progressAlert(title: String,
                                     message: String? = nil,
                                     initVal: Float = 0)-> CustomProgressAlert{
        let alert = CustomProgressAlert(title: title, message: message, preferredStyle: .alert)
        alert.progressVal = initVal
        return alert
    }
}

final public class CustomProgressAlert: UIAlertController{
    // ui
    private let progressView = UIProgressView(frame: CGRect(x: 0, y: 0, width: 238, height: 6))
    
    // progress value
    public var progressVal : Float{
        get{
            return progressView.progress
        }
        set(val){
            progressView.setProgress(val, animated: true)
        }
    }
    
    public var progressColor : UIColor?{
        set{
            progressView.progressTintColor = newValue
        }
        get{
            progressView.progressTintColor
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        // progress view
        progressView.center = CGPoint(x: 135, y: 90)
        progressView.layer.cornerRadius = 2
        view.addSubview(progressView)
        
        let constHeight = NSLayoutConstraint(item: self.view!, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .height, multiplier: 1, constant: 140)
        self.view.addConstraint(constHeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
