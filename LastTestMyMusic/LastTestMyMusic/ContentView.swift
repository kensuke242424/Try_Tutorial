//
//  ContentView.swift
//  LastTestMyMusic
//
//  Created by 中川賢亮 on 2022/09/09.
//

import SwiftUI

struct ContentView: View {

    let soundPlayer = SoundPlayer()

    var body: some View {
        ZStack {
            // 背景画像を指定する
            Image("background")
            // リサイズする
            .resizable()
            // 「画面いっぱいになるようにセーフエリア外まで表示されるように指定」
            .ignoresSafeArea()
            // アスペクト比（縦横比）を維持して短辺基準に収まるようにする
            .scaledToFill()

            // 水平にレイアウト(横方向にレイアウト)
            HStack {
                // シンバルボタン
                Button {
                // ボタンをタップしたときのアクション
                    // シンバルの音を鳴らす
                    soundPlayer.cymbalPlay()
                } label: {
                // 画像を表示する
                Image("cymbal")
                } // シンバルボタン ここまで
                // シンバルボタン
                Button {
                // ボタンをタップしたときのアクション
                } label: {
                // 画像を表示する
                Image("guitar")
                } // シンバルボタン ここまで
            } // HStack ここまで
        } // ZStack ここまで
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
