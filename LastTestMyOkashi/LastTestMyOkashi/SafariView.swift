//
//  SafariView.swift
//  LastTestMyOkashi
//
//  Created by 中川賢亮 on 2022/09/09.
//

import SwiftUI
import SafariServices

// SFSafariViewControllerを起動する構造体
struct SafariView: UIViewControllerRepresentable {

    // 表示するホームページのURLを受ける変数
    var url: URL
    // 表示するViewを生成するときに実行
    func makeUIViewController(context: Context) -> SFSafariViewController {
        // Safariを起動
        return SFSafariViewController(url: url)
    }

    // Viewが更新されたときに実行
    func updateUIViewController(_ uiViewController: SFSafariViewController,
    context: Context) {
    // 処置なし
    }
}
