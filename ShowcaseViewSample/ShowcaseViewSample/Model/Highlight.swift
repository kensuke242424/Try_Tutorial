//
//  Highlight.swift
//  ShowcaseViewSample
//
//  Created by Kensuke Nakagawa on 2023/05/31.
//

import SwiftUI

/// Highlight View Properties
struct Highlight: Identifiable, Equatable {
    var id: UUID = .init()
    var anchor: Anchor<CGRect>
    var title: String
    var cornerRadius: CGFloat
    var style: RoundedCornerStyle = .continuous
    var scale: CGFloat = 1
}
