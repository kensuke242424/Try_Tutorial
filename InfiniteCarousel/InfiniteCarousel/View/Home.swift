//
//  Home.swift
//  InfiniteCarousel
//
//  Created by Kensuke Nakagawa on 2023/04/07.
//

import SwiftUI

struct Home: View {
    @State private var currentPage: String = ""
    @State private var listOfPages: [Page] = []
    @State private var fakedPages: [Page] = []
    var body: some View {
        GeometryReader {
            let size = $0.size
            TabView(selection: $currentPage, content: {
                ForEach(fakedPages) { Page in
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(Page.color.gradient)
                        .frame(width: 300, height: size.height)
                        .tag(Page.id.uuidString)
                        /// Calculating Entire Page Scroll Offset -ページ全体のスクロールオフセットを計算する-
                        .offsetX(currentPage == Page.id.uuidString) { rect in
                            let minX = rect.minX
                            let pageOffset = minX - (size.width *
                                                     CGFloat(fakeIndex(Page)))
                            /// Converting Page Offset into Progress
                            let pageProgress = pageOffset / size.width
                            print(-pageProgress)
                            /// Infinite Carousel Logic
                            if -pageProgress < 1.0 {
                                /// Moving the Last Page
                                /// Which is Actually the First Duplicated Page
                                /// 実はどっちが最初の重複ページなのか
                                if fakedPages.indices.contains(fakedPages.count - 1) {
                                    currentPage = fakedPages[fakedPages.count - 1].id.uuidString
                                }
                            }
                            if -pageProgress > CGFloat(fakedPages.count - 1) {
                                /// Moving the First Page
                                /// Which is Actually the Last Duplicated Page
                                if fakedPages.indices.contains(1) {
                                    currentPage = fakedPages[1].id.uuidString
                                }
                            }
                        }
                }
            })
            .tabViewStyle(.page(indexDisplayMode: .never))
            .overlay(alignment: .bottom, content: {
                PageControl(totalPages: listOfPages.count,
                            currentPage: originalIndex(currentPage))
                .offset(y: -15)
            })
        }
        // Geometryのheight
        .frame(height: 400)
        .onAppear {
            guard fakedPages.isEmpty else { return }
            for color in [Color.red, Color.blue, Color.yellow, Color.black, Color.brown] {
                listOfPages.append(.init(color: color))
            }
            
            fakedPages.append(contentsOf: listOfPages)
            
            // fakedPagesの最前にlistOfPagesの最後のカード・fakedPagesの最後にlistOfPages最初のカードを追加
            if var firstPage = listOfPages.first, var lastPage = listOfPages.last {
                currentPage = firstPage.id.uuidString
                // idをアップデート
                print("idアップデート")
                firstPage.id = .init()
                lastPage.id = .init()
                
                fakedPages.append(firstPage)
                fakedPages.insert(lastPage, at: 0)
            }
        }
    }
    
    func fakeIndex(_ of: Page) -> Int {
        return fakedPages.firstIndex(of: of) ?? 0
    }
    
    func originalIndex(_ id: String) -> Int {
        return listOfPages.firstIndex { page in
            page.id.uuidString == id
        } ?? 0
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
