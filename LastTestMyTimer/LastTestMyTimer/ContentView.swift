//
//  ContentView.swift
//  LastTestMyTimer
//
//  Created by 中川賢亮 on 2022/09/09.
//

import SwiftUI

struct ContentView: View {
    // タイマーの変数を作成
    @State var timerHandler: Timer?
    // カウント(経過時間)の変数を作成
    @State var count = 0
    // 永続化する秒数設定（初期値は10）
    @AppStorage("timer_value") var timerValue = 10

    @State var showAlert = false

    var body: some View {
        NavigationStack {
            ZStack {
                // 背景画像
                Image("backgroundTimer")
                // リサイズする
                    .resizable()
                // セーフエリアを超えて画面全体に配置します
                    .ignoresSafeArea()
                // アスペクト比（縦横比）を維持して短辺基準に収まるようにする
                    .scaledToFill()
                // View（部品）間の間隔を30にする
                VStack(spacing: 30.0) {
                    // テキストを表示する
                    Text("残り\(timerValue - count)秒")
                    // 文字のサイズを指定
                        .font(.largeTitle)
                    // 水平にレイアウト(横方向にレイアウト)
                    HStack {
                        Button {
                            // ボタンをタップしたときのアクション
                            startTimer()
                        } label: {
                            Text("スタート")
                            // 文字サイズを指定
                                .font(.title)
                            // 文字色を白に指定
                                .foregroundColor(Color.white)
                            // 幅高さを140に指定
                                .frame(width: 140, height: 140)
                            // 背景を設定
                                .background(Color("startColor"))
                            // 円形に切り抜く
                                .clipShape(Circle())
                        } // スタートボタンはここまで
                        Button {
                            // ボタンをタップしたときのアクション
                            // timerHandlerをアンラップしてunwrapedTimerHandlerに代入
                            if let unwrapedTimerHandler = timerHandler {
                                // もしタイマーが、実行中だったら停止
                                if unwrapedTimerHandler.isValid == true {
                                    // タイマー停止
                                    unwrapedTimerHandler.invalidate()
                                }
                            }
                        } label: {
                            Text("ストップ")
                            // 文字サイズを指定
                                .font(.title)
                            // 文字色を白に指定
                                .foregroundColor(Color.white)
                            // 幅高さを140に指定
                                .frame(width: 140, height: 140)
                            // 背景を設定
                                .background(Color("stopColor"))
                            // 円形に切り抜く
                                .clipShape(Circle())
                        } // スタートボタンはここまで
                    } // HStack ここまで
                } // VStack ここまで
            } // ZStack ここまで
            .onAppear {
                count = 0
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingView()) {
                        Text("秒数設定")
                    }
                }
            }

            // 状態変数showAlertがtrueになったときに実行される
            .alert("終了", isPresented: $showAlert) {
                Button("OK") {
                // OKをタップしたときにここが実行される
                print("OKタップされました")
                }
            } message: {
            Text("タイマー終了時間です")
            } // .alert ここまで
        }
    } // body
    func countDownTimer() {
        // count(経過時間)に+1していく
        count += 1
        // 残り時間が0以下のとき、タイマーを止める
        if timerValue - count <= 0 {
            // タイマー停止
            timerHandler?.invalidate()

            showAlert = true
        }
    }

    func startTimer() {
        // timerHandlerをアンラップしてunwrapedTimerHandlerに代入
        if let unwrapedTimerHandler = timerHandler {
            // もしタイマーが、実行中だったらスタートしない
            if unwrapedTimerHandler.isValid == true {
                // 何も処理しない
                return
            }
        }

        // 残り時間が0以下のとき、count(経過時間)を0に初期化する
        if timerValue - count <= 0 {
            // count(経過時間)を0に初期化する
            count = 0
        }
        // タイマーをスタート
        timerHandler = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            // タイマー実行時に呼び出される
            // 1秒毎に実行されてカウントダウンする関数を実行する
            countDownTimer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
