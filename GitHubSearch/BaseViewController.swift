//
//  BaseViewController.swift
//  GitHubSearch
//
//  Created by Philip on 10.11.2020.
//

import UIKit

class BaseViewController: UIViewController {
    
    private let activityView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityView.center = view.center
        view.addSubview(activityView)
    }
    
    func showActivityIndicator() {
        activityView.startAnimating()
        activityView.isHidden = false
    }
    
    func hideActivityIndicator() {
        activityView.stopAnimating()
        activityView.isHidden = true
    }
}
