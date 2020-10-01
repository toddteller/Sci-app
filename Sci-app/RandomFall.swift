//
//  RandomFall.swift
//  GiocoChimica
//
//  Created by Antonio Mennillo on 20/11/2019.
//  Copyright © 2019 Antonio Mennillo. All rights reserved.
//

import Foundation
import SpriteKit
extension SKSpriteNode {
    func startFallingFromRandomPosition() {
        //let random01 = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        let randomx = CGFloat.random(min: 40, max: 350)
        
        self.position.x = randomx
        self.position.y = self.scene!.frame.height
        let randomDuration = TimeInterval(arc4random_uniform(3) + 2)
        let fallAction = SKAction.moveTo(y: -500, duration: randomDuration)
        self.run(fallAction) { [weak self] in
            self?.removeFromParent()
        }
    }
    
}


