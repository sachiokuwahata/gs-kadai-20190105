//
//  YoutubeViewController.swift
//  08_14_kuwahatasachio
//
//  Created by sachiokuwahata on 2019/01/31.
//  Copyright © 2019年 sachiokuwahata. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class YoutubeViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    
    
    @IBOutlet weak var researchTextField: UITextField!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let titleLabel = cell.viewWithTag(1) as! UILabel
        let discriptLabel = cell.viewWithTag(2) as! UILabel
        
        titleLabel.text = posts[indexPath.row].title
        discriptLabel.text = posts[indexPath.row].descript
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        print(posts[indexPath.row].videoId)
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        let playyoutubeVC = storyboard.instantiateViewController(withIdentifier: "playyoutube") as! PlayYoutubeViewController
        playyoutubeVC.VideoID = posts[indexPath.row].videoId
        
        self.present(playyoutubeVC,animated: true, completion: nil)
        
    }
    
//    var arrayTtile = [String]()
//    var arrayYoutube: [String: String] = [:]

    var posts = [Youtube]()
    var posst = Youtube()
    
    @IBOutlet weak var tableview: UITableView!
    
    
    @IBAction func researchButton(_ sender: Any) {
        guard let researchQuery:String = researchTextField.text! else { return }
        fetchPost()
    }
    
    func fetchPost() {

        guard let researchQuery:String = researchTextField.text! else { return }
                
        var query = researchQuery
        var key = "AIzaSyAiCmvl8QtYAnaSFAPzYWY_8RS7o7FUQfg"
        var maxresult = "10"
        
        var request = "https://www.googleapis.com/youtube/v3/search?key=\(key)&q=\(query)&part=snippet&maxResults=\(maxresult)&order=rating"

        // エンコード
        request = request.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        
        self.posts = [Youtube]()
        
        Alamofire.request(request)
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                let json = JSON(object)
                print("json: \(json)")
                for i in 1 ..< 10 {
                    self.posst = Youtube()
                    
                    if let title = String(describing: json["items"][i]["snippet"]["title"]) as! String?,
                       let descript = String(describing: json["items"][i]["snippet"]["description"]) as! String?,
                       let videoId = String(describing: json["items"][i]["id"]["videoId"]) as! String?
                    {
                        self.posst.title = String(describing: json["items"][i]["snippet"]["title"])
                        self.posst.descript = String(describing: json["items"][i]["snippet"]["description"])
                        self.posst.videoId = String(describing: json["items"][i]["id"]["videoId"])
                    }
                    self.posts.append(self.posst)
                    print("title:\(self.posst.title)")
                    print("self.posts: \(self.posts)")
                    // self.arrayYoutube[String(describing: json["items"][i]["snippet"]["title"])] = String(describing: json["items"][i]["id"]["videoId"])
                }
            self.tableview.reloadData()
            //print("arrayYoutube: \(self.arrayYoutube)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.delegate = self
        tableview.dataSource = self
    }

}
