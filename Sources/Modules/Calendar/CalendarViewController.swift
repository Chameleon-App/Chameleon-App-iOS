//
//  CalendarViewController.swift
//  chameleon
//
//  Created by Ilia Chub on 22.01.2023.
//

import UIKit

class CalendarViewController: BaseHostingController<CalendarView> {
    override var isNavigationBarHidden: Bool { true }
    
    init(viewModel: CalendarViewModel) {
        super.init(rootView: CalendarView(viewModel: viewModel))
    }
}
