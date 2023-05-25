//
//  ToastView.swift
//  ToastView
//
//  Created by gaeng on 2023/05/25.
//

import UIKit

final class ToastView: UIView {
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .darkGray
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        self.addSubview(self.messageLabel)
        self.messageLabel.translatesAutoresizingMaskIntoConstraints = false
        [
            self.messageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            self.messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ].forEach {
            $0.isActive = true
        }
    }
    
    static func showToast(with message: String?) {
        Task {
            await ToastView().showToastOnMainActor(with: message)
        }
    }
    
    @MainActor
    private func showToastOnMainActor(with message: String?) async {
        self.messageLabel.text = message
        
        guard let window = UIApplication.shared.connectedScenes.compactMap({ $0 as? UIWindowScene }).first?.keyWindow else { return }
        window.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        [
            self.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: 20),
            self.centerXAnchor.constraint(equalTo: window.centerXAnchor),
            self.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: -22)
        ].forEach {
            $0.isActive = true
        }
        
        UIView.animate(withDuration: 0.2, delay: 1.5, options: .curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
}
