//
//  ButtomButtonModifier.swift
//  SampleTinderApp
//
//  Created by 中川賢亮 on 2022/06/13.
//

import SwiftUI

// カスタムモディファイア
struct ButtomButtonModifier: ViewModifier {

    var size: CGFloat

    // content View自体のこと
    func body(content: Content) -> some View {
        content
            .frame(width: size, height: size)
            .cornerRadius(size)
            .shadow(radius: 10)
    }
}
