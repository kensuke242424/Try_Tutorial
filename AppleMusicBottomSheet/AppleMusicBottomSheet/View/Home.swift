//
//  Home.swift
//  AppleMusicBottomSheet
//
//  Created by Kensuke Nakagawa on 2023/03/25.
//

import SwiftUI

struct Home: View {
    @State private var expandSheet: Bool = false
    @Namespace private var animation
    var body: some View {
        TabView {
            ListenNow()
            .tabItem {
                Image(systemName: "play.circle.fill")
                Text("Listen Now")
            }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(.ultraThickMaterial, for: .tabBar)
            .toolbar(expandSheet ? .hidden : .visible, for: .tabBar)
            SampleTab("Browse", "square.grid.2x2.fill")
            SampleTab("Radio", "dot.radiowaves.left.and.right")
            SampleTab("Music", "play.square.stack")
            SampleTab("Search", "magnifyingglass")
        }
        .tint(.red)
        .safeAreaInset(edge: .bottom) {
            CustomBottomSheet()
        }
        .overlay {
            if expandSheet {
                ExpandedBottomSheet(expandSheet: $expandSheet, animation: animation)
//                    .transition(.asymmetric(insertion: .identity, removal: offset(y: -5)))
            }
        }

    }
    @ViewBuilder
    func ListenNow() -> some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    Image("cloth_sample1")
                        .resizable()
                        .scaledToFit()
                    
                    Image("cloth_sample2")
                        .resizable()
                        .scaledToFit()
                    
                    Image("cloth_sample3")
                        .resizable()
                        .scaledToFit()
                    
                    Image("cloth_sample4")
                        .resizable()
                        .scaledToFit()
                }
                .padding()
                .padding(.bottom, 100)
            }
            .navigationTitle("Listen Now")
        }
    }
    
    @ViewBuilder
    func CustomBottomSheet() -> some View {
        ZStack {
            if expandSheet {
                Rectangle()
                    .fill(.clear)
            } else {
                Rectangle()
                    .fill(.ultraThickMaterial)
                    .overlay {
                        MusicInfo(expandSheet: $expandSheet, animation: animation)
                    }
                    .matchedGeometryEffect(id: "BGVIEW", in: animation)
            }
        }
        .frame(height: 70)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(.gray.opacity(0.3))
                .frame(height: 1)
                .offset(y: -10)
        }
        /// 49: Default Tab Bar Height
        .offset(y: -49)
    }
    @ViewBuilder
    func SampleTab(_ title: String, _ icon: String) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            Text(title)
                .padding(.top, 25)
        }
        .tabItem {
            Image(systemName: icon)
            Text(title)
        }
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarBackground(.ultraThickMaterial, for: .tabBar)
        .toolbar(expandSheet ? .hidden : .visible, for: .tabBar)
    }
}

struct MusicInfo: View {
    @Binding var expandSheet: Bool
    var animation: Namespace.ID
    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                // アイコンをmatchedGeometryEffectで囲む
                if !expandSheet {
                    GeometryReader {
                        let size = $0.size
                        
                        Image("cloth_sample1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                    } // Geometry
                    .matchedGeometryEffect(id: "ARTWORK", in: animation)
                }
            }
            
            .frame(width: 45, height: 45)
            
            Text("Look What YouMade Me do")
                .fontWeight(.semibold)
                .lineLimit(1)
                .padding(.horizontal, 15)
            
            Spacer(minLength: 0)
            
            Button {
                
            } label: {
                Image(systemName: "pause.fill")
            }
            
            Button {
                
            } label: {
                Image(systemName: "forward.fill")
            }
            .padding(.leading, 25)

        }
        .foregroundColor(.primary)
        .padding(.horizontal)
        .padding(.bottom, 5)
        .frame(height: 70)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.3)) {
                expandSheet = true
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
