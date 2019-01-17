//
//  ViewController.swift
//  06_14_kuwahatasachio
//
//  Created by sachiokuwahata on 2019/01/17.
//  Copyright © 2019年 sachiokuwahata. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // earthのgeometry / Nodeの作成
        let solar = SCNSphere(radius: 0.3)
        solar.name = "solar"
        solar.firstMaterial?.diffuse.contents = UIImage(named: "sun")
        
        let solarNode = SCNNode(geometry: solar)
        solarNode.position = SCNVector3(0,-0.5,-3)
        solarNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 4, z: 0, duration: 4)))
        
        
        // mercuy Start--------------------------------------
        // geometry / Nodeの作成
        let mercury = SCNSphere(radius: 0.05)
        mercury.name = "mercury"
        mercury.firstMaterial?.diffuse.contents = UIImage(named: "Mercury")
        let mercuryNode = SCNNode(geometry: mercury)
        // 公転（太陽と同じ軸）からの距離
        mercuryNode.position = SCNVector3(0,0,-1)
        
        // 公転用のnodeを作成
        let mercuryrevolutionNode = SCNNode()
        mercuryrevolutionNode.position = SCNVector3(0,-0.5,-3)
        mercuryrevolutionNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 4, z: 0, duration: 1
        )))
        
        scene.rootNode.addChildNode(mercuryrevolutionNode)
        mercuryrevolutionNode.addChildNode(mercuryNode)
        
        // mercuy Fin--------------------------------------
        
        
        // Venus Start--------------------------------------
        // geometry / Nodeの作成
        let venus = SCNSphere(radius: 0.05)
        venus.name = "venus"
        venus.firstMaterial?.diffuse.contents = UIImage(named: "Venus")
        let venusNode = SCNNode(geometry: venus)
        // 公転（太陽と同じ軸）からの距離
        venusNode.position = SCNVector3(0,0,-2)
        
        // 公転用のnodeを作成
        let venusrevolutionNode = SCNNode()
        venusrevolutionNode.position = SCNVector3(0,-0.5,-3)
        venusrevolutionNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 4, z: 0, duration: 1
        )))
        
        scene.rootNode.addChildNode(venusrevolutionNode)
        venusrevolutionNode.addChildNode(mercuryNode)
        
        // Venus Fin--------------------------------------
        
        // earth Start--------------------------------------
        // geometry / Nodeの作成
        let earth = SCNSphere(radius: 0.1)
        earth.name = "earth"
        earth.firstMaterial?.diffuse.contents = UIImage(named: "earth")
        let earthNode = SCNNode(geometry: earth)
        // 公転（太陽と同じ軸）からの距離
        earthNode.position = SCNVector3(0,0,-3)
        
        // 公転用のnodeを作成
        let earthrevolutionNode = SCNNode()
        earthrevolutionNode.position = SCNVector3(0,-0.5,-3)
        earthrevolutionNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 4, z: 0, duration: 10
        )))
        
        scene.rootNode.addChildNode(earthrevolutionNode)
        earthrevolutionNode.addChildNode(earthNode)
        earthNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 4, z: 0, duration: 2)))

        
        // earth Fin--------------------------------------
        
        
        // moon Start--------------------------------------
        // geometry / Nodeの作成
        let moon = SCNSphere(radius: 0.05)
        moon.name = "moon"
        // moon.firstMaterial?.diffuse.contents = UIImage(named: "earth")
        moon.firstMaterial?.diffuse.contents = UIColor.yellow
        let moonNode = SCNNode(geometry: moon)
        // 公転（地球と同じ軸）からの距離
        moonNode.position = SCNVector3(0,0,-0.5)
        
        // 公転用 >> 地球へのnodeを作成
        let moonrevolutionNode = SCNNode()
        moonrevolutionNode.position = SCNVector3(0,0,-3)
        moonrevolutionNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 4, z: 0, duration: 2
        )))
        
        //        earthNode.addChildNode(moonrevolutionNode)
        earthrevolutionNode.addChildNode(moonrevolutionNode)
        moonrevolutionNode.addChildNode(moonNode)
        
        // moon Fin--------------------------------------
        
        
        
        // Mars Start--------------------------------------
        // geometry / Nodeの作成
        let Mars = SCNSphere(radius: 0.4)
        Mars.name = "Mars"
        Mars.firstMaterial?.diffuse.contents = UIImage(named: "Mars")
        let MarsNode = SCNNode(geometry: Mars)
        // 公転（太陽と同じ軸）からの距離
        MarsNode.position = SCNVector3(0,0,-4)
        
        // 公転用のnodeを作成
        let MarsrevolutionNode = SCNNode()
        MarsrevolutionNode.position = SCNVector3(0,-0.5,-3)
        MarsrevolutionNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 4, z: 0, duration: 15
        )))
        
        scene.rootNode.addChildNode(MarsrevolutionNode)
        MarsrevolutionNode.addChildNode(MarsNode)
        
        // Mars Fin--------------------------------------
        
        
        // jupiter Start--------------------------------------
        // geometry / Nodeの作成
        let jupiter = SCNSphere(radius: 0.6)
        jupiter.name = "jupiter"
        jupiter.firstMaterial?.diffuse.contents = UIImage(named: "Jupiter")
        let jupiterNode = SCNNode(geometry: jupiter)
        // 公転（太陽と同じ軸）からの距離
        jupiterNode.position = SCNVector3(0,0,-5)
        
        // 公転用のnodeを作成
        let jupiterrevolutionNode = SCNNode()
        jupiterrevolutionNode.position = SCNVector3(0,-0.5,-3)
        jupiterrevolutionNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 4, z: 0, duration: 3
        )))
        
        scene.rootNode.addChildNode(jupiterrevolutionNode)
        jupiterrevolutionNode.addChildNode(jupiterNode)
        jupiterNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 4, z: 0, duration: 4)))

        // jupiter Fin--------------------------------------
        
        
        // saturn Start--------------------------------------
        // geometry / Nodeの作成
        let saturn = SCNSphere(radius: 0.1)
        saturn.name = "saturn"
        saturn.firstMaterial?.diffuse.contents = UIImage(named: "Saturn")
        let saturnNode = SCNNode(geometry: saturn)
        // 公転（太陽と同じ軸）からの距離
        saturnNode.position = SCNVector3(0,0,-6)
        
        // 公転用のnodeを作成
        let saturnrevolutionNode = SCNNode()
        saturnrevolutionNode.position = SCNVector3(0,-0.5,-3)
        saturnrevolutionNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 4, z: 0, duration: 5
        )))
        
        scene.rootNode.addChildNode(saturnrevolutionNode)
        saturnrevolutionNode.addChildNode(saturnNode)
        saturnNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 4, z: 0, duration: 2)))

        // saturn Fin--------------------------------------
        
        
        
        
        // Set the scene to the view
        
        scene.rootNode.addChildNode(solarNode)
        
        
        let tapGestureRecog = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.sceneView.addGestureRecognizer(tapGestureRecog)
        
        sceneView.scene = scene
        
    }
    
    var tappedPlanet: [String:String] = [:]
    
    @objc func tapped(recognizer :UIGestureRecognizer) {
        print("タップしたよ")
        let sceneView = recognizer.view as! SCNView
        let touchLocation = recognizer.location(in: sceneView)
        let hitResults = sceneView.hitTest(touchLocation, options: [:])
        
        if !hitResults.isEmpty {
            print(hitResults[0].node)
            let node = hitResults[0].node
            // node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
            node.geometry?.firstMaterial?.diffuse.contents = UIColor.lightGray.withAlphaComponent(0.1)
            
            if let name = node.geometry?.name {
                self.tappedPlanet[name] = "Got"
                print(self.tappedPlanet.count)
                
                //                    textGeometryを追加したい....
                //                    let number:Int = self.tappedPlanet.count
                //                    let textGeometry = SCNText(string: "\(number)個の惑星を撃破！！", extrusionDepth: 0.5)
                //                    textGeometry.firstMaterial?.diffuse.contents = UIColor.red
                //                    let textNode = SCNNode(geometry: textGeometry)
                //                    let textScene = SCNScene()
                //                    textScene.rootNode.addChildNode(textNode)
                
                
                
                //                        if self.tappedPlanet.count == 4 {
                //                                print("4惑星爆破!!!!!!")
                //
                //                        } else {
                //                                return
                //                        }
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    
    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
     
     return node
     }
     */
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
