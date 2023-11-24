//
//  NavigationBarCentralItemView.swift
//  chameleon
//
//  Created by Ilia Chub on 24.11.2023.
//

import UIKit

final class NavigationBarCentralItemView: BaseView {
    private let model: NavigationBarCentralItemModel

    override func initSetup() {
        super.initSetup()
        
        switch model.type {
        case .title(let title):
            initSetupWithTitle(title: title)
        case .customView(let customView):
            initSetupWithCustomView(customView: customView)
        case .empty:
            break
        }
        
        if model.isLayoutWithAnimation {
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.layoutIfNeeded()
            }
        }
        
        addGestureRecognizer()
    }
    
    required init(model: NavigationBarCentralItemModel) {
        self.model = model
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError(DeveloperService.Messages.initHasNotBeenImplemented)
    }
    
    required init(fromCodeWithFrame frame: CGRect) {
        fatalError(DeveloperService.Messages.initHasNotBeenImplemented)
    }
    
    private func initSetupWithTitle(title: String) {
        let label = UILabel(frame: .zero)

        label.text = title
        label.textColor = UIColor(resource: .textPrimary)
        label.font = .systemFont(ofSize: 17, weight: .semibold)

        centeringSubview(view: label)
    }
    
    private func initSetupWithCustomView(customView: UIView) {
        equalSubview(view: customView)
    }
    
    private func addGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))

        addGestureRecognizer(tap)
    }
    
    @objc private func handleTap() {
        model.onTapAction?()
    }
}

