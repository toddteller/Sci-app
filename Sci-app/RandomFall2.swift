//
//  RandomFall2.swift
//  GiocoChimica
//
//  Created by Antonio Mennillo on 23/11/2019.
//  Copyright © 2019 Antonio Mennillo. All rights reserved.
//

import Foundation
import Foundation
import SpriteKit
extension SKSpriteNode {
    func startFallingFromRandomPosition2() {
        //let random01 = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        let randomx2 = CGFloat.random(min: 40, max: 350)
        
        
        self.position.x = randomx2
        self.position.y = self.scene!.frame.height
        let randomDuration = TimeInterval(arc4random_uniform(3)+2)
        let fallAction = SKAction.moveTo(y: -500, duration: randomDuration)
        self.run(fallAction) { [weak self] in
        self?.removeFromParent()
            
            
            
        }
    }
    
}
