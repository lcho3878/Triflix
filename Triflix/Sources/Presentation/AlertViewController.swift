//
//  AlertViewController.swift
//  Triflix
//
//  Created by YJ on 10/10/24.
//

import UIKit

final class AlertViewController: UIViewController {
    // MARK: Properties
    let alertView = AlertView()
    
    // MARK: View Life Cycle
    override func loadView() {
        view = alertView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAddTarget()
    }
}

extension AlertViewController {
    @objc
    private func dismissClick() {
        dismiss(animated: true)
    }
    
    private func configureAddTarget() {
        alertView.okButton.addTarget(self, action: #selector(dismissClick), for: .touchUpInside)
    }
}
