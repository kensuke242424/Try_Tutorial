//
//  Tab.swift
//  DynamicTabIndicators
//
//  Created by Kensuke Nakagawa on 2023/03/09.
//

import SwiftUI

/// Tab Model with sample tabs
struct Tab: Identifiable, Hashable {
    var id: UUID = .init()
    var title: String
    /// Tab Animation Propertys
    var width: CGFloat = 0
    var minX: CGFloat = 0
}

/// Title is same as the Asset Image Name
var tabs_: [Tab] = [

    .init(title: "silhouette"),
    .init(title: "grand"),
    .init(title: "man"),
    .init(title: "women"),
]
