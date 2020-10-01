//
//  Ampolla.swift
//  GiocoChimica
//
//  Created by Antonio Mennillo on 20/11/2019.
//  Copyright © 2019 Antonio Mennillo. All rights reserved.
//

import Foundation
import SpriteKit

class Ampolla: SKSpriteNode{
    //Associo una categoria distinta ad ogni assets
    static let category: UInt32 = 0x1 << 1
   
    init () {
        //la prima parte del metodo init() utilizza l'immagine astronauta per la texture
        let texture = SKTexture(imageNamed: "flask.png")
        super.init(texture:texture, color: .clear,size:texture.size())
        let physicsBody = SKPhysicsBody(texture: texture, size: CGSize(width: 50, height: 60))
        physicsBody.restitution = 1.0
        physicsBody.affectedByGravity = false
        physicsBody.friction = 0.0
        physicsBody.linearDamping = 0.0
        physicsBody.categoryBitMask = Ampolla.category
        physicsBody.contactTestBitMask = Sodio.category | Idrogeno.category
        physicsBody.collisionBitMask = 0
        physicsBody.angularDamping = 0.0
        physicsBody.isDynamic = false
        self.physicsBody = physicsBody
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func startMovingToLeftEdge(){
        self.removeAllActions()
       
        let duration = TimeInterval(1)
        let moveLeft = SKAction.moveTo(x: 40, duration: duration)
        self.run(moveLeft)
    }
    func startMovingToRightEdge(){
        self.removeAllActions()
       
        let duration = TimeInterval(1)
        let moveRight = SKAction.moveTo(x: 350, duration: duration)
        self.run(moveRight)
    }
    func stop(){
        self.removeAllActions()
    }
}

