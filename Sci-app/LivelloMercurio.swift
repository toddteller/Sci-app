//
//  Livello2.swift
//  GiocoChimica
//
//  Created by Antonio Mennillo on 21/11/2019.
//  Copyright © 2019 Antonio Mennillo. All rights reserved.
//
//        ULTIMO LIVELLO   LIVELLO CON GIROSCOPIO MERCURIO 
import Foundation
import SpriteKit
import GameplayKit
import CoreMotion
import AVFoundation

class LivelloMercurio: SKScene,SKPhysicsContactDelegate {
 private var ampolla = Ampolla()
       let background = SKSpriteNode(imageNamed: "BackGroundChimica.png")
       var motionManager = CMMotionManager()
       var destX:CGFloat = 0.0
    
       private enum Direction { case Left, Right }
       private var score = 0 {
           didSet {
               scoreLabel.text = "\(score)/15"
           }
       }
    var soundbubble = SKAction.playSoundFileNamed("game1-bubble", waitForCompletion: false)
    var backgroundMusicPlayer: AVAudioPlayer!
       private var ElementText:SKLabelNode = SKLabelNode()
       private var GameOverImage:SKSpriteNode = SKSpriteNode(imageNamed: "gameOverVerticale.png")
       private var SucessImage:SKSpriteNode = SKSpriteNode(imageNamed: "successVerticale.png")
       private var shape: SKShapeNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 5000, height: 5000))
       private var gameEnded: Bool = false
       private var justGoElement: Bool = false
       private var scoreLabel:SKLabelNode = SKLabelNode()
       private var GameOverLabel:SKLabelNode = SKLabelNode(fontNamed: "Copperplate")
       private var WinLabel:SKLabelNode = SKLabelNode(fontNamed: "Copperplate")
       private var ScoreText:SKLabelNode = SKLabelNode()
       private var buttonPlayAgain: SKShapeNode = SKShapeNode(rect: CGRect(x: 170, y: 245, width: 100, height: 100))
       private var buttonNextLevel: SKShapeNode = SKShapeNode(rect: CGRect(x: 160, y: 245, width: 100, height: 100))
       private var buttonMainMenu: SKShapeNode = SKShapeNode(rect: CGRect(x: 160, y: 590, width: 100, height: 100))
       var end : Bool = false
       var win : Bool = false
      
   
    override func didMove(to view: SKView) {
        playBackgroundMusic(filename: "game1-soundtrack.mp3")
       
       background.size = CGSize (width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
        background.anchorPoint = CGPoint(x:0,y:0)
        background.zPosition = -1
        self.addChild(background)
      GameOverLabel.text = "GAME OVER  \(score)"
      GameOverLabel.position = CGPoint(x: 0, y: 0)
      GameOverLabel.fontSize = 33
      GameOverLabel.color = .black
       
        
        ElementText.text = "MERCURY"
        ElementText.position = CGPoint(x: 340, y: 830)
        ElementText.fontSize = 30
        self.addChild(ElementText)
        
        ScoreText.text = "SCORE"
        ScoreText.position = CGPoint(x: 350, y: 800)
        ScoreText.fontSize = 30
        self.addChild(ScoreText)
        
        
        
        scoreLabel.text = "\(score)"
        scoreLabel.fontSize = 33
        scoreLabel.position = CGPoint(x:360, y:770)
           self.addChild(scoreLabel)
        ampolla.size = CGSize(width: 80, height: 90)
        ampolla.position.x = 200
        ampolla.position.y = 100
        ampolla.zPosition = 1
        self.addChild(ampolla)
        startAddingBlocks()
        self.physicsWorld.contactDelegate = self
        if motionManager.isAccelerometerAvailable{
                   motionManager.accelerometerUpdateInterval = 0.01
                   motionManager.startAccelerometerUpdates(to:.main){
                       (data, error) in
                       guard let data = data, error == nil else {
                           return
                       }
                       let currentX = self.ampolla.position.x
                    self.destX = currentX + CGFloat(data.acceleration.x * 400)
 
       }
        }
    }
    func playBackgroundMusic(filename: String) {
     let resourceUrl = Bundle.main.url(forResource:
         filename, withExtension: nil)
       guard let url = resourceUrl else {
         print("Could not find file: \(filename)")
     return
     }

        do {
          try backgroundMusicPlayer = AVAudioPlayer(contentsOf: url)
            backgroundMusicPlayer.numberOfLoops = -1
            backgroundMusicPlayer.prepareToPlay()
            backgroundMusicPlayer.play()
          } catch {
            print("Could not create audio player!")
        return
        }
        
    }
    func playSound(sound : SKAction)
    {
        run(soundbubble)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !gameEnded else { return }
        guard let location = touches.first?.location(in: self) else { return }
        if end == true {
                  
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
                   
                   
        if let name = touchedNode.name {
                      
        if name == "playagain" {
            
        self.backgroundMusicPlayer.stop()
        let level = LivelloMercurio()
        level.scaleMode = .resizeFill
        print("ciao")
        self.view?.presentScene(level)
                               
                           }
            if name == "mainmenu"
              {    self.backgroundMusicPlayer.stop()
                  NotificationCenter.default.post(name:NSNotification.Name("segue"),object: nil)
                  backgroundMusicPlayer1.play()
                 
              
            }
               
                   }
                   
               }
               if win == true {
               
                let touch:UITouch = touches.first!
                let positionInScene = touch.location(in: self)
                let touchedNode = self.atPoint(positionInScene)
                
                
                if let name = touchedNode.name {
                   
                        if name == "nextlevel" {
                            self.backgroundMusicPlayer.stop()
                            let level = LivelloMercurio()
                            level.scaleMode = .resizeFill
                            print("ciao")
                            self.view?.presentScene(level)
                            
                        }
                    if name == "mainmenu"
                      {    self.backgroundMusicPlayer.stop()
                          NotificationCenter.default.post(name:NSNotification.Name("segue"),object: nil)
                          backgroundMusicPlayer1.play()
                         
                      
                    }
    }
        }
    }

    
    
            override func update(_ currentTime: TimeInterval) {
                let action = SKAction.moveTo(x:destX, duration: 0.2)
                       ampolla.run(action)
                if  justGoElement {
                           justGoElement = false
                           score += 1
                          }
                
                   
            }
    private func startAddingBlocks() {
           let addBlockAction = SKAction.run {
                  self.createRandomBlock()
              }
           let delayAction = SKAction.wait(forDuration: 2)
           let sequence = SKAction.sequence([addBlockAction, delayAction])
           let repeatForever = SKAction.repeatForever(sequence)
           self.run(repeatForever)
          }
    private func createRandomBlock() {
             let randomBlock = arc4random_uniform(10) > 3 ? Sodio() : Ossigeno()
                    randomBlock.size = CGSize(width: 65, height: 65)
                    randomBlock.zPosition = 1
                    let otherrandomblock = arc4random_uniform(8) > 3 ? Ferro() : Mercurio()
                    otherrandomblock.size = CGSize(width: 65, height: 65)
                    otherrandomblock.zPosition = 1
                    let otherrandomblock2 = arc4random_uniform(6) > 3 ? Magnesio() : Cloro()
                    otherrandomblock2.size = CGSize(width: 65, height: 65)
                    otherrandomblock2.zPosition = 1
                    self.addChild(randomBlock)
                    self.addChild(otherrandomblock)
                    self.addChild(otherrandomblock2)
                    randomBlock.startFallingFromRandomPosition()
                    otherrandomblock.startFallingFromRandomPosition1()
                    otherrandomblock2.startFallingFromRandomPosition2()
    }
       //func didBegin(_ contact: SKPhysicsContact) {
       // guard let nodeA = contact.bodyA.node, let nodeB = contact.bodyB.node else { return }
       // if nodeA is Asteroide || nodeB is Asteroide{
            //nodeA.removeFromParent()
               //endGame()
               //return
         
        //   if let flag = nodeA as? Astronauta ?? nodeB as? Astronauta{
          //  flag.removeFromParent()
          //  self.justGotFlag = true
        
            
func didBegin(_ contact: SKPhysicsContact) {
    
      guard let otherNode = contact.bodyA.node is Ampolla ? contact.bodyB.node : contact.bodyA.node else { return }
         if let flag = otherNode as?  Mercurio {
             flag.removeFromParent()
             self.justGoElement = true
            playSound(sound: soundbubble)
         if score == 14 {
            buttonNextLevel.fillColor = .red
             buttonNextLevel.alpha = 0.01
             buttonNextLevel.zPosition = 6
            buttonNextLevel.name = "nextlevel"
            self.addChild(buttonNextLevel)
            
            
            buttonMainMenu.fillColor = .red
            buttonMainMenu.alpha = 0.01
            buttonMainMenu.zPosition = 6
            buttonMainMenu.name = "mainmenu"
            self.addChild(buttonMainMenu)
                ampolla.removeFromParent()
            self.removeAllActions()
            shape.fillColor = .black
            shape.alpha = 0.4
            shape.zPosition = 2
            self.addChild(shape)
                           
            SucessImage.size = CGSize(width: 300, height: 546)
            SucessImage.position = CGPoint(x: 210, y: 450)
            SucessImage.zPosition = 3
                           
            SucessImage.alpha = 2
            win = true
            self.addChild(SucessImage)
                 }
             }

         if otherNode is Ferro{
            buttonMainMenu.fillColor = .red
            buttonMainMenu.alpha = 0.01
            buttonMainMenu.zPosition = 6
            buttonMainMenu.name = "mainmenu"
            self.addChild(buttonMainMenu)
            
            buttonPlayAgain.fillColor = .red
            buttonPlayAgain.alpha = 0.01
            buttonPlayAgain.zPosition = 6
            buttonPlayAgain.name = "playagain"
            self.addChild(buttonPlayAgain)
              
                    ampolla.removeFromParent()
                    self.removeAllActions()
                    otherNode.removeFromParent()
                    shape.fillColor = .black
                    shape.alpha = 0.4
                    shape.zPosition = 2
                    self.addChild(shape)
                    
                    GameOverImage.size = CGSize(width: 300, height: 546)
                    GameOverImage.position = CGPoint(x: 210, y: 450)
                    GameOverImage.zPosition = 3
                    GameOverImage.alpha = 1
                             end = true
                    self.addChild(GameOverImage)
         }
         if otherNode is Sodio{
            buttonMainMenu.fillColor = .red
            buttonMainMenu.alpha = 0.01
            buttonMainMenu.zPosition = 6
            buttonMainMenu.name = "mainmenu"
            self.addChild(buttonMainMenu)
            
            buttonPlayAgain.fillColor = .red
            buttonPlayAgain.alpha = 0.01
            buttonPlayAgain.zPosition = 6
            buttonPlayAgain.name = "playagain"
            self.addChild(buttonPlayAgain)
               
                     ampolla.removeFromParent()
                     self.removeAllActions()
                     otherNode.removeFromParent()
                     shape.fillColor = .black
                     shape.alpha = 0.4
                     shape.zPosition = 2
                     self.addChild(shape)
                     
                     GameOverImage.size = CGSize(width: 300, height: 546)
                     GameOverImage.position = CGPoint(x: 210, y: 450)
                     GameOverImage.zPosition = 3
                     GameOverImage.alpha = 1
                              
                      end = true
                     self.addChild(GameOverImage)
           }
         if otherNode is Ossigeno{
            buttonMainMenu.fillColor = .red
            buttonMainMenu.alpha = 0.01
            buttonMainMenu.zPosition = 6
            buttonMainMenu.name = "mainmenu"
            self.addChild(buttonMainMenu)
            
            buttonPlayAgain.fillColor = .red
                              buttonPlayAgain.alpha = 0.01
                              buttonPlayAgain.zPosition = 6
                              buttonPlayAgain.name = "playagain"
                              self.addChild(buttonPlayAgain)
               
                     ampolla.removeFromParent()
                     self.removeAllActions()
                     otherNode.removeFromParent()
                     shape.fillColor = .black
                     shape.alpha = 0.4
                     shape.zPosition = 2
                     self.addChild(shape)
                     
                     GameOverImage.size = CGSize(width: 300, height: 546)
                     GameOverImage.position = CGPoint(x: 210, y: 450)
                     GameOverImage.zPosition = 3
                     GameOverImage.alpha = 1
                              end = true
                     self.addChild(GameOverImage)
           }
         if otherNode is Magnesio{
            buttonMainMenu.fillColor = .red
            buttonMainMenu.alpha = 0.01
            buttonMainMenu.zPosition = 6
            buttonMainMenu.name = "mainmenu"
            self.addChild(buttonMainMenu)
            
            buttonPlayAgain.fillColor = .red
                              buttonPlayAgain.alpha = 0.01
                              buttonPlayAgain.zPosition = 6
                              buttonPlayAgain.name = "playagain"
                              self.addChild(buttonPlayAgain)
                 
                       ampolla.removeFromParent()
                       self.removeAllActions()
                       otherNode.removeFromParent()
                       shape.fillColor = .black
                       shape.alpha = 0.4
                       shape.zPosition = 2
                       self.addChild(shape)
                       
                       GameOverImage.size = CGSize(width: 300, height: 546)
                       GameOverImage.position = CGPoint(x: 210, y: 450)
                       GameOverImage.zPosition = 3
                       GameOverImage.alpha = 1
                         end = true
                       self.addChild(GameOverImage)
              }
         if otherNode is Cloro{
                 buttonMainMenu.fillColor = .red
                 buttonMainMenu.alpha = 0.01
                 buttonMainMenu.zPosition = 6
                 buttonMainMenu.name = "mainmenu"
                 self.addChild(buttonMainMenu)
            buttonPlayAgain.fillColor = .red
                              buttonPlayAgain.alpha = 0.01
                              buttonPlayAgain.zPosition = 6
                              buttonPlayAgain.name = "playagain"
                              self.addChild(buttonPlayAgain)
                       ampolla.removeFromParent()
                       self.removeAllActions()
                       otherNode.removeFromParent()
                       shape.fillColor = .black
                       shape.alpha = 0.4
                       shape.zPosition = 2
                       self.addChild(shape)
                       
                       GameOverImage.size = CGSize(width: 300, height: 546)
                       GameOverImage.position = CGPoint(x: 210, y: 450)
                       GameOverImage.zPosition = 3
                       GameOverImage.alpha = 1
                            end = true
                       self.addChild(GameOverImage)
              }
       }
     }



