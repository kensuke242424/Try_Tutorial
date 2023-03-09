//
//  LazyGridView.swift
//  LagyGridSample
//
//  Created by 中川賢亮 on 2022/06/20.
//

import SwiftUI

struct LazyVGridView: View {

    // GridItemを作成
    private var vGridItem: [GridItem] = [GridItem(.adaptive(minimum: 70), spacing: 5)]

    var body: some View {

        NavigationView {
            ScrollView {

                // アイテムをLazyGridで囲む 引数にGridItemを指定
                LazyVGrid(columns: vGridItem, alignment: .center, spacing: 10) {

                    // 指定の数分アイテムを生成
                    ForEach(1...9, id: \.self) { id in

                        VStack {

                            // アイテムのデザインを定義
                            Image(systemName: "folder")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)

                            Text("\(id)")
                                .font(.body)

                        }
                        .padding()
                        .background(.yellow)

                    } // ForEach
                } // LazaVGrid
            } // ScrollView
            .navigationTitle("LazyVGridView")
        }// NavigationView


    } // body
} // View

struct LazyVGridView_Previews: PreviewProvider {
    static var previews: some View {
        LazyVGridView()
    }
}
