//
//  LazyVGridView2.swift
//  LagyGridSample
//
//  Created by 中川賢亮 on 2022/06/20.
//

import SwiftUI

struct Item: Identifiable {
    var id = UUID()
    var name: String
    var image: String
}

struct LazyVGridView2: View {

    let items = [Item(name: "item", image: "latch.2.case.fill"),
                 Item(name: "character", image: "person.fill"),
                 Item(name: "map", image: "globe.asia.australia.fill"),
                 Item(name: "mail", image: "envelope.fill"),
                 Item(name: "save", image: "magazine.fill"),
                 Item(name: "cystem", image: "gamecontroller.fill")]

    let gridItem: [GridItem] = [GridItem(.adaptive(minimum: 120))]

    var body: some View {

        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridItem, alignment: .center, spacing: 5) {

                    ForEach(items) { item in

                        VStack {
                            Image(systemName: item.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.white)

                            Text(item.name)
                                .font(.body)
                                .foregroundColor(.white)
                        }
                        .frame(width: 120, height: 100)
                        .border(Color.black, width: 1)
                        .background(.gray)
                        .cornerRadius(20)

                    }
                }
                .padding()
            }
            .navigationTitle("メニュー")
        }
    }
}


struct LazyVGridView2_Previews: PreviewProvider {
    static var previews: some View {
        LazyVGridView2()
    }
}
