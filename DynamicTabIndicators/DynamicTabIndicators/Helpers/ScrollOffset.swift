//
//  ScrollOffset.swift
//  DynamicTabIndicators
//
//  Created by Kensuke Nakagawa on 2023/03/09.
//

import SwiftUI

extension View {
    @ViewBuilder
    func offsetX(complation: @escaping (CGRect) -> ()) -> some View {
        self
            .overlay {
                GeometryReader { proxy  in
                    let rect = proxy.frame(in: .global)
                    
                    Color.clear
                        /// Sets a value for the given preference. 与えられたプリファレンスに値を設定する。
                        /// 型オブジェクトを参照するには、.selfをつける
                        .preference(key: OffsetKey.self, value: rect)
                        /// 指定されたプリファレンスキーの値が変化したときに実行するアクションを追加する。
                        .onPreferenceChange(OffsetKey.self, perform: complation)
                        
                }
            }
    }
}

struct OffsetKey: PreferenceKey {
    /// CGRectZro -> 位置が (0,0) で、幅と高さが 0 の矩形定数。
    static var defaultValue: CGRect = CGRectZero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
