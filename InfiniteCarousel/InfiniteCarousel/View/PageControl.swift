//
//  PageControl.swift
//  InfiniteCarousel
//
//  Created by Kensuke Nakagawa on 2023/04/07.
//

import SwiftUI

struct PageControl: UIViewRepresentable {
    var totalPages: Int
    var currentPage: Int
    
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = totalPages
        control.currentPage = currentPage
        control.backgroundStyle = .prominent
        // ページコントロールが連続的なインタラクションを許可するかどうかを決定するブール値です。
        control.allowsContinuousInteraction = false
        
        return control
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.numberOfPages = totalPages
        uiView.currentPage = currentPage
    }
}

