//
//  CustomTFKeyboard.swift
//  CustomTFKeyboardSampleApp
//
//  Created by Kensuke Nakagawa on 2023/03/04.
//

import SwiftUI

/// Custom TextField Keyboard textField Modifier
extension TextField {
    @ViewBuilder
    func inputView<Content: View>(@ViewBuilder content: @escaping () -> Content) -> some View {
        self
            .background {
                SetTFKeyboard(keyboardContent: content())
            }
    }
}

fileprivate struct SetTFKeyboard<Content: View>: UIViewRepresentable {
    var keyboardContent: Content
    @State private var hostingController: UIHostingController<Content>?
    func makeUIView(context: Context) -> UIView {
        return UIView()
    }
    func updateUIView(_ uiView: UIView, context: Context) {
        // superview -> UIViewのプロパティの一つ。そのビューが含まれる"上位(親)のビュー"を表す
        // 引数から受け取ったUIViewの親の親を取得している？ superview?.superview
        DispatchQueue.main.async {
            if let textFieldContainerView = uiView.superview?.superview {
                if let textField = textFieldContainerView.findTextField {
                    /// If the input is already set, then updating it's content↓
                    /// 入力がすでに設定されている場合、その内容を更新する
                    if textField.inputView == nil {
                        /// UIHostingController -> SwiftUIのビュー階層を管理するUIKit ビューコントローラー
                        hostingController = UIHostingController(rootView: keyboardContent)
                        hostingController?.view.frame = .init(origin: .zero, size: hostingController?.view.intrinsicContentSize ?? .zero)
                        /// Setting TF's input view as our SwiftUI View
                        textField.inputView = hostingController?.view
                    } else {
                        /// Updating Hosting Content
                        hostingController?.rootView = keyboardContent
                    }
                    
                    
                }
            }else {
                print("Failed to Find TF")
            }
        }
    }
}

struct CustomTFKeyboard_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

///  Extracting TextField From the Subviews
///  サブビューからTextFieldを抽出する
fileprivate extension UIView {
    var allSubViews: [UIView] {
        return subviews.flatMap { [$0] + $0.subviews }
    }
    
    /// Finiding the UIView is TextField or not
    /// UIViewがTextFieldかどうかの判定
    var findTextField: UITextField? {
        if let textField = allSubViews.first(where: { view in
            view is UITextField
        }) as? UITextField {
            return textField
        }
        return nil
    }
    
}
