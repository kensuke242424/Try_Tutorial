//
//  ShowCaseHelper.swift
//  ShowcaseViewSample
//
//  Created by Kensuke Nakagawa on 2023/05/31.
//

import SwiftUI

/// Custom Show Case View Extensions
extension View{
    @ViewBuilder
    func showCase(order: Int, title: String, cornerRadius: CGFloat, style: RoundedCornerStyle = .continuous, scale: CGFloat = 1) -> some View {
        self
            .anchorPreference(key: HighlightAnchorKey.self, value: .bounds) { anchor in
                let highlight = Highlight(anchor: anchor, title: title, cornerRadius: cornerRadius, style: style, scale: scale)
                return [order: highlight]
            }
    }
}

/// ShowCase Root View Modifier
struct ShowCaseRoot: ViewModifier {
    var showHighlights: Bool
    var onFinished: () -> ()

    @State private var highlightOrder: [Int] = []
    @State private var currentHighlight: Int = 0
    @State private var showView: Bool = true
    /// Provider
    @State private var showTitle: Bool = false
    /// Namespase ID, for smooth Shape Transitions
    /// スムーズな形状遷移のため
    @Namespace private var animation
    func body(content: Content) -> some View {
        content
            .onPreferenceChange(HighlightAnchorKey.self) { value in
                highlightOrder = Array(value.keys).sorted()
            }

            /// 指定されたプリファレンス値をビューから読み取り、それを使用して、
            /// 元のビューにオーバーレイとして適用される第2のビューを生成
            .overlayPreferenceValue(HighlightAnchorKey.self) { preferences in
                if highlightOrder.indices.contains(currentHighlight), showHighlights, showView {
                    if let highlight = preferences[highlightOrder[currentHighlight]] {
                        HighlightView(highlight)
                    }
                }
            }
    }

    @ViewBuilder
    func HighlightView(_ highlight: Highlight) -> some View {
        /// Geometry Reader for Extracting Highlight Frame Rects
        /// ハイライトフレーム矩形抽出のためのジオメトリリーダー
        GeometryReader { proxy in
            let highlightRect = proxy[highlight.anchor]
            let safeArea = proxy.safeAreaInsets

            Rectangle()
                .fill(.black.opacity(0.5))
                .reverseMask {
                    Rectangle()
                        .matchedGeometryEffect(id: "HIGHLIGHTSHAPE", in: animation)
                        /// Adding Border
                        /// Simply Extend it's Size
                        .frame(width: highlightRect.width + 5, height: highlightRect.height + 5)
                        .clipShape(RoundedRectangle(cornerRadius: highlight.cornerRadius, style: highlight.style))
                        .scaleEffect(highlight.scale)
                        .offset(x: highlightRect.minX - 2.5, y: highlightRect.minY + safeArea.top - 2.5)
                }
                .ignoresSafeArea()
                .onTapGesture {
                    if currentHighlight >= highlightOrder.count - 1 {
                        /// Hiding the Highlight View, because it's the Last Highlight
                        /// 最後のハイライトだから、ハイライト表示を非表示にする
                        withAnimation(.easeInOut(duration: 0.25)) {
                            showView = false
                        }
                    } else {
                        /// Moving to next Highlight
                        /// 次のHighlightへ移動する
                        withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.7, blendDuration: 0.7)) {
                            showTitle = false
                            currentHighlight += 1
                        }
                        onFinished()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            showTitle = true
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        showTitle = true
                    }
                }

            Rectangle()
                .foregroundColor(.clear)
                /// Adding Border
                /// Simply Extend it's Size
                .frame(width: highlightRect.width + 20, height: highlightRect.height + 20)
                .clipShape(RoundedRectangle(cornerRadius: highlight.cornerRadius, style: highlight.style))
                .popover(isPresented: $showTitle) {
                    Text(highlight.title)
                        .padding(.horizontal, 10)
                        /// iOS 16.4+ Modifier
                        .presentationCompactAdaptation(.popover)
                        /// ポップオーバーやシートのインタラクティブな解除を条件付きで防止する
                        .interactiveDismissDisabled()
                }
                .scaleEffect(highlight.scale)
                .offset(x: highlightRect.minX - 10, y: highlightRect.minY - 10)

        }
    }
}

/// Custom View Modifier for Inner/Reverse Mask
/// インナー/リバースマスク用カスタムビューモディファイア
extension View {
    @ViewBuilder
    func reverseMask<Content: View>(alignment: Alignment = .topLeading, @ViewBuilder content: @escaping () -> Content) -> some View {
        self
            .mask {
                Rectangle()
                    .overlay(alignment: .topLeading) {
                        content()
                            .blendMode(.destinationOut)
                    }
            }
    }
}

/// AnchorKey
fileprivate struct HighlightAnchorKey: PreferenceKey {
    static var defaultValue: [Int: Highlight] = [:]

    static func reduce(value: inout [Int: Highlight], nextValue: () -> [Int: Highlight]) {
        value.merge(nextValue()) { $1 }
    }
}

struct ShowCaseHelper_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
