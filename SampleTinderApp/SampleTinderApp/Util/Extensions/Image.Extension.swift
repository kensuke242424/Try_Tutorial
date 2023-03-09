//
//  Image.Extension.swift
//  SampleTinderApp
//
//  Created by 中川賢亮 on 2022/06/13.
//

import SwiftUI


// カスタムモディファイア
extension Image {

    func asTopControlButtonImage() -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(width: 25, height: 25, alignment: .center)
    }
}
