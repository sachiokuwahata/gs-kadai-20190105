//
//  ViewController.swift
//  09_14_kuwahatasachio
//
//  Created by sachiokuwahata on 2019/02/04.
//  Copyright © 2019年 sachiokuwahata. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON


class ViewController: UIViewController  ,CLLocationManagerDelegate ,GMSMapViewDelegate{

    let defaultLatitude = 35.6675497
    let defaultLongitude = 139.7137988
    let defaultZoomLevel:Float = 14.0
    var mapView: GMSMapView!
    let locationmanager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPost()

        let lat = self.defaultLatitude
        let lng = self.defaultLongitude
        
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: defaultZoomLevel)
        
        self.mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        
        //自分の位置を表示 , 自分の位置に移動する
        self.mapView.isMyLocationEnabled = true;
        self.mapView.settings.myLocationButton = true;
        self.view.addSubview(self.mapView)
        
        self.locationmanager.activityType = .other
        self.locationmanager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationmanager.distanceFilter = 50
        self.locationmanager.startUpdatingLocation()

        mapView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let num = TaskCollection.shared.tasks.count
        for i in 0..<num {

            let marker = GMSMarker()

            let lat = Double(TaskCollection.shared.tasks[i].latitude)
            let lon = Double(TaskCollection.shared.tasks[i].longitude)
            marker.position.latitude = lat!
            marker.position.longitude = lon!
            marker.title = TaskCollection.shared.tasks[i].name

            marker.map = mapView
        }
        
        
//        // 非同期処理を試みたんだがNGだなぁ....
//        self.doMoreAfterConcurretQueuesUsingDispatchGroup()
    }

    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
    }

    func mapView(mapView: GMSMapView, didTapMarker marker: GMSMarker) -> Bool {
        print("TAPTAP")
        let update = GMSCameraUpdate.zoom(by: 2)
        mapView.animate(with: update)
        print("TAPTAP")
        
        return true
    }

    
    func fetchPost() {
        
        var key = "0c7a7a07f8484b6add7109fb9eec417f"
        var PREF = "PREF13"  //&pref=\(PREF)
        let range = 3
        var freeword = "家系 ラーメン" // &freeword=\(freeword)
        //  var latitude = 35  // &latitude=\(latitude)
        //  var longitude = 139 // &longitude=\(longitude)
        //  &category_l=RSFST08000
        
        var request = "https://api.gnavi.co.jp/RestSearchAPI/20150630/?keyid=\(key)&format=json&hit_per_page=100&pref=\(PREF)&freeword=\(freeword)&category_l=RSFST08000"
        //エンコード化
        request = request.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        
        Alamofire.request(request)
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                let json = JSON(object)
                let num = json["rest"].count as! Int
                print("num: \(num)")
                
                for i in 0..<num {
                    // let shopinfo = json["rest"][i]
                    let name:String = json["rest"][i]["name"].string!
                    let id:String = json["rest"][i]["id"].string!
                    let latitude:String = json["rest"][i]["latitude"].string!
                    let longitude:String = json["rest"][i]["longitude"].string!
                    
                    TaskCollection.shared.addTask(name:name, id:id, latitude:latitude, longitude:longitude)
                    print("店舗")
                }
        }

    }
    
    // 非同期処理のための関数を作成したが、成功できず
    func doMoreAfterConcurretQueuesUsingDispatchGroup() {
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global(qos: .default).async {
            self.fetchPost()
            group.leave()
        }
        group.notify(queue: DispatchQueue.global(qos: .default)) {
            let num = TaskCollection.shared.tasks.count
            print("すべてのキューの処理が完了しました")
            for i in 0..<num {
                
                let marker = GMSMarker()
                
                let lat = Double(TaskCollection.shared.tasks[i].latitude)
                let lon = Double(TaskCollection.shared.tasks[i].longitude)

                let label = UILabel(frame: CGRect(x:0.0, y:0.0, width:20.0, height:20.0))

                label.font = UIFont.systemFont(ofSize: 10.0)
                label.textAlignment = .center
                label.textColor = .white
                let markerView = UIView(frame: CGRect(x:0.0, y:0.0, width:30.0, height:30.0))
                markerView.layer.cornerRadius = 30.0
                markerView.backgroundColor = .red
                markerView.addSubview(label)
                marker.iconView = markerView
                
                marker.position.latitude = lat!
                marker.position.longitude = lon!
                marker.title = TaskCollection.shared.tasks[i].name
                marker.map = self.mapView
            }
        }
    }
    
}

