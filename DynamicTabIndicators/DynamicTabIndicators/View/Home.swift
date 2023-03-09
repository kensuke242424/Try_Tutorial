//
//  home.swift
//  DynamicTabIndicators
//
//  Created by Kensuke Nakagawa on 2023/03/09.
//

import SwiftUI

struct Home: View {
    
    /// View Propertys
    @State private var currentTab: Tab = tabs_[0]
    @State private var tabs: [Tab] = tabs_
    @State private var contentOffset: CGFloat = 0
    @State private var indicatorPosition: CGFloat = 0
    @State private var indicatorWidth: CGFloat = 0
    
    var body: some View {
        TabView(selection: $currentTab) {
            ForEach(tabs) { tab in
                GeometryReader {
                    // Geomety下でのサイズをとる
                    // 「$0」はGeometyでラップされた各要素を指す
                    let size = $0.size
                    
                    Image(tab.title)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                }
                .clipped()
                .ignoresSafeArea()
                .offsetX { rect in
                    if currentTab == tab {
                        contentOffset = rect.minX - (rect.width * CGFloat(index(of: tab)))
                    }
                    
                    updateTabFrame(rect.width)
                }
                // tagの引数はHashableプロトコルに準拠した任意の値を入れられる
                .tag(tab)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .ignoresSafeArea()
        .overlay(alignment: .top) {
            
            TabsView()
        }
        .overlay {
            Text("\(contentOffset)")
        }
        .preferredColorScheme(.dark) // ✅✅
    }
    
    /// Culculating Tab Width & Position
    func updateTabFrame(_ tabViewWidth: CGFloat) {
        let inputRange = tabs.indices.compactMap { index -> CGFloat? in
            return CGFloat(index) * tabViewWidth
        }
        
        let outputRangeForWidth = tabs.compactMap { tab -> CGFloat? in
            return tab.width
        }
        
        let outputRangeForPosition = tabs.compactMap { tab -> CGFloat? in
            return tab.minX
        }
        
        let widthInterpolation = LinearInterpolation(inputRange: inputRange, outputRange: outputRangeForWidth)
        
        let positionInterpolation = LinearInterpolation(inputRange: inputRange, outputRange: outputRangeForPosition)
        
        indicatorWidth = widthInterpolation.culculate(for: -contentOffset)
        indicatorPosition = positionInterpolation.culculate(for: -contentOffset)
    }
    
    // TabView内のTab要素一つ分のfirstIndexを返すメソッド
    func index(of tab: Tab) -> Int {
        return tabs.firstIndex(of: tab) ?? 0
    }
    
    @ViewBuilder
    func TabsView() -> some View {
        HStack(spacing: 0) {
            ForEach($tabs) { $tab in
                Text(tab.title)
                    .fontWeight(.semibold)
                /// Saving Tab's minX and Width for Culuculation Purposes
                /// タブのminXとWidthをカルチャリング用に保存する。
                    .offsetX { rect in
                        tab.minX = rect.minX
                        tab.width = rect.width
                    }
                
                // 要素がtabsの最後じゃなかった場合にSpacerが入る
                // つまりこの実装だと、両端以外の箇所にSpacerが入る
                // minLengthはSpacerが最低限取る領域のこと
                if tabs.last != tab {
                    Spacer(minLength: 0)
                }
            }
        }
        .padding([.top, .horizontal], 15)
        .overlay(alignment: .bottomLeading) {
            Rectangle()
                .frame(width: indicatorWidth, height : 4)
                .offset(x: indicatorPosition, y: 10)
            
        }
        .foregroundColor(.white)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
