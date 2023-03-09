//
//  LogInView.swift
//  SampleTinderApp
//
//  Created by 中川賢亮 on 2022/06/19.
//

import SwiftUI

struct LogInView: View {

    @State var email = ""
    @State var password = ""

    @Environment(\.presentationMode) var presentation

    var body: some View {
        ZStack {

            LinearGradient(gradient: Gradient(colors: [Color.pink, Color.yellow]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 25) {

                Text("LOGIN")
                    .font(.system(size: 80, weight: .heavy))
                    .foregroundColor(.white)

                TextField("email", text: $email)
                    .asSignInTextField()

                TextField("password", text: $password)
                    .asSignInTextField()

                Button(action: {

                }) {
                    Text("ログイン")
                        .foregroundColor(.white)
                }
                .frame(width: 200, height: 50)
                .background(Color.pink)
                .cornerRadius(10)

                Button(action: {
                    self.presentation.wrappedValue.dismiss()
                }) {
                    Text("アカウントをお持ちでない方はコチラ")
                        .font(.callout)

                }
            }
            .padding(.horizontal, 50)
        }
        .navigationBarHidden(true)
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
