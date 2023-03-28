//
//  ExpandedBottomSheet.swift
//  AppleMusicBottomSheet
//
//  Created by Kensuke Nakagawa on 2023/03/25.
//

import SwiftUI

struct ExpandedBottomSheet: View {
    @Binding var expandSheet: Bool
    var animation: Namespace.ID
    @State private var animationContent: Bool = false
    @State private var offsetY: CGFloat = 0
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            
            ZStack {
                RoundedRectangle(cornerRadius: animationContent ? deviceCornerRadius : 0, style: .continuous)
                    .fill(.ultraThickMaterial)
                    .overlay(alignment: .top) {
                        MusicInfo(expandSheet: $expandSheet, animation: animation)
                            .allowsTightening(false)
                            .opacity(animationContent ? 0 : 1)
                    }
                    .overlay(alignment: .top) {
                        RoundedRectangle(cornerRadius: animationContent ? deviceCornerRadius : 0, style: .continuous)
                            .foregroundColor(Color("BG"))
                            .opacity(animationContent ? 1 : 0)
                    }
                    .matchedGeometryEffect(id: "BGVIEW", in: animation)
                
                
                VStack(spacing: 15) {
                    Capsule()
                        .fill(.gray)
                        .frame(width: 40, height: 5)
                        .opacity(animationContent ? 1 : 0)
                        .offset(y: animationContent ? 0 : size.height)
                    
                    GeometryReader {
                        let size = $0.size
                        
                        Image("cloth_sample1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: animationContent ? 15 : 5, style: .continuous))
                    }
                    .matchedGeometryEffect(id: "ARTWORK", in: animation)
                    .frame(height: size.width - 50)
                    /// For Smaller Devices the padding will be 10 and for lerger devices the padding will be 30
                    /// 小型デバイスの場合、パディングは10、大型デバイスの場合、パディングは30になります。
                    .padding(.vertical, size.height < 700 ? 10 : 30)
                    
                    /// Player View
                    PlayerView(size)
                        .offset(y: animationContent ? 0 : size.height)
                }
                .padding(.top, safeArea.top + (safeArea.bottom == 0 ? 10 : 0))
                .padding(.bottom, safeArea.bottom == 0 ? 10 : safeArea.bottom)
                .padding(.horizontal, 25)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .clipped()
            }
            .contentShape(Rectangle())
            .offset(y: offsetY)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        let transitionY = value.translation.height
                        offsetY = (transitionY > 0 ? transitionY : 0)
                    }).onEnded({ value in
                        withAnimation(.easeInOut(duration: 0.35)) {
                            if offsetY > size.height * 0.4 {
                                expandSheet = false
                                animationContent = false
                            } else {
                                offsetY = .zero
                            }

                        }
                    })
            )
            .ignoresSafeArea(.container, edges: .all)
        }
        
        .onAppear {
            withAnimation(.easeInOut(duration: 0.35)) {
                animationContent = true
            }
        }
    }
    @ViewBuilder
    func PlayerView(_ mainSize: CGSize) -> some View {
        GeometryReader {
            let size = $0.size
            /// Dynamic Spacing Using Available Height
            let spacing = size.height * 0.04
            
            /// Sizing it for more Using Available Height
            VStack(spacing: spacing) {
                VStack(spacing: spacing) {
                    HStack(alignment: .center, spacing: 15) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("look What You Made Me do")
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            Text("Taylor Swift")
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Button {
                            
                        }  label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.white)
                                .padding(12)
                                .background {
                                    Circle()
                                        .fill(.ultraThinMaterial)
                                        .environment(\.colorScheme, .light)
                                }
                        }
                    }
                    
                    Capsule()
                        .fill(.ultraThinMaterial)
                        .environment(\.colorScheme, .light)
                        .frame(height: 5)
                        .padding(.top, spacing)
                    
                    HStack {
                        Text("0:00")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Spacer(minLength: 0)
                        
                        Text("3:33")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                /// Moving it to Top
                .frame(height: size.height / 2.5, alignment: .top)
                
                HStack(spacing: size.height * 0.18) {
                    Button {
                        
                    } label: {
                        Image(systemName: "backward.fill")
                            /// Dynamic Sizing for Smaller to Largrt iPhones
                            /// 小さなものから大きなものまで、ダイナミックなサイジングを実現
                            .font(size.height < 300 ? .title3 : .title)
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "pause.fill")
                            /// Dynamic Sizing for Smaller to Largrt iPhones
                            /// 小さなものから大きなものまで、ダイナミックなサイジングを実現
                            .font(size.height < 300 ? .largeTitle : .system(size: 50))
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "forward.fill")
                            /// Dynamic Sizing for Smaller to Largrt iPhones
                            /// 小さなものから大きなものまで、ダイナミックなサイジングを実現
                            .font(size.height < 300 ? .title3 : .title)
                    }
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                
                /// Volume and Other Controls
                VStack(spacing: spacing) {
                    HStack(spacing: 15) {
                        Image(systemName: "speaker.fill")
                            .foregroundColor(.gray)
                        
                        Capsule()
                            .fill(.ultraThinMaterial)
                            .environment(\.colorScheme, .light)
                            .frame(height: 5)
                        
                        Image(systemName: "speaker.wave.3.fill")
                            .foregroundColor(.gray)
                    }
                    
                    HStack(alignment: .top, spacing: size.width * 0.18) {
                        Button {
                            
                        } label: {
                            Image(systemName: "quote.bubble")
                                .font(.title2)
                        }
                        
                        VStack(spacing: 6) {
                            Button {
                                
                            } label: {
                                Image(systemName: "airpods.gen3")
                                    .font(.title2)
                            }
                            
                            Text("iJustine's Airpods")
                                .font(.caption)
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "list.bullet")
                                .font(.title2)
                        }
                    }
                    .foregroundColor(.white)
                    .blendMode(.overlay)
                    .padding(.top, spacing)
                }
                /// Moving it to Bottom
                .frame(height: size.height / 2.5, alignment: .bottom)
            }
        }
    }
}

struct ExpandedBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

/// デバイスの四隅の丸みを取る
extension View {
    var deviceCornerRadius: CGFloat {
        let key = "_displayCornerRadius"
        if let screen = (UIApplication.shared.connectedScenes.first as?
            UIWindowScene)?.windows.first?.screen {
            if let  cornerRadius = screen.value(forKey: key) as? CGFloat {
                return cornerRadius
            }
            
            return 0
        }
        
        return 0
    }
}
