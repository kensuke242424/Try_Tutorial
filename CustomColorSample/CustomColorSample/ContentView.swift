//
//  ContentView.swift
//  CustomColorSample
//
//  Created by 中川賢亮 on 2023/02/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack {
            
            Color.customBackgroundColor
            
            VStack(spacing: 30) {
                Text("Hello, world!")
                    .font(.largeTitle)
                    .foregroundColor(Color.customFontColor) // ⬅︎
                
                Text("Hello, Swift!")
                    .font(.largeTitle)
                    .foregroundColor(Color.customFontColor) // ⬅︎
                
                Text("Hello, CodeCandy!")
                    .font(.largeTitle)
                    .foregroundColor(Color.customFontColor) // ⬅︎
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
