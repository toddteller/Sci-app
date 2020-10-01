//
//  ViewControllerChemistry.swift
//  Sci-app
//
//  Created by Lorenzo Montenero on 25/11/2019.
//  Copyright © 2019 Lorenzo Montenero. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class ViewControllerChemistry: UIViewController {
    
    var name_button: String = ""
    
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(goToDifferentView), name:NSNotification.Name("segue"), object: nil)
        
        print("ciao")
        if name_button == "level1" {
        
        let level = LivelloIdrogeno()
        let skView = view as! SKView
        level.scaleMode = .resizeFill
        skView.presentScene(level)
    }
        
              if name_button == "level2" {
              
              let level = LivelloCarbonio()
              let skView = view as! SKView
              level.scaleMode = .resizeFill
              skView.presentScene(level)
          }
        
              if name_button == "level3" {
              
              let level = LivelloCloro()
              let skView = view as! SKView
              level.scaleMode = .resizeFill
              skView.presentScene(level)
          }
        
              if name_button == "level4" {
              
              let level = LivelloOssigeno()
              let skView = view as! SKView
              level.scaleMode = .resizeFill
              skView.presentScene(level)
          }
        
              if name_button == "level5" {
              
              let level = LivelloAzoto()
              let skView = view as! SKView
              level.scaleMode = .resizeFill
              skView.presentScene(level)
          }
        
              if name_button == "level6" {
              
              let level = LivelloFerro()
              let skView = view as! SKView
              level.scaleMode = .resizeFill
              skView.presentScene(level)
          }
        
              if name_button == "level7" {
              
              let level = LivelloMagnesio()
              let skView = view as! SKView
              level.scaleMode = .resizeFill
              skView.presentScene(level)
          }
        
              if name_button == "level8" {
              
              let level = LivelloSodio()
              let skView = view as! SKView
              level.scaleMode = .resizeFill
              skView.presentScene(level)
          }
        
              if name_button == "level9" {
              
              let level = LivelloMercurio()
              let skView = view as! SKView
              level.scaleMode = .resizeFill
              skView.presentScene(level)
          }
        
        
        
  }
    
    @objc func goToDifferentView() {
        dismiss(animated: false, completion: nil)
        self.performSegue(withIdentifier: "segue", sender: self)
     
    }
    
    
   
}
