//
//  SoundPlayer.swift
//  LastTestMyMusic
//
//  Created by 中川賢亮 on 2022/09/09.
//

import UIKit
import AVFoundation

class SoundPlayer: NSObject {
    // シンバルの音源データを読み込み
    let cymbalData = NSDataAsset(name: "cymbalSound")!.data
    // シンバル用プレイヤーの変数
    var cymbalPlayer: AVAudioPlayer!

    func cymbalPlay() {

        do {
            // シンバル用のプレイヤーに、音源データを指定
            cymbalPlayer = try AVAudioPlayer(data: cymbalData)
            //シンバルの音源再生
            cymbalPlayer.play()
        } catch {
            print("エラー")
        }

    }
}
