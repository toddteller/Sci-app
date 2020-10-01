
//
//  ViewController3.swift
//  Sci-app
//
//  Created by Lorenzo Montenero on 19/11/2019.
//  Copyright © 2019 Lorenzo Montenero. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController3: UIViewController {
    
    @IBOutlet weak var glossaryButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var level1: UIButton!
    @IBOutlet weak var level2: UIButton!
    @IBOutlet weak var level3: UIButton!
    @IBOutlet weak var level4: UIButton!
    @IBOutlet weak var level5: UIButton!
    @IBOutlet weak var level6: UIButton!
    @IBOutlet weak var level7: UIButton!
    @IBOutlet weak var level8: UIButton!
    @IBOutlet weak var level9: UIButton!
    
    
    var descriptionLevel: [UIImage] = [
        UIImage(named: "level1")!,
        UIImage(named: "level2")!,
        UIImage(named: "level3")!,
        UIImage(named: "level4")!,
        UIImage(named: "level5")!,
        UIImage(named: "level6")!,
        UIImage(named: "level7")!,
        UIImage(named: "level8")!,
        UIImage(named: "level9")!]   //Need to add another level/description
    
    
    var descriptionImage: UIImage!
    var descriptionImageView: UIImageView!
    let playButton = UIButton()
    let backToThePlanetsButton = UIButton()
    let darkerView = UIView()
    var name_button :String = ""
    var buttonSound: AVAudioPlayer?
    var bol : Bool = false
    
    
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
        
        playButton.setTitle(sender.currentTitle, for: .normal)
        playButton.titleLabel?.alpha = 0
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
        level1.isEnabled = false
        level2.isEnabled = false
        level3.isEnabled = false
        level4.isEnabled = false
        level5.isEnabled = false
        level6.isEnabled = false
        level7.isEnabled = false
        level8.isEnabled = false
        level9.isEnabled = false
        backButton.isEnabled = false
        glossaryButton.isEnabled = false
        

//      button.addTarget(self, action: "Action:", forControlEvents:UIControlEvents.TouchUpInside)
//      menuView.addSubview(button)
        
//      Appearance of play and back buttons
        
        playButton.frame = CGRect(x: 60, y: 625, width: 290, height: 80)
        let playButtonImage = UIImage(named: "playButtonImage")
        playButton.setBackgroundImage(playButtonImage, for: UIControl.State.normal)
        view.addSubview(playButton)
        playButton.addTarget(self, action: #selector(playAction), for: .touchUpInside)
        playButton.addTarget(self, action: #selector(buttonSound2), for: .touchUpInside)
        playButton.addTarget(self, action: #selector(moveToChemistry), for: .touchUpInside)

        backToThePlanetsButton.frame = CGRect(x: 77, y: 756, width: 260, height: 49)
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
        level1.isEnabled = true
        level2.isEnabled = true
        level3.isEnabled = true
        level4.isEnabled = true
        level5.isEnabled = true
        level6.isEnabled = true
        level7.isEnabled = true
        level8.isEnabled = true
        level9.isEnabled = true
        backButton.isEnabled = true
        glossaryButton.isEnabled = true
        bol = false
       
    }
    
    
    @IBAction func backToGames(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
       
    }
    
    @objc func playAction(){
        backgroundMusicPlayer1.stop()
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
    @objc func moveToChemistry() {
         bol = true
        name_button = playButton.currentTitle ?? ""
        self.performSegue(withIdentifier: "toChemistry", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if bol == true {
        var vc = segue.destination as! ViewControllerChemistry
        vc.name_button = name_button
        }
    }
}
