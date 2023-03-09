//
//  ContentView.swift
//  LastTestMyJanken
//
//  Created by 中川賢亮 on 2022/09/09.
//

import SwiftUI

struct ContentView: View {
    @State var answerNumber = 0
    var body: some View {

        VStack {

            Spacer()

            // じゃんけんの数字が0だったら
            if answerNumber == 0 {
            // 初期画面のテキストを表示
            Text("これからじゃんけんをします！")
                    .padding(.bottom)
            } else if answerNumber == 1 {
            // じゃんけんの数字が1だったら、グー画像を指定
                // グー画像を指定
                Image("gu")
                // リサイズを指定
                .resizable()
                // アスペクト比（縦横比）を維持する指定
                .scaledToFit()

                Spacer()

                Text("グー")
                    .padding(.bottom)

            } else if answerNumber == 2 {
            // じゃんけんの数字が2だったら、チョキ画像を指定
                // グー画像を指定
                Image("choki")
                // リサイズを指定
                .resizable()
                // アスペクト比（縦横比）を維持する指定
                .scaledToFit()

                Spacer()

                Text("チョキ")
                    .padding(.bottom)
            } else {
            // じゃんけんの数字が「1」と「2」以外だったら、パー画像を指定
                // グー画像を指定
                Image("pa")
                // リサイズを指定
                .resizable()
                // アスペクト比（縦横比）を維持する指定
                .scaledToFit()

                Spacer()

                Text("パー")
                    .padding(.bottom)
            }

            // ［じゃんけんをする！］ボタン
            Button {

                // 新しいじゃんけんの結果を一時的に格納する変数を設ける
                var newAnswerNumber = 0
                // ランダムに結果を出すが、前回の結果と異なる場合のみ採用
                // repeatは繰り返しを意味する
                repeat {
                // 1,2,3の数値をランダムに算出（乱数）
                newAnswerNumber = Int.random(in: 1...3)
                // 前回と同じ結果のときは、再度ランダムに数値を出す
                // 異なる結果のときは、repeatを抜ける
                } while answerNumber == newAnswerNumber

                answerNumber = newAnswerNumber

            } label: {
            // Buttonに表示する文字を指定
            Text("じゃんけんをする！")
                    .frame(maxWidth: .infinity)
                    .frame(height: 100)
                    .font(.title)
                    .background(Color.pink)
                    .foregroundColor(Color.white)
            } //［じゃんけんをする！］ボタンはここまで
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
