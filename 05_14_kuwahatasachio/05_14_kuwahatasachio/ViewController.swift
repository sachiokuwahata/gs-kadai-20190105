//
//  ViewController.swift
//  05_14_kuwahatasachio
//
//  Created by sachiokuwahata on 2019/01/08.
//  Copyright © 2019年 sachiokuwahata. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController ,UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    var timer = Timer()
    var count: Double = 5.0
    // 撮影画像の保存変数
    var saveImage:UIImage = UIImage()

    @IBOutlet weak var displayImageView: UIImageView!
    
    @IBOutlet weak var timerTextLabel: UILabel!
    
    @IBOutlet weak var startUIButton: UIButton!

    @IBOutlet weak var clearUIButton: UIButton!
    
    @IBAction func startButton(_ sender: Any) {
        
        startUIButton.isEnabled = false

    var images = ["img_1th","img_2th","img_3th","img_4th","img_5th","img_6th","img_7th","img_8th","img_9th","img_10th"]
    
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timer) in
            self.count = self.count - 0.01
            self.timerTextLabel.text = String(format: "%.1f", self.count)

            // 0.01以下で、timerを停止
            // if self.count < 0.01 {
            // self.timer.invalidate()
            // }

            switch self.count {
            case (3.99...4.01) :
                print("残り4秒")
                let int = Int.random(in: 0...9)
                self.displayImageView.image = UIImage(named: images[int])
            // self.displayImageView.image = UIImage(named: "img_1th")
            case (2.99...3.01) :
                print("残り3秒")
                let int = Int.random(in: 0...9)
                self.displayImageView.image = UIImage(named: images[int])
            // self.displayImageView.image = UIImage(named: "img_2th")
            case (1.99...2.01) :
                print("残り2秒")
                let int = Int.random(in: 0...9)
                self.displayImageView.image = UIImage(named: images[int])
            // self.displayImageView.image = UIImage(named: "img_3th")
            case (0.99...1.01) :
                print("残り1秒")
                let int = Int.random(in: 0...9)
                self.displayImageView.image = UIImage(named: images[int])

            // self.displayImageView.image = UIImage(named: "img_4th")
            case (0.01...0.02) :
                self.timer.invalidate()

                let int = Int.random(in: 0...9)
                self.displayImageView.image = UIImage(named: images[int])
                
                // self.displayImageView.image = UIImage(named: "img_5th")

                let sourceType: UIImagePickerController.SourceType = UIImagePickerController.SourceType.camera
                
                //インスタンスを作成
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
                    let cameraPicker = UIImagePickerController()
                    cameraPicker.sourceType = sourceType
                    cameraPicker.delegate = self
                    self.present(cameraPicker, animated: true, completion: nil)
                }

                print("残り0秒")
            default:
                return
            }
            
        })
        
    }
    
    @IBAction func stopBuuton(_ sender: Any) {
        self.timer.invalidate()
        startUIButton.isEnabled = true
        clearUIButton.isEnabled = true
    }
    
    
    @IBAction func clearButton(_ sender: Any) {
        self.count =  5.0
        self.timerTextLabel.text = String(self.count)
        startUIButton.isEnabled = true

    }
    
    
    override func viewDidLoad() {
        print("hogehoge")
        super.viewDidLoad()
        clearUIButton.isEnabled = false

        PHPhotoLibrary.requestAuthorization { (status) in
            switch(status){
            case .authorized: break
            case .denied: break
            case .restricted: break
            case .notDetermined: break
            }
        }
    }

    // カメラ作動中のCanselButtonの挙動
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    // 撮影画像の操作
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[.originalImage] as? UIImage{

//            URL取得試みたが、nilが返ってくる
//            NSURL(); let assetURL = info[UIImagePickerController.InfoKey.referenceURL]
//            print(assetURL)
            
            saveImage = pickedImage
            // カメラ閉じる
            picker.dismiss(animated: true, completion: nil)
            // segueをperform
            performSegue(withIdentifier: "next", sender: nil)
            print("hogehoge")
            
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "next" ){
            let subVC:FilterViewController = segue.destination as! FilterViewController
            print("hogehoge2")
            subVC.passImage = saveImage
        }
    }

    
}

