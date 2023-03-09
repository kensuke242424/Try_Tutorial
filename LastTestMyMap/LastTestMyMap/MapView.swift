//
//  MapView.swift
//  LastTestMyMap
//
//  Created by 中川賢亮 on 2022/09/09.
//

import SwiftUI
import MapKit

enum MapType {
    case standard
    case satellite
    case hybrid
}

struct MapView: UIViewRepresentable {
    let searchKey: String

    let mapType: MapType
    // 表示する View を作成するときに実行
    func makeUIView(context: Context) -> MKMapView {
        // MKMapViewのインスタンス生成
        MKMapView()
    } // makeUIView ここまで
    // 表示した View が更新されるたびに実行
    func updateUIView(_ uiView: MKMapView, context: Context) {

        switch mapType {
        case .standard:
            // 標準
            uiView.preferredConfiguration = MKStandardMapConfiguration(elevationStyle: .flat)
        case .satellite:
            // 衛星写真
            uiView.preferredConfiguration = MKImageryMapConfiguration()
        case .hybrid:
            // 衛星写真+交通機関ラベル
            uiView.preferredConfiguration = MKHybridMapConfiguration()
        }
        // 入力された文字をデバッグエリアに表示
        print("検索キーワード：\(searchKey)")

        // CLGeocoderインスタンスを取得
        let geocoder = CLGeocoder()
        // 入力された文字から位置情報を取得
        geocoder.geocodeAddressString(
        searchKey ,
        completionHandler: { (placemarks, error) in
            // リクエストの結果が存在し、1件目の情報から位置情報を取り出す
            if let placemarks,
            let firstPlacemark = placemarks.first,
            let location = firstPlacemark.location {

                // 位置情報から緯度経度をtargetCoordinateに取り出す
                let targetCoordinate = location.coordinate
            print("緯度経度: \(targetCoordinate)")

                // MKPointAnnotationインスタンスを生成し、ピンを作る
                let pin = MKPointAnnotation()
                // ピンを置く場所に緯度経度を設定
                pin.coordinate = targetCoordinate
                // ピンのタイトルを設定
                pin.title = searchKey
                // ピンを地図に置く
                uiView.addAnnotation(pin)
                // 緯度経度を中心にして半径500mの範囲を表示
                uiView.region = MKCoordinateRegion(
                center: targetCoordinate,
                latitudinalMeters: 500.0,
                longitudinalMeters: 500.0)
            } // if ここまで
        }) // geocoder ここまで
    } // updateUIView ここまで
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(searchKey: "羽田空港", mapType: .standard)
    }
}
