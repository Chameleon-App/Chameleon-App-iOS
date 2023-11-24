//
//  BaseHostingController.swift
//  chameleon
//
//  Created by Ilia Chub on 24.11.2023.
//

import SwiftUI

class BaseHostingController<Content: View>: UIViewController, Navigatable {
    let controller: UIHostingController<Content>?
    
    var navigationBarModel: NavigationBarModel = .default { didSet { configureNavigationBar() } }
    
    var isBackButtonHidden: Bool { false }
    var isNavigationBarHidden: Bool { false }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let controller {
            addChild(controller)
            view.addSubview(controller .view)
            
            controller.view.frame = view.bounds
            controller.didMove(toParent: self)
        }
        
        configureNavigationBar()
        configureNavigationBarVisibility()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigationBarVisibility()
    }
    
    init(rootView: Content) {
        controller = UIHostingController(rootView: rootView)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable) @MainActor dynamic required init?(coder aDecoder: NSCoder) {
        controller = nil
        
        super.init(coder: aDecoder)
    }
}
