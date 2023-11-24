//
//  BaseViewController.swift
//  chameleon
//
//  Created by Ilia Chub on 24.11.2023.
//

import UIKit

class BaseViewController: UIViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
