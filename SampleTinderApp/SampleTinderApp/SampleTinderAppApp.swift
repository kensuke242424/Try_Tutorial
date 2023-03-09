//
//  SampleTinderAppApp.swift
//  SampleTinderApp
//
//  Created by 中川賢亮 on 2022/06/09.
//

import SwiftUI

@main
struct SampleTinderAppApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(CardViewModel())
        }
    }
}
