

import Foundation
import SpriteKit
import AVFoundation
import UIKit

class Level9: SKScene,SKPhysicsContactDelegate {
    
    
    let cameraNode = SKCameraNode() //Camera
       let astro : SKSpriteNode = SKSpriteNode (imageNamed:"A1")
       var cameraRect : CGRect { //Computed Property
       let x = cameraNode.position.x - size.width/2
       let y = cameraNode.position.y - size.height/2
       return CGRect(x: x,y: y, width: size.width, height: size.height)
       }
       var numb:Int = 0
       var lifes : SKSpriteNode = SKSpriteNode()
       let label : SKLabelNode = SKLabelNode()
       var numb_score:Int = 0
       var gameover : SKSpriteNode = SKSpriteNode(imageNamed: "gameOverOrizzontale")
       var  shape : SKShapeNode = SKShapeNode()
       var  shape1 : SKShapeNode = SKShapeNode()
       var  shape2 : SKShapeNode = SKShapeNode()
       var  shape3 : SKShapeNode = SKShapeNode()
       var playButton: SKSpriteNode?
       var gamewin : SKSpriteNode = SKSpriteNode(imageNamed: "successOrizzontale")
       let sound_coin = SKAction.playSoundFileNamed("game2-coin.mp3", waitForCompletion: false)
       let sound_gameover = SKAction.playSoundFileNamed("damage.mp3", waitForCompletion: false)
       let soundtrack = SKAction.playSoundFileNamed("game2-soundtrack.mp3",waitForCompletion: false)
       var backgroundMusicPlayer: AVAudioPlayer!
       var backgroundMusicPlayer2: AVAudioPlayer!
       let r: Int = Int.random(in: 1...8)
       var value : Int = 10
    
       override func didMove(to view: SKView) {
           for i in 0...1 {  // For to create one Node formed by two nodes
           let bg = create_Bg() //Create the Super Node
           bg.anchorPoint = CGPoint.zero
               if i == 0 {
                   bg.position = CGPoint(x: (CGFloat(i)*bg.size.width), y: 0)
                   bg.zPosition = 1
               }
               else if i == 1 {
                   bg.position = CGPoint(x: (CGFloat(i)*bg.size.width-1.2), y: 0)
                   bg.zPosition = -1
               }
           bg.name = "background"
           addChild(bg)
           }
           //------------------------------------------------------------------------------------------//
           addChild(cameraNode)
           addChild(astro)
           numb = 3
           lifesF(number: String(numb))
           score(numb_score:String(numb_score))
           addChild(label)
        
           shape = SKShapeNode(rect: CGRect(x:-1000,y: -500, width:5000, height: 5000))
           shape.strokeColor = .black
           shape.lineWidth = 4.0
           shape.zPosition = 3
           shape.fillColor = .black
           shape.alpha = 0
           addChild(shape)
           shape1 = SKShapeNode(rect: CGRect(x:-175,y:-70, width:80, height: 80))
           shape1.strokeColor = .black
           shape1.lineWidth = 4.0
           shape1.zPosition = 5
           shape1.fillColor = .red
           shape1.alpha = 1
         
           shape2 = SKShapeNode(rect: CGRect(x:100,y:-70, width:80, height: 80))
           shape2.strokeColor = .black
           shape2.lineWidth = 4.0
           shape2.zPosition = 5
           shape2.fillColor = .red
           shape2.alpha = 0
           shape1.name = "shape"
           
           shape3 = SKShapeNode(rect: CGRect(x:100,y:-70, width:80, height: 80))
          shape3.strokeColor = .black
          shape3.lineWidth = 4.0
          shape3.zPosition = 5
          shape3.fillColor = .red
          shape3.alpha = 0
                 
          
           //------------------------------------------------------------------------------------------//
       
           astro.position = CGPoint(x:130,y:90)
           astro.size = CGSize(width: 218, height: 336)
           astro.zPosition = 3
           astro.run(SKAction.repeatForever(createFullAstronaut()),withKey: "astro_run")
           camera = cameraNode
           cameraNode.position = CGPoint(x:50,y:size.height/2)
           playButton = self.childNode(withName: "startButton") as? SKSpriteNode
           
            run(SKAction.repeatForever(SKAction.sequence([SKAction.run {
                     [weak self] in self?.spawnRock()
                },SKAction.wait(forDuration: 1.5),SKAction.run{
                [weak self] in self?.setAstro()} ])))
           run(SKAction.repeatForever(SKAction.sequence([SKAction.run {
                 [weak self] in self?.spawnCollectibles()
           },SKAction.wait(forDuration: 2.0),SKAction.run{
               [weak self] in self?.setAstro()}])))
           
       
           
           //-----------------------------c o l l i s i o n ----------------------------------------//
           
           astro.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 70))
           astro.physicsBody?.isDynamic = true
           astro.physicsBody?.affectedByGravity = false
           astro.physicsBody?.collisionBitMask = rock_value
           astro.physicsBody?.categoryBitMask = astro_value
           astro.physicsBody?.contactTestBitMask = rock_value
           physicsWorld.contactDelegate = self
           physicsBody?.isDynamic = false
          
           gameover.size = CGSize(width: 392, height: 188)
           gameover.zPosition = 4
           gameover.position = CGPoint(x:cameraNode.position.x,y:cameraNode.position.y)
           addChild(gameover)
           gameover.alpha = 0
           gamewin.size = CGSize(width: 392, height: 188)
           gamewin.zPosition = 4
           gamewin.position = CGPoint(x:cameraNode.position.x,y:cameraNode.position.y)
           addChild(gamewin)
           gamewin.alpha = 0
           shape1.name = "shape1"
           shape2.name = "shape2"
           shape3.name = "shape3"
           shape1.alpha = 0.01
           shape2.alpha = 0.01
           shape3.alpha = 0.01
           addChild(shape1)
           addChild(shape2)
           addChild(shape3)
           playBackgroundMusic(filename: "game2-soundtrack.mp3")
           

       }
       override func update(_ currentTime: TimeInterval) {
           if (numb>0) {
               moveCamera()
               astro.position = CGPoint(x:cameraNode.position.x-420,y:90)
               lifes.position = CGPoint(x:cameraNode.position.x+50,y:360)
               label.position = CGPoint(x:cameraNode.position.x-510,y:355)
               shape.position = CGPoint(x:cameraNode.position.x,y:cameraNode.position.y)
               shape1.position = CGPoint(x:cameraNode.position.x,y:cameraNode.position.y)
               shape2.position = CGPoint(x:cameraNode.position.x,y:cameraNode.position.y)
               shape3.position = CGPoint(x:cameraNode.position.x,y:cameraNode.position.y)
               gameover.position = CGPoint(x:cameraNode.position.x,y:cameraNode.position.y)
               gamewin.position = CGPoint(x:cameraNode.position.x,y:cameraNode.position.y)
               
           }
        else if (numb<=0) {
              
               astro.removeFromParent()
               lifes.removeFromParent()
               gameover.alpha = 1
               shape.alpha = 0.4
               shape3.name = "shape2"
               self.view?.isUserInteractionEnabled = true
                
           }
        
      
        
           
          
          
       
       

       }
       func create_Bg() -> SKSpriteNode { //Create a unique bg formed by two parts
        
           let l1_bg1 = SKSpriteNode(imageNamed: "\(r)-planet-background1") //Part one
           l1_bg1.anchorPoint = CGPoint(x:0.5,y:0.5)
           l1_bg1.position = CGPoint (x:0,y:size.height/2)
           l1_bg1.size = CGSize (width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
           //------------------------------------------------------------------------------------------//
           let l1_bg2 = SKSpriteNode(imageNamed: "\(r)-planet-background2") // Part two
           l1_bg2.anchorPoint = CGPoint(x:0.5,y:0.5)
           l1_bg2.position = CGPoint (x:(self.scene?.size.width)!,y:size.height/2)
           l1_bg2.size = CGSize (width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
           //------------------------------------------------------------------------------------------//
           let final_bg = SKSpriteNode() //Final bg
           final_bg.anchorPoint = CGPoint(x:0.5,y:0.5)
           final_bg.size = CGSize(width:l1_bg1.size.width+l1_bg2.size.width,height: l1_bg2.size.height)
           final_bg.position = CGPoint (x:size.width/2,y:size.height/2)
           final_bg.addChild(l1_bg1) // Add part one
           final_bg.addChild(l1_bg2) //Add part one
       
           return final_bg
       }
       
       func moveCamera () { //Camera's movement
       
           cameraNode.position += CGPoint(x:200,y:0)//Increment camera's position
           let movement_camera = SKAction.move(to: cameraNode.position, duration: 0.8) //Action to move the camera
           //------------------------------------------------------------------------------------------//
           enumerateChildNodes(withName: "background") { node, _ in //Enumerate each bg to work on it
                   let background = node as! SKSpriteNode
                   if  background.position.x + background.size.width < self.cameraRect.origin.x {
                       background.position = CGPoint(x: background.position.x + background.size.width*2-3,y: background.position.y)
                       background.zPosition = -1
                     }
           }
          //------------------------------------------------------------------------------------------//
          cameraNode.run(movement_camera) //Run the action to move the came
          
       }
       
       
       func createFullAstronaut() -> SKAction{
           var astro_texture : [SKTexture] = []
           for i in 2...4{
               astro_texture.append(SKTexture(imageNamed: "A\(i)"))
           }
           astro_texture.append(astro_texture[1])
           
           let astro_animation = SKAction.animate(with: astro_texture, timePerFrame: 0.1)
           
           return astro_animation
       }
      
        func roll() -> SKAction{
            var astro_texture : [SKTexture] = []
            astro_texture.append(SKTexture(imageNamed: "rotola"))
            var rolltime = SKAction.rotate(toAngle: 360, duration: 1.2)
            let astro_animation = SKAction.group([SKAction.animate(with: astro_texture, timePerFrame: 1.5),rolltime])
           
            return astro_animation
           
        }
       
       override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
             
           if (numb>0) {
               if( touches.count == 1) {
                      if  astro.position.y<200{
                       let up = SKAction.moveTo(y: astro.position.y+200,duration: 0.5)
                       let down = SKAction.moveTo(y: astro.position.y, duration: 0.7)
                       let size = SKAction.run {
                           self.astro.size = CGSize(width: 82 , height: 127)
                       }
                       let disable =  SKAction.run {
                           self.view?.isUserInteractionEnabled = false
                       }
                       let enable =  SKAction.run {
                                      self.view?.isUserInteractionEnabled = true
                                  }
                       let resize = SKAction.run {
                       self.astro.size = CGSize(width: 218 , height: 336)            }
                      
                       let reverseroll = SKAction.run {
                       self.astro.zRotation = 0
                       }
                       let jump = SKAction.sequence([size,disable,up,down,reverseroll,enable,resize,createFullAstronaut()])
                       let group = SKAction.group([roll(),jump])
                       astro.run(group)
                   
                    }
             }
            

          }
           if (numb == 0) {
             
            let touch:UITouch = touches.first!
             let positionInScene = touch.location(in: self)
             let touchedNode = self.atPoint(positionInScene)

             if let name = touchedNode.name
             {
                 if name == "shape1"
                 { self.backgroundMusicPlayer.stop()
                    NotificationCenter.default.post(name: NSNotification.Name("segue2"), object: nil)
                     backgroundMusicPlayer1.play()
                 }
                 else if name == "shape2" {
                    self.backgroundMusicPlayer.stop()
                   let lev = Level9()
                   lev.scaleMode = .resizeFill
                   self.view?.presentScene(lev)
                 }
                 else if name == "shape3" {
                    self.backgroundMusicPlayer.stop()
                   let lev = Level9()
                   lev.scaleMode = .resizeFill
                   self.view?.presentScene(lev)
               }
             }
               
           }
          
           
         
       
       }
       
       func spawnRock()  {
           if((numb>0) && (r == 7 || r == 8)) {
                  let random = CGFloat.random(min: 1, max: 3)
                  let rock : SKSpriteNode = SKSpriteNode (imageNamed: "\(r)-planet-ice\(random)")
                  rock.size = CGSize(width: 92, height: 111)
                  rock.position = CGPoint(x:cameraNode.position.x+500,y:35)
                  rock.zPosition = 2
                  rock.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rock.size.width-30, height: rock.size.height-10))
                  rock.physicsBody?.isDynamic = false
                  rock.physicsBody?.categoryBitMask = rock_value
                  rock.name = "rock"
                  addChild(rock)
                  
               let rip_rock = SKAction.run {
                   rock.removeFromParent()
               }
               run(SKAction.sequence([SKAction.wait(forDuration: 5.0),rip_rock]), withKey: "rip_rock")
           }
        if((numb>0) && (r == 5 || r == 6)) {
               let random = CGFloat.random(min: 1, max: 2)
               let rock : SKSpriteNode = SKSpriteNode (imageNamed: "\(r)-planet-gas\(random)")
               rock.size = CGSize(width: 92, height: 111)
               rock.position = CGPoint(x:cameraNode.position.x+500,y:35)
               rock.zPosition = 2
               rock.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rock.size.width-30, height: rock.size.height-10))
               rock.physicsBody?.isDynamic = false
               rock.physicsBody?.categoryBitMask = rock_value
               rock.name = "rock"
               addChild(rock)
               
            let rip_rock = SKAction.run {
                rock.removeFromParent()
            }
            run(SKAction.sequence([SKAction.wait(forDuration: 5.0),rip_rock]), withKey: "rip_rock")
        }
        if(numb>0 && numb_score<30 && r != 7 && r != 8 && r != 6 && r != 5) {
               let random = CGFloat.random(min: 1, max: 4)
               let rock : SKSpriteNode = SKSpriteNode (imageNamed: "\(r)-planet-rocks\(random)")
               rock.size = CGSize(width: 92, height: 111)
               rock.position = CGPoint(x:cameraNode.position.x+500,y:35)
               rock.zPosition = 2
               rock.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rock.size.width-30, height: rock.size.height-10))
               rock.physicsBody?.isDynamic = false
               rock.physicsBody?.categoryBitMask = rock_value
               rock.name = "rock"
               addChild(rock)
               
            let rip_rock = SKAction.run {
                rock.removeFromParent()
            }
            run(SKAction.sequence([SKAction.wait(forDuration: 5.0),rip_rock]), withKey: "rip_rock")
        }
       }
       
       func didBegin(_ contact: SKPhysicsContact) {
           if (contact.bodyB.node?.name == "rock") {
               damage()
                playSound(sound: sound_gameover)
              
           }
           else if (contact.bodyB.node?.name == "meteor") {
               damage()
                playSound(sound: sound_gameover)
           }
           if (contact.bodyB.node?.name == "collectible"){
               contact.bodyB.node?.removeFromParent()
               if numb_score >= 0 {
                   numb_score += 1
               score(numb_score: String(numb_score))
               playSound(sound: sound_coin)
               
               }
               else if numb_score == 5{
               
                
               }
           }
           
           
       }
               
       func setAstro(){
         let actions = SKAction.run {
                                     self.astro.physicsBody?.isDynamic = true
                                     self.astro.zRotation = 0
                                 }
             run(SKAction.sequence([SKAction.wait(forDuration: 2.5),actions]))

           
       }
       
       func spawnCollectibles(){
           if(numb>0) {
               let random = CGFloat.random(min: 50, max: 300)
               let rand = CGFloat.random(min:cameraNode.position.x+200,max:cameraNode.position.x+500)
               let collectible : SKSpriteNode = SKSpriteNode(imageNamed: "money8-1")
               collectible.run(SKAction.repeatForever(createFullCoin()),withKey:"collectible")
               collectible.size = CGSize(width: 50, height: 51)
               collectible.position = CGPoint(x:rand,y:random)
               collectible.zPosition = 3
               collectible.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: collectible.size.width-30, height: collectible.size.height-10))
               collectible.physicsBody?.isDynamic = false
               collectible.physicsBody?.categoryBitMask = rock_value
               collectible.name = "collectible"
               addChild(collectible)
         }     }
       func lifesF(number: String) {
           print("Gameplay-life\(number)")
           lifes = SKSpriteNode(imageNamed: "Gameplay-life\(number)")
           lifes.size = CGSize(width: 163, height: 29)
           lifes.zPosition = 3
           addChild(lifes)
           
       }
       
       func score(numb_score: String) {
           
           label.text = "Score : \(numb_score)"
           label.fontSize = 40
           label.zPosition = 3
       
       }
       
       func createFullMeteor() -> SKAction {
           var meteor_texture : [SKTexture] = []
           for i in 1...5{
               meteor_texture.append(SKTexture(imageNamed: "meteor\(i)"))
           }
           meteor_texture.append(meteor_texture[1])
           
        let meteor_animation = SKAction.animate(with: meteor_texture, timePerFrame: 0.07)
        
           
           return meteor_animation
       
       }
       
       func spawnMeteor() {
           if (numb>0 && numb_score<30) {
           let random = CGFloat.random(min:200,max:astro.position.y+200)
            let meteor : SKSpriteNode = SKSpriteNode(imageNamed: "meteor1")
            meteor.name = "meteor"
            meteor.size = CGSize(width: 100, height: 44)
            meteor.zPosition = 3
            meteor.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: meteor.size.width, height: meteor.size.height))
            meteor.physicsBody?.isDynamic = false
            meteor.physicsBody?.categoryBitMask = rock_value
            meteor.run(SKAction.repeatForever(createFullMeteor()),withKey:"meteor")
            meteor.position = CGPoint(x:cameraNode.position.x+1000,y:random)
            meteor.run(SKAction.moveTo(x: meteor.position.x-1000, duration: 3.0))
            addChild(meteor)
              
                         
         }
       }
       func damage() {
           astro.physicsBody?.isDynamic = false
        let damage_astro = SKAction.colorize(with: .red, colorBlendFactor: 5, duration:0.3)
               astro.run(SKAction.sequence([damage_astro,damage_astro.reversed(),damage_astro,damage_astro.reversed(),damage_astro,damage_astro.reversed()]))
                          if (numb <= 0){
                                 
                                 addChild(gameover)
                                 numb = 0
                                 lifes.removeFromParent()
                                 run(SKAction.wait(forDuration: 3.0), withKey: "wait")
                                 lifesF(number: String(numb))
                                 backgroundMusicPlayer.stop()
                                  self.view?.isUserInteractionEnabled = true
                                 
                                
                          }
                          else if(numb > 0){
                                 numb -= 1
                                 lifes.removeFromParent()
                                 lifesF(number: String(numb))
                          }
           
           
       }
       func createFullCoin() -> SKAction {
           var coin_texture : [SKTexture] = []
           for i in 1...4{
               coin_texture.append(SKTexture(imageNamed: "money8-\(i)"))
           }
           coin_texture.append(coin_texture[0])
           
           let coin_animation = SKAction.animate(with: coin_texture, timePerFrame: 0.08)
           
           return coin_animation
       
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
       
       func playSound(sound: SKAction){
           
           run(sound)
       }
}
