//
//  ViewController.swift
//  ARShaderLab
//
//  Created by Jesse Boyes on 12/4/19.
//  Copyright © 2019 JB6. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!

    var sphereNode: SCNNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()//named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene

        let sphere = SCNSphere(radius: 0.05)

        guard
            let surfaceShaderURL = Bundle.main.url(forResource: "surface", withExtension: "shader"),
            let surfaceModifier = try? String(contentsOf: surfaceShaderURL),
            let geometryShaderURL = Bundle.main.url(forResource: "geom", withExtension: "shader"),
            let geometryModifier = try? String(contentsOf: geometryShaderURL)


            else { fatalError("Can't load shader from bundle.") }

        sphere.shaderModifiers = [.surface: surfaceModifier,
                                  .geometry: geometryModifier]

        sphere.setValue(sphere.radius, forKey: "sphereRadius")

        sphere.firstMaterial?.diffuse.contents = UIImage(named: "skull")
        sphere.firstMaterial?.lightingModel = .physicallyBased
        sphere.firstMaterial?.diffuse.wrapS = SCNWrapMode.repeat
        sphere.firstMaterial?.diffuse.wrapT = SCNWrapMode.repeat
        sphere.firstMaterial?.specular.contents = 1.0

        sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = SCNVector3(x: 0, y: 0, z: -0.3)

        scene.rootNode.addChildNode(sphereNode)
        sceneView.isPlaying = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)

        sphereNode.geometry?.firstMaterial?.reflective.contents = sceneView.scene.background
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    

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
