//
//  LinerInterPolation.swift
//  DynamicTabIndicators
//
//  Created by Kensuke Nakagawa on 2023/03/09.
//

import SwiftUI

/// ASimple class that will be useful to do linear interpolation caluculations for our Dynamic Tab Animation
/// 動的タブアニメーションの線形補間計算を行うのに役立つシンプルなクラスです。

class LinearInterpolation {
    private var length: Int // 長さ
    private var inputRange: [CGFloat]
    private var outputRange: [CGFloat]
    
    init(inputRange: [CGFloat], outputRange: [CGFloat]) {
        // Safe Check
        assert(inputRange.count == outputRange.count)
        self.length = inputRange.count - 1
        self.inputRange = inputRange
        self.outputRange = outputRange
    }
    
    func culculate(for x: CGFloat) -> CGFloat {
        if x <= inputRange[0] { return outputRange[0] }
        
        for index in 1...length {
            let x1 = inputRange[index - 1]
            let x2 = inputRange[index]
            
            let y1 = outputRange[index - 1]
            let y2 = outputRange[index]
            
            if x <= inputRange[index] {
                let y = y1 + ((y2 - y1) / (x2 - x1)) * (x - x1)
                return y
            }
        }
        
        return outputRange[length]
    }
}
