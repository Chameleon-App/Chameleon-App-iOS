//
//  LaunchView.swift
//  chameleon
//
//  Created by Ilia Chub on 23.01.2023.
//

import SwiftUI

struct LaunchView: View {
    @ObservedObject var viewModel: LaunchViewModel
    
    var body: some View {
        Color(.backgroundPrimary)
            .edgesIgnoringSafeArea(.all)
            .onAppear { viewModel.openMainScreen() }
    }
}
