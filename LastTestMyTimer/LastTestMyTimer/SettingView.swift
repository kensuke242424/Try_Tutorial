//
//  SettingView.swift
//  LastTestMyTimer
//
//  Created by 中川賢亮 on 2022/09/09.
//

import SwiftUI

struct SettingView: View {

    @AppStorage("timer_value") var timerValue = 10

    var body: some View {
        ZStack {
            Color("backgroundSetting")
                .ignoresSafeArea()

            VStack {
                Spacer()
                // テキストを表示する
                Text("\(timerValue)秒")
                // 文字サイズを指定
                .font(.largeTitle)

                Spacer()

                Picker(selection: $timerValue) {
                Text("10")
                .tag(10)
                Text("20")
                .tag(20)
                Text("30")
                .tag(30)
                Text("40")
                .tag(40)
                Text("50")
                .tag(50)
                Text("60")
                .tag(60)
                } label: {
                Text("選択")
                }
                // Pickerをホイール表示
                .pickerStyle(.wheel)

                Spacer()
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
