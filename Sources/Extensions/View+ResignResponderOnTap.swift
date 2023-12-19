//
//  View+ResignResponderOnTap.swift
//  chameleon
//
//  Created by Ilia Chub on 19.12.2023.
//

import SwiftUI

extension View {
    func resignResponderOnTap() -> some View {
        return self
            .onTapGesture {
                UIApplication.shared.sendAction(
                    #selector(UIResponder.resignFirstResponder),
                    to: nil,
                    from: nil,
                    for: nil
                )
            }
    }
}
