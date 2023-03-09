//
//  Home.swift
//  CustomTFKeyboardSampleApp
//
//  Created by Kensuke Nakagawa on 2023/03/04.
//

import SwiftUI

struct Home: View {
    @State private var inputText: String = ""
    @FocusState var showKeyboard: Bool
    var body: some View {
        VStack {
            
            Rectangle()
                .fill(.blue.gradient)
                .frame(width: 100, height: 100)
                // style: continuous → 図形をベクターからラスタライズ(ピクセル化)している
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .overlay {
                    Image(systemName: "cube.transparent")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white)
                }
            
            TextField("¥ 1500", text: $inputText)
                .inputView(content: {
                    CustomKeyboardView()
                })
                .focused($showKeyboard)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .environment(\.colorScheme, .dark)
                .padding([.horizontal, .top], 30)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Rectangle()
                .fill(Color("customBlackGray").gradient)
                .ignoresSafeArea()
        }
    }
    
    /// Custom Keyboard
    @ViewBuilder
    func CustomKeyboardView() -> some View {
        LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 10), count: 3), spacing: 10) {
            ForEach(1...9, id: \.self) { index in
                keyboardButtonView(.text("\(index)")) {
                    /// adding text
                    /// adding doller front
                    if inputText.isEmpty {
                        inputText.append("¥ ")
                    }
                    inputText.append("\(index)")
                }
            }
            
            /// Othe Button's With Zero in Center
            keyboardButtonView(.image("delete.backward")) {
                if !inputText.isEmpty {
                    inputText.removeLast()
                    if inputText == "¥ " {
                        inputText = ""
                    }
                }
            }
            
            keyboardButtonView(.text("0")) {
                inputText.append("0")
            }
            
            keyboardButtonView(.image("checkmark.circle.fill")) {
                showKeyboard = false
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 5)
        .background {
            Rectangle()
                .fill(Color("customBlackGray").gradient)
                .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    func keyboardButtonView(_ value: KeyboardValue, onTap: @escaping () -> ()) -> some View {
        Button(action: onTap) {
            ZStack {
                switch value {
                case .text(let string):
                    Text(string)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                case .image(let image):
                    Image(systemName: image)
                        .font(image == "checkmark.circle.fill" ? .title : .title2)
                        .fontWeight(.semibold)
                        .foregroundColor(image == "checkmark.circle.fill" ? .green : .white)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 15)
            .contentShape(Rectangle())
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

/// Enum Keyboard Value
enum KeyboardValue {
    case text(String)
    case image(String)
}
