//
//  PlayYoutubeViewController.swift
//  08_14_kuwahatasachio
//
//  Created by sachiokuwahata on 2019/01/31.
//  Copyright © 2019年 sachiokuwahata. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class PlayYoutubeViewController: UIViewController {

    var VideoID = String()
    
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let youtubeView = YTPlayerView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 500))
        youtubeView.load(withVideoId: self.VideoID)
        view.addSubview(youtubeView)    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
