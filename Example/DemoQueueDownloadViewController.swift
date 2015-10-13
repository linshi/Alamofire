//
//  DemoQueueDownloadViewController.swift
//  iOS Example
//
//  Created by Lin Shi on 6/10/2015.
//  Copyright © 2015 Alamofire. All rights reserved.
//

import UIKit


class DemoQueueDownloadViewController: UIViewController {
    
//    var remoteMusicURLArray = ["http://m1.music.126.net/cRoouidBGGDZbuNExjxeJA==/3111617906650514.mp3+55a777aecc5c556976feb138",
//        "http://m1.music.126.net/cIPO8Ftj0AmNNXN4Q7kJnQ==/2109962813715777.mp3+55a77233cc5c556976fd6e93",
//        "http://m1.music.126.net/gEuQXUs0h25y5gknTtv2yA==/1272134953365677.mp3+55a77057cc5c556976fcffc9",
//        "http://m1.music.126.net/pK3yUrvSmC78bpDQWDbRog==/1032441418492001.mp3+55a77a53cc5c556976ff45b5",
//        "http://m1.music.126.net/doamnDWYkCfvOuaxYWuRww==/3206175906598826.mp3+55a77252cc5c556976fd7520",
//        "http://m1.music.126.net/uA6EmynHQ1spUIkXMMwAlA==/5899979394783476.mp3+55a77177cc5c556976fd4225",
//        "http://m1.music.126.net/yb9Qnp8tD9E6UtFyI93yZg==/2098967697433761.mp3+55a774c9cc5c556976fe0678",
//        "http://m1.music.126.net/XkA5i7pe74SWOt6g4Oja1Q==/3144603255447519.mp3+55a77000cc5c556976fceb78",
//        "http://m1.music.126.net/PT6gIq8mMgmLR8E6Kop15w==/1252343744053052.mp3+55a77bc1cc5c556976ff926e",
//        "http://m1.music.126.net/dbgx7-awpGYfQx0_nAxy7A==/6025323720526761.mp3+55a775b1cc5c556976fe3bb5"]

    
    var remoteMusicURLArray = [
        "http://m1.music.126.net/cRoouidBGGDZbuNExjxeJA==/3111617906650514.mp3+55a777aecc5c556976feb138",
        "222http://m1.music.126.net/cIPO8Ftj0AmNNXN4Q7kJnQ==/2109962813715777.mp3+55a77233cc5c556976fd6e93",
        "http://m1.music.126.net/gEuQXUs0h25y5gknTtv2yA==/1272134953365677.mp3+55a77057cc5c556976fcffc9",
]
    
    
    var manager: DownloadManager?
    @IBOutlet weak var progressLabel: UILabel!

    @IBOutlet weak var failedLabel: UILabel!
    override func viewDidLoad() {
        
        manager = DownloadManager(downloadURLArray: remoteMusicURLArray)
        
        var count = 0
        var failedCount = 0

        NSNotificationCenter.defaultCenter().addObserverForName("update_progress", object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            print("succeed to recieve notification \(notification)")
            self.progressLabel.text = "\(++count)"
        }
        
        NSNotificationCenter.defaultCenter().addObserverForName("download_failed", object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            print("failed to download \(notification)")
            self.failedLabel.text = "\(++failedCount)"
        }

    }
    
    @IBAction func startDownloading(sender: UIButton) {

        manager?.start()
    }
}