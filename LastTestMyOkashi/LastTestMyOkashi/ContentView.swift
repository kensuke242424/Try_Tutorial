//
//  ContentView.swift
//  LastTestMyOkashi
//
//  Created by 中川賢亮 on 2022/09/09.
//

import SwiftUI

struct ContentView: View {
    @StateObject var okashiDataList = OkashiData()
    // 入力された文字列を保持する状態変数
    @State var inputText = ""
    @State var showSafari = false
    var body: some View {
        VStack {
            TextField("キーワード",
                      text: $inputText,
                      prompt: Text("キーワードを入力してください"))
            .onSubmit {
                okashiDataList.searchOkashi(keyword: inputText)
            }
            .submitLabel(.search)
            .padding()
            // リスト表示する
            List(okashiDataList.okashiList) { okashi in
                // 1つ1つの要素を取り出す
                // ボタンを用意する
                Button {

                    okashiDataList.okashiLink = okashi.link

                    showSafari.toggle()
                } label: {
                    // Listの表示内容を生成する
                    // 水平にレイアウト（横方向にレイアウト）
                    HStack {
                        // 画像を読み込み、表示する
                        AsyncImage(url: okashi.image) { image in
                            // 画像を表示する
                            image
                            // リサイズする
                                .resizable()
                            // アスペクト比（縦横比）を維持してエリア内に収まるようにする
                                .scaledToFit()
                            // 高さ40
                                .frame(height: 40)
                        } placeholder: {
                            // 読み込み中はインジケーターを表示する
                            ProgressView()
                        }
                        // テキスト表示する
                        Text(okashi.name)
                    } // HStackここまで
                }

            } // Listここまで
            .sheet(isPresented: $showSafari, content: {
                SafariView(url: okashiDataList.okashiLink!)
                    .ignoresSafeArea(edges: [.bottom])
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
