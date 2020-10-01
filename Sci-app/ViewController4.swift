
import UIKit
import AVFoundation

class ViewController4: UIViewController {
    
    
    @IBOutlet weak var backToPlanetButton: UIButton!
    
    var buttonSound: AVAudioPlayer?

    override func viewDidLoad() {
       
        super.viewDidLoad()

        assignbackground()
        
//        Hidding  back  button of the navigation  controller
        self.navigationItem.hidesBackButton =  true
    }
    //      Setup of background
    func assignbackground(){
        let background = UIImage(named: "backgroundGlossaryPlanet")

        var imageView: UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
   @IBAction func backToLevel(_ sender: UIButton) {
          self.dismiss(animated: true, completion: nil)
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
