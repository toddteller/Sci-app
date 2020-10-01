
//
//  ViewController2.swift
//  Sci-app
//
//  Created by Lorenzo Montenero on 19/11/2019.
//  Copyright © 2019 Lorenzo Montenero. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController2: UIViewController {

    @IBOutlet weak var glossaryButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    
    @IBOutlet weak var planet1: UIButton!
    @IBOutlet weak var planet2: UIButton!
    @IBOutlet weak var planet3: UIButton!
    @IBOutlet weak var planet4: UIButton!
    @IBOutlet weak var planet5: UIButton!
    @IBOutlet weak var planet6: UIButton!
    @IBOutlet weak var planet7: UIButton!
    @IBOutlet weak var planet8: UIButton!
    @IBOutlet weak var planet9: UIButton!
        
    var descriptionPlanet: [UIImage] = [
        UIImage(named: "planet1")!,
        UIImage(named: "planet2")!,
        UIImage(named: "planet3")!,
        UIImage(named: "planet4")!,
        UIImage(named: "planet5")!,
        UIImage(named: "planet6")!,
        UIImage(named: "planet7")!,
        UIImage(named: "planet8")!,
        UIImage(named: "planet9")!]
    
    
    var descriptionImage: UIImage!
    var descriptionImageView: UIImageView!
    let playButton = UIButton()
    let backToThePlanetsButton = UIButton()
    let darkerView = UIView()
    var bol : Bool = false
    var name_button : String = ""
    @objc var buttonSound: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Hidding  back  button of the navigation  controller
        self.navigationItem.hidesBackButton =  true
        
        

        assignbackground()
    }
    
//      Setup of background
    func assignbackground(){
        let background = UIImage(named: "backgroundImage")

        var imageView: UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }

    @IBAction func planetPressed(_ sender: UIButton) {
        
//      Darking the background

        darkerView.backgroundColor = .black
        darkerView.frame = CGRect(x: 0, y: 0, width: 600, height: 1000)
        darkerView.alpha = 0.3
                 
        view.addSubview(darkerView)
        
//      Hidding achievements and how to play buttons
        
        glossaryButton.isHidden = true
        backButton.isHidden = true
        
        
//      Appearance of description
        
        descriptionImage = UIImage(named: sender.currentTitle!)
        descriptionImageView = UIImageView(image: descriptionImage)
        descriptionImageView.frame = CGRect(x: 35, y: 265, width: 345, height: 310)
        descriptionImageView.alpha = 0.95
        
        view.addSubview(descriptionImageView)
        
//      Disabling buttons
        planet1.isEnabled = false
        planet2.isEnabled = false
        planet3.isEnabled = false
        planet4.isEnabled = false
        planet5.isEnabled = false
        planet6.isEnabled = false
        planet7.isEnabled = false
        planet8.isEnabled = false
        planet9.isEnabled = false
        backButton.isEnabled = false
        glossaryButton.isEnabled = false
        

//      button.addTarget(self, action: "Action:", forControlEvents:UIControlEvents.TouchUpInside)
//      menuView.addSubview(button)
        
//      Appearance of play and back buttons
        playButton.setTitle(sender.currentTitle, for: .normal)
        playButton.titleLabel?.alpha = 0
        playButton.frame = CGRect(x: 60, y: 625, width: 290, height: 80)
        let playButtonImage = UIImage(named: "playButtonImage")
        playButton.setBackgroundImage(playButtonImage, for: UIControl.State.normal)
        view.addSubview(playButton)
        playButton.addTarget(self, action: #selector(playAction), for: .touchUpInside)
        playButton.addTarget(self, action: #selector(buttonSound2), for: .touchUpInside)
        playButton.addTarget(self, action: #selector(moveToAstronomy), for: .touchUpInside)
        
        backToThePlanetsButton.frame = CGRect(x: 77, y: 759, width: 260, height: 49)
        let backButtonImage = UIImage(named: "backButtonImage")
        
        backToThePlanetsButton.setBackgroundImage(backButtonImage, for: UIControl.State.normal)
        view.addSubview(backToThePlanetsButton)
        backToThePlanetsButton.addTarget(self, action: #selector(backToThePlanets), for: .touchUpInside)
        backToThePlanetsButton.addTarget(self, action: #selector(buttonSound2), for: .touchUpInside)

}
    @objc func backToThePlanets() {
        
//      Removing of description, 2 buttons, darkerView
        descriptionImageView.removeFromSuperview()
        playButton.removeFromSuperview()
        backToThePlanetsButton.removeFromSuperview()
        darkerView.removeFromSuperview()
        
//      Showing achievements and how to play buttons
        glossaryButton.isHidden = false
        backButton.isHidden = false
        
//      Enabling buttons
        planet1.isEnabled = true
        planet2.isEnabled = true
        planet3.isEnabled = true
        planet4.isEnabled = true
        planet5.isEnabled = true
        planet6.isEnabled = true
        planet7.isEnabled = true
        planet8.isEnabled = true
        planet9.isEnabled = true
        backButton.isEnabled = true
        glossaryButton.isEnabled = true
        bol = false
    }
    
    @IBAction func backToGames(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func playAction(){
        backgroundMusicPlayer1.stop()
        
    }
    @objc func moveToAstronomy() {
            bol = true
           name_button = playButton.currentTitle ?? ""
           self.performSegue(withIdentifier: "toAstronomy", sender: nil)
       }
       
    
    @IBAction func buttonSound(_ sender: UIButton) {
        let pathToSound = Bundle.main.path(forResource: "buttonsound", ofType: "mp3")!
        let url = URL(fileURLWithPath: pathToSound)
        do {
            buttonSound = try AVAudioPlayer(contentsOf: url)
            buttonSound?.play()
        } catch {
            
        }
    }
    
    @objc func buttonSound2() {
        let pathToSound = Bundle.main.path(forResource: "buttonsound", ofType: "mp3")!
        let url = URL(fileURLWithPath: pathToSound)
        do {
            buttonSound = try AVAudioPlayer(contentsOf: url)
            buttonSound?.play()
        } catch {
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if bol == true {
    let vc = segue.destination as! ViewControllerAstronomy
    vc.name_button = name_button
       }
    }
    override func viewDidAppear(_ animated: Bool) {
         UIDevice.current.setValue(UIDeviceOrientation.portrait.rawValue, forKey: "orientation")
        
    }
    override func viewWillAppear(_ animated: Bool) {
             UIDevice.current.setValue(UIDeviceOrientation.portrait.rawValue, forKey: "orientation")
    }
  
}
