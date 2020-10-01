//
//  Idrogeno.swift
//  GiocoChimica
//
//  Created by Antonio Mennillo on 20/11/2019.
//  Copyright © 2019 Antonio Mennillo. All rights reserved.
//

import Foundation
import SpriteKit
class Idrogeno: SKSpriteNode {
    static let category: UInt32 = 0x1 << 3
    init() {
        
        let texture = SKTexture(imageNamed: "idrogeno1.png")
        super.init(texture: texture, color: .clear, size: texture.size())
        let physicsBody = SKPhysicsBody(texture: texture, size:CGSize(width: 50, height: 50))
        physicsBody.restitution = 1.0
        physicsBody.affectedByGravity = false
        physicsBody.isDynamic = true
        physicsBody.friction = 0.0
        physicsBody.linearDamping = 0.0
        physicsBody.categoryBitMask = Sodio.category
        physicsBody.contactTestBitMask = Ampolla.category
        physicsBody.angularDamping = 0.0
        self.physicsBody = physicsBody
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

