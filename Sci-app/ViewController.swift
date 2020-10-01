//
//  ViewController.swift
//  Sci-app
//
//  Created by Lorenzo Montenero on 18/11/2019.
//  Copyright © 2019 Lorenzo Montenero. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var astronomyButton: UIButton!
    @IBOutlet weak var chemistryButton: UIButton!
    
    var buttonSound: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        Hidding  back  button of the navigation  controller
        self.navigationItem.hidesBackButton =  true
        
//      Setup background image
        assignbackground()
        
//      Setup Astronomy Button
        astronomyButton.layer.shadowColor = UIColor.gray.cgColor
        astronomyButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        astronomyButton.layer.shadowRadius = 5
        astronomyButton.layer.shadowOpacity = 0.5
        
//      Setup Astronomy Button
        chemistryButton.layer.shadowColor = UIColor.gray.cgColor
        chemistryButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        chemistryButton.layer.shadowRadius = 5
        chemistryButton.layer.shadowOpacity = 0.5
    }
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
    
    @IBAction func buttonSound(_ sender: UIButton) {
        
        let pathToSound = Bundle.main.path(forResource: "buttonsound", ofType: "mp3")!
        let url = URL(fileURLWithPath: pathToSound)
        do {
            buttonSound = try AVAudioPlayer(contentsOf: url)
            buttonSound?.play()
        } catch {
            
        }
    }
}

