//
//  ContentView.swift
//  LastTestMyMap
//
//  Created by 中川賢亮 on 2022/09/09.
//

import SwiftUI

struct ContentView: View {

    @State var inputText = ""
    @State var displaySearchKey = ""
    @State var displayMapType: MapType = .standard

    var body: some View {
        // 垂直にレイアウト（縦方向にレイアウト）
        VStack {
            TextField("キーワード", text: $inputText, prompt: Text("キーワードを入力してください"))
                .onSubmit {
                    displaySearchKey = inputText
                }
                .padding()

            ZStack(alignment: .bottomTrailing) {
                // マップを表示
                MapView(searchKey: displaySearchKey, mapType: displayMapType)

                Button {
                    // 標準　→ 衛星写真 → 衛星写真+交通機関ラベル
                    if displayMapType == .standard {
                        displayMapType = .satellite
                    } else if displayMapType == .satellite {
                        displayMapType = .hybrid
                    } else {
                        displayMapType = .standard
                    }
                } label: {
                    Image(systemName: "map")
                        .resizable()
                        .frame(width: 35.0, height: 35.0)
                }
                .padding(.trailing, 20.0)
                .padding(.bottom, 30.0)

            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
