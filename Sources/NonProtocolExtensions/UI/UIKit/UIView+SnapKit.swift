//
//  UIView+SnapKit.swift
//  chameleon
//
//  Created by Ilia Chub on 24.11.2023.
//

import UIKit
import SnapKit

extension UIView {
    func centeringSubview(view: UIView) {
        addSubview(view)

        view.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
        }
    }
    
    func equalSubview(view: UIView) {
        addSubview(view)

        view.snp.makeConstraints { make in
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
        }
    }
}
