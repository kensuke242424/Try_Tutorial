//
//  ContentView.swift
//  InfiniteCarousel
//
//  Created by Kensuke Nakagawa on 2023/04/07.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Home()
                .navigationTitle("Infinite Carousel")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
