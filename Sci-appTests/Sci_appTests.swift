//
//  Sci_appTests.swift
//  Sci-appTests
//
//  Created by Aiello Giovanni on 28/04/25.
//  Copyright © 2025 Lorenzo Montenero. All rights reserved.
//

import XCTest
import SpriteKit
@testable import Sci_app


final class Sci_appTests: XCTestCase{
    
     func testCameraMoves200PixelsOnXAxisAfter60Frames() throws {
        let view = SKView(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
        let scene = Level1(size: view.bounds.size)
        scene.scaleMode = .aspectFill
        view.presentScene(scene)
        RunLoop.current.run(until: Date())
           // Simula il passaggio del tempo
           for i in 1...60 {
               let actualPosition = scene.cameraNode.position.x
               let currentTime = TimeInterval(i) * (1.0 / 60.0) // 60 FPS
               scene.update(currentTime)
               let deltaX = scene.cameraNode.position.x
               XCTAssertEqual(deltaX,actualPosition+200 , accuracy: 0.1)
           }

        
    }

}
