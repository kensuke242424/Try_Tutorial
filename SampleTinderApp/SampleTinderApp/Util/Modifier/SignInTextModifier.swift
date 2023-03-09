//
//  SignInTextModifier.swift
//  SampleTinderApp
//
//  Created by 中川賢亮 on 2022/06/19.
//

import SwiftUI

// さいんいん画面のテキストフィールドに用いるカスタムモディファイア
struct SignInTextModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .frame(height: 50)
            .padding(.leading, 10)
            .textFieldStyle(PlainTextFieldStyle())
            .background(Color.white)
            .cornerRadius(5)
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color(.init(white: 0.85, alpha: 1))))

    }
}
