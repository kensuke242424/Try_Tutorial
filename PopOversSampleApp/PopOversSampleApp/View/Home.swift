//
//  Home.swift
//  PopOversSampleApp
//
//  Created by Kensuke Nakagawa on 2023/03/06.
//
/// Popovers on ios are shown as sheets by default;
/// They are only available for macOS and iPadOS, but there is a way to show them, which will be demonstrated in this vidio.
/// iosのポップオーバーは、デフォルトでシートとして表示されます。
/// macOSとiPadOSでのみ利用可能ですが、表示させる方法があり、このビデオで実演される予定です。

import SwiftUI

struct Home: View {
    @State private var showPopover: Bool = false
    @State private var updateText: Bool = false
    var body: some View {
        Button("Show Popover") {
            showPopover.toggle()
        }
        .iOSPopover(isPresented: $showPopover, arrowDirecion: .down) {
            VStack {
            Text("Hello, it's me, \(updateText ? "Updated Popover" : "Popover")")
                
                Button("Update Text") {
                    updateText.toggle()
                }
                Button("Close Popover") {
                    showPopover.toggle()
                }
            }
            .padding(25)
            .foregroundColor(.white)
            .background {
                Rectangle()
                    .fill(.blue.gradient)
                    .padding(-20)
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

extension View {
    @ViewBuilder
    // UIPopoverArrowDirection ⇨ ポップバーの矢印の方向を指定するための定数
    func iOSPopover<Content: View>(isPresented: Binding<Bool>, arrowDirecion: UIPopoverArrowDirection, @ViewBuilder content: @escaping () -> Content) -> some View {
        self
            .background {
                PopoverController(isPresented: isPresented, arrowDirection: arrowDirecion, content: content())
            }
    }
}

struct PopoverController<Content: View>: UIViewControllerRepresentable {
    
    @Binding var isPresented: Bool
    var arrowDirection: UIPopoverArrowDirection
    var content: Content
    /// - View Properties
    @State private var alreadyPresented: Bool = false
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        controller.view.backgroundColor = .clear
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if alreadyPresented {
            /// - Updating SwiftUI view, when it's Changed.
            /// SwiftUIビューが変更された場合、それを更新する。
            if let hostingController = uiViewController.presentedViewController as? CustomHostingView<Content> {
                /// rootView = このビューコントローラーによって管理されるSwiftUIビュー階層のルートビューです。
                hostingController.rootView = content
                /// Updating View Size when it's Update
                /// アップデート時にビューサイズを更新する
                ///  Or You can define your own size in SwiftUI View
                ///  あるいは、SwiftUIビューで独自のサイズを定義することができます。
                hostingController.preferredContentSize = hostingController.view.intrinsicContentSize
            }
            /// - Close View, if it's toggled Back. 戻るに設定されている場合は、ビューを閉じます。
            if !isPresented {
                uiViewController.dismiss(animated: true) {
                    /// - Closing alreadyPresented State
                    alreadyPresented = false
                }
            }
        } else {
            if isPresented {
                let controller = CustomHostingView(rootView: content)
                controller.view.backgroundColor = .clear
                controller.modalPresentationStyle = .popover
                controller.popoverPresentationController?.permittedArrowDirections = arrowDirection
                
                /// - Connecting Delegate
                controller.presentationController?.delegate = context.coordinator
                /// - We Need to Attach the Source View Source View So that it will show Arrow At Correct Position
                /// ソースビューに矢印が正しい位置に表示されるように、ソースビューを取り付ける必要があります。
                controller.popoverPresentationController?.sourceView = uiViewController.view
                /// - Sinply Presenting Popover Controller
                uiViewController.present(controller, animated: true)
            }
        }
    }
    
    /// - Forcing it to show Popover using PresentationDelegate
    /// PresentationDelegateを使用して強制的にPopoverを表示させる。
    class Coordinator: NSObject, UIPopoverPresentationControllerDelegate {
        var parent: PopoverController
        init(parent: PopoverController) {
            self.parent = parent
        }
        
        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            return .none
        }
        
        /// - Observing The status of the Popover
        /// Observing The status of the Popover
        /// - When it's dismissed updating the isPresented State
        /// 解散時にisPresented Stateの更新を行う。
        func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
            parent.isPresented = false
        }
        
        /// When the popover is presented, updating the already Plesented State
        /// ポップオーバーが表示されたら、既にPlesentedな状態を更新する。
        func presentationController(_ presentationController: UIPresentationController, willPresentWithAdaptiveStyle style: UIModalPresentationStyle, transitionCoordinator: UIViewControllerTransitionCoordinator?) {
            DispatchQueue.main.async {
                self.parent.alreadyPresented = true
            }
        }
    }
}

/// - Custom Hosting Controller for Wrapping to to SwiftUI View Size
/// SwiftUI View Sizeにラップするためのカスタムホスティングコントローラー
///
class CustomHostingView<Content: View>: UIHostingController<Content> {
    // override ⇨ スーパー(親)クラスのメソッドを上書きする
    // viewDidload ⇨ Swiftのライフサイクルの一つ。Viewが生成される際に「一度だけ」実行する
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// preferredContentSize ⬇︎ このプロパティの値は、主にビューコントローラのコンテンツをポップオーバーで表示する際に使用されるが、その他の状況でも使用されることがある。ビューコントローラをポップオーバーで表示しているときにこのプロパティの値を変更すると、サイズの変更がアニメーションで行われます。ただし、幅または高さを0.0に指定した場合は、変更はアニメーションで行われません。
        ///
        /// view.intrinsicContentSize
        /// 渡されたviewの動的な値に応じて(テキストの長さや、フォントサイズなど)自分自身が最適なサイズを計算して返す
        preferredContentSize = view.intrinsicContentSize
    }
    
}
