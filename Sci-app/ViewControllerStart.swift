//
//  ViewControllerStart.swift
//  Sci-app
//
//  Created by Lorenzo Montenero on 23/11/2019.
//  Copyright © 2019 Lorenzo Montenero. All rights reserved.
//

import UIKit
import AVFoundation


var backgroundMusicPlayer1: AVAudioPlayer!

class ViewControllerStart: UIViewController {
    
//       Variables for background music
    var music: AVAudioPlayer?
    let optionDefaults = UserDefaults.standard
    
    
    var imageView: UIImageView!
    var hangover_image :UIImage!
    var hangoverView: UIImageView!
    var appTitle_image: UIImage!
    var appTitleView: UIImageView!
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        Hidding the navigation controller
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
       
        assignbackground()
//        Insert background music
        playBackgroundMusic(filename: "soundtrackmenu.wav")
       
  
        
        hangover_image = UIImage(named: "Hangover team LOGO")
        hangoverView = UIImageView(image: hangover_image)
        hangoverView.frame = CGRect(x: 105, y: 300, width: 200, height: 250)

        view.addSubview(hangoverView)
        
        appTitle_image = UIImage(named: "appTitle")
        appTitleView = UIImageView(image: appTitle_image)
        appTitleView.frame = CGRect(x: 75, y: 280, width: 250, height: 250)
        self.appTitleView.alpha = 0.0
        
        view.addSubview(appTitleView)
        
        UIView.animate(withDuration: 2.0, delay: 1, animations: {
        self.hangoverView.alpha = 0.0
                     })
        
        UIView.animate(withDuration: 2.5, delay: 2.4, animations: {
        self.appTitleView.alpha = 1.0
             })
//      Delay for segue1
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) { [unowned self] in
            self.performSegue(withIdentifier: "Segue1", sender: nil)
           
            }
        
        }
    
    func assignbackground(){
        
        let background = UIImage(named: "backgroundStart")

        
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
   func playBackgroundMusic(filename: String) {
    let resourceUrl = Bundle.main.url(forResource:
        filename, withExtension: nil)
      guard let url = resourceUrl else {
        print("Could not find file: \(filename)")
    return
    }

       do {
         try backgroundMusicPlayer1 = AVAudioPlayer(contentsOf: url)
           backgroundMusicPlayer1.numberOfLoops = -1
           backgroundMusicPlayer1.prepareToPlay()
           backgroundMusicPlayer1.play()
         } catch {
           print("Could not create audio player!")
       return
       }
       
   }
}
