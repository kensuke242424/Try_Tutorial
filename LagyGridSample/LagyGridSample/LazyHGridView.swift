//
//  LazyHGridView.swift
//  LagyGridSample
//
//  Created by 中川賢亮 on 2022/06/20.
//

import SwiftUI


struct LazyHGridView: View {

    let hGridItem: [GridItem] = [GridItem(.fixed(800))]
    let imageList = ["neko1", "neko2", "neko3", "neko4", "neko5"]

    var body: some View {

        NavigationView {
            ScrollView(.horizontal) {
                LazyHGrid(rows: hGridItem, alignment: .center) {

                    ForEach(0 ..< imageList.count, id: \.self) { index in

                        VStack {
                            // 猫の写真
                            Image(imageList[index])
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .foregroundColor(.white)

                            Text("\(index)")
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("LazyHGrid")
        }
    }
}

struct LazyHGridView_Previews: PreviewProvider {
    static var previews: some View {
        LazyHGridView()
    }
}
