//
//  ViewControllerAstronomy.swift
//  Sci-app
//
//  Created by Aiello Giovanni on 25/11/2019.
//  Copyright © 2019 Lorenzo Montenero. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class ViewControllerAstronomy : UIViewController{

    var name_button: String = ""
  
      
    override func viewDidLayoutSubviews() {
        super.viewDidLoad()
        
    NotificationCenter.default.addObserver(self, selector: #selector(goToDifferentView), name:NSNotification.Name("segue2"), object: nil)
        
    
        if name_button == "planet1" {
        
        let level = Level1()
        let skView = view as! SKView
        level.scaleMode = .resizeFill
        skView.presentScene(level)
    }
        
              if name_button == "planet2" {
              
              let level = Level2()
              let skView = view as! SKView
              level.scaleMode = .resizeFill
              skView.presentScene(level)
          }
        
              if name_button == "planet3" {
              
              let level = Level3()
              let skView = view as! SKView
              level.scaleMode = .resizeFill
              skView.presentScene(level)
          }
        
              if name_button == "planet4" {
              
              let level = Level4()
              let skView = view as! SKView
              level.scaleMode = .resizeFill
              skView.presentScene(level)
          }
        
              if name_button == "planet5" {
              
              let level = Level5()
              let skView = view as! SKView
              level.scaleMode = .resizeFill
              skView.presentScene(level)
          }
        
              if name_button == "planet6" {
              
              let level = Level6()
              let skView = view as! SKView
              level.scaleMode = .resizeFill
              skView.presentScene(level)
          }
        
              if name_button == "planet7" {
              
              let level = Level7()
              let skView = view as! SKView
              level.scaleMode = .resizeFill
              skView.presentScene(level)
          }
        
              if name_button == "planet8" {
              
              let level = Level8()
              let skView = view as! SKView
              level.scaleMode = .resizeFill
              skView.presentScene(level)
          }
        
              if name_button == "planet9" {
              
              let level = Level9()
              let skView = view as! SKView
              level.scaleMode = .resizeFill
              skView.presentScene(level)
          }
        
    }
 @objc func goToDifferentView() {
        dismiss(animated: false, completion: nil)
        self.performSegue(withIdentifier: "segue2", sender: self)
        NotificationCenter.default.removeObserver(self)
        
    }
    override func viewDidAppear(_ animated: Bool) {
           UIDevice.current.setValue(UIDeviceOrientation.landscapeRight.rawValue, forKey: "orientation")
          
      }
      override func viewWillAppear(_ animated: Bool) {
               UIDevice.current.setValue(UIDeviceOrientation.landscapeRight.rawValue, forKey: "orientation")
      }

    
}
