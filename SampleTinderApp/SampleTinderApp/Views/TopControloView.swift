//
//  TopControloView.swift
//  SampleTinderApp
//
//  Created by 中川賢亮 on 2022/06/13.
//

import SwiftUI

struct TopControloView: View {

    enum SelectedItem {
        case tinder,good,comment,profile
    }

    // 画面の横幅をiPhoneのフレームラインに合わせる
    private var frameWidth: CGFloat {UIScreen.main.bounds.width}

    @State var selectedItem: SelectedItem = .good

    var body: some View {

        // 上部ボタン ここから
        HStack() {

            Button (action: {
                selectedItem = .profile
            }) {
                Image(systemName: "person.fill")
                // カスタムモディファイア
                    .asTopControlButtonImage()
                    .foregroundColor(selectedItem == .profile ? .pink : .gray)
            }

            Spacer()

            ZStack {
                // 楕円形枠ボタン
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.white)
                // 縦と横の値をそれぞれ別の値で指定できるように
                    .frame(width: 50, height: 40)
                    .shadow(radius: 10)

                Button (action: {
                    selectedItem = .good
                }) {
                    Image(systemName: "flame.fill")
                    // カスタムモディファイア
                        .asTopControlButtonImage()
                        .foregroundColor(selectedItem == .good ? .red : .gray)
                }
            } // ZStack

            ZStack {
                // 楕円形枠ボタン
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.white)
                // 縦と横の値をそれぞれ別の値で指定できるように
                    .frame(width: 50, height: 40)
                    .shadow(radius: 10)

                Button (action: {
                    selectedItem = .tinder
                }) {
                    Image(systemName: "leaf.fill")
                    // カスタムモディファイア
                        .asTopControlButtonImage()
                        .foregroundColor(selectedItem == .tinder ? .green : .gray)

                }
            } // ZStack

            Spacer()

            Button (action: {
                selectedItem = .comment
            }) {
                // Image(systemName: "<シンボル名>") ← これでSFSymbolのアイコンが呼び出せます
                Image(systemName: "message.fill")
                // カスタムモディファイア
                    .asTopControlButtonImage()
                    .foregroundColor(selectedItem == .comment ? .yellow : .gray)
            }

        }// HStack
        .padding()
        .frame(width: frameWidth, height: 50)

        // 上部ボタンここまで
    }
}


