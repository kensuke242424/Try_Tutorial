//
//  OffsetReader.swift
//  InfiniteCarousel
//
//  Created by Kensuke Nakagawa on 2023/04/07.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    // inout -> 関数に渡された引数の値を変更することができる(状態変数など)
    // ⬇︎の場合、関数内で新しく生まれたnextValueをvalueに代入することで、引数側の値を更新している
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

extension View {
    @ViewBuilder
    func offsetX(_ addObserver: Bool, complation: @escaping (CGRect) -> ()) -> some View {
        self
            .frame(maxWidth: .infinity)
            .overlay {
                // Observer -> 観察者
                if addObserver {
                    GeometryReader {
                        let rect = $0.frame(in: .global)
                        
                        Color.clear
                            .preference(key: OffsetKey.self, value: rect)
                            .onPreferenceChange(OffsetKey.self, perform: complation)
                    }
                }
            }
    }
}
