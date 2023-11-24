//
//  CalendarViewController.swift
//  chameleon
//
//  Created by Ilia Chub on 22.01.2023.
//

import UIKit

class CalendarViewController: BaseHostingController<CalendarView> {
    init(viewModel: CalendarViewModel) {
        super.init(rootView: CalendarView(viewModel: viewModel))
    }
}
