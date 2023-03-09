//
//  View.Extension.swift
//  SampleTinderApp
//
//  Created by 中川賢亮 on 2022/06/13.
//

import SwiftUI


extension View {

    func asRoundShadow(size: CGFloat) -> some View {

        modifier(ButtomButtonModifier(size: size))
    }

    func asSignInTextField() -> some View {

        modifier(SignInTextModifier())
    }
}
