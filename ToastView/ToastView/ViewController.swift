//
//  ViewController.swift
//  ToastView
//
//  Created by gaeng on 2023/05/25.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        ToastView.showToast(with: "Test")
    }
}
