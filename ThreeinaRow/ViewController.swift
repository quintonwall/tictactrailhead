

import UIKit
import AVFoundation

class ViewController: UIViewController
{
    // @IBOutlets
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var PlayerTurnsLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    
    var audioPlayer = AVAudioPlayer()
    

    var goNumber = 1
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var winningCombinations = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    var winner = 0
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        playAgainButton.alpha = 0

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        NSLog("WILL APPEAR")
        if appDelegate.sdsEnabled {
            NSLog("SDS ON!")
            label.font = UIFont.sdsFontLightWithSize(SDSFontSizeType.SDSFontSizeXxLarge);
           PlayerTurnsLabel.font = UIFont.sdsFontLightWithSize(SDSFontSizeType.SDSFontSizeXLarge);
        }
        else{
            NSLog("SDS OFF!")
            label.font = UIFont.systemFontOfSize(24);
            PlayerTurnsLabel.font = UIFont.systemFontOfSize(24);
        }
        updateButtons()
    }
    
    override func viewDidAppear(animated: Bool)
    {
        label.center = CGPointMake(label.center.x - 400, label.center.y)

    }
    

    @IBAction func buttonPressed(sender: UIButton)
    {
         popDrop()
        
        if gameState[sender.tag] == 0 && winner == 0
        {
            var image = UIImage()
            
            if goNumber % 2 == 0
            {
                image = getButtonImage(2)
/*
                if appDelegate.sdsEnabled {
                    image = UIImage.sdsIconStandard(SDSIconStandardType.Approval, withSize: 70)
                }
                else{
                    image = UIImage(named: "fire300.png")!
                }
*/
                
                gameState[sender.tag] = 2

                PlayerTurnsLabel.text = "It's Racoon's Turn"
            }
            else
            {
/*
                if appDelegate.sdsEnabled {
                    image = UIImage.sdsIconCustom(SDSIconCustomType.Custom1, withSize: 70)
                }
                else{
                    image = UIImage(named: "racoon-nocircle.png")!
                }
*/
                image = getButtonImage(1)
                gameState[sender.tag] = 1
                PlayerTurnsLabel.text = "It's Fire's Turn"
                
            }
            
            for combination in winningCombinations
            {
                if gameState[combination[0]] == gameState[combination[1]] &&
                   gameState[combination[0]] == gameState[combination[2]] &&
                   gameState[combination[0]] != 0
                {
                    winner = gameState[combination[0]]
                }
            }
            
            if winner != 0
            {
                someOneWon()
                self.label.transform = CGAffineTransformMakeTranslation(-350, 0)
                springWithDelay(0.9, delay: 0.2, animations: {
                    self.label.transform = CGAffineTransformMakeTranslation(0, 0)
                })

                
                if winner == 1
                {
                    label.text = "Racoon has won!"
                    PlayerTurnsLabel.text = ""
                }
                else
                {
                    label.text = "Fire has won!"
                    PlayerTurnsLabel.text = ""
                }
                
                UIView.animateWithDuration(0.5, animations:
                {

                    self.label.hidden = false
              
                    self.playAgainButton.alpha = 1
                    
                    self.playAgainButton.transform = CGAffineTransformMakeTranslation(0, -450)
                    springWithDelay(0.9, delay: 0.2, animations: {
                        self.playAgainButton.transform = CGAffineTransformMakeTranslation(0, 0)
                    })
                }
                )
            }           
            
            goNumber++
            sender.setImage(image, forState: UIControlState.Normal)
            
            if goNumber == 10 && winner == 0
            {
                NoOneWon()
                label.text = "No winner!"
                UIView.animateWithDuration(0.5, animations:
                {
                    self.label.hidden = false
                    self.label.center = CGPointMake(self.label.center.x + 400, self.label.center.y)
                    self.playAgainButton.alpha = 1
                    self.PlayerTurnsLabel.text = ""
                }
                )
            }
        }
    }
    
    func startNew() {
        
        let alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("chime_short_chord_up", ofType: "wav")!)
        print(alertSound)
        var error:NSError?
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: alertSound)
        } catch let error1 as NSError {
            error = error1
            //audioPlayer = nil
        }
        audioPlayer.prepareToPlay()
        audioPlayer.play()

        PlayerTurnsLabel.text = "Get 3 in a Row to Win"
        
    }
    
    func popDrop() {
        
        let alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("pop_drip", ofType: "wav")!)
        print(alertSound)
        var error:NSError?
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: alertSound)
        } catch let error1 as NSError {
            error = error1
            //audioPlayer = nil
        }
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        
    }
    
    func someOneWon() {
        
        let alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("music_marimba_chord", ofType: "wav")!)
        print(alertSound)
        var error:NSError?
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: alertSound)
        } catch let error1 as NSError {
            error = error1
            //audioPlayer = nil
        }
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        
    }
    
    
    func NoOneWon() {
        
        let alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("AndNow", ofType: "wav")!)
        print(alertSound)
        var error:NSError?
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: alertSound)
        } catch let error1 as NSError {
            error = error1
            //audioPlayer = nil
        }
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        
    }
    
    func getButtonImage(value:Int) -> UIImage{
        var image = UIImage()
        
        if value == 2
        {
            if appDelegate.sdsEnabled {
                image = UIImage.sdsIconStandard(SDSIconStandardType.Approval, withSize: 70)
            }
            else{
                image = UIImage(named: "fire300.png")!
            }
            
        }
        else if value == 1
        {
            if appDelegate.sdsEnabled {
                image = UIImage.sdsIconCustom(SDSIconCustomType.Custom1, withSize: 70)
            }
            else{
                image = UIImage(named: "racoon-nocircle.png")!
            }
            
        }
        return image
    }
    
    func updateButtons()
    {
        button0.setImage(getButtonImage(gameState[0]), forState: UIControlState.Normal)
        button1.setImage(getButtonImage(gameState[1]), forState: UIControlState.Normal)
        button2.setImage(getButtonImage(gameState[2]), forState: UIControlState.Normal)
        button3.setImage(getButtonImage(gameState[3]), forState: UIControlState.Normal)
        button4.setImage(getButtonImage(gameState[4]), forState: UIControlState.Normal)
        button5.setImage(getButtonImage(gameState[5]), forState: UIControlState.Normal)
        button6.setImage(getButtonImage(gameState[6]), forState: UIControlState.Normal)
        button7.setImage(getButtonImage(gameState[7]), forState: UIControlState.Normal)
        button8.setImage(getButtonImage(gameState[8]), forState: UIControlState.Normal)
    }
    
    
    @IBAction func playAgainButtonPressed(sender: UIButton)
    {
        
        startNew()
        goNumber = 1
        winner = 0
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        label.hidden = true
        playAgainButton.alpha = 0

        updateButtons()
/*
        button0.setImage(nil, forState: UIControlState.Normal)
        button1.setImage(nil, forState: UIControlState.Normal)
        button2.setImage(nil, forState: UIControlState.Normal)
        button3.setImage(nil, forState: UIControlState.Normal)
        button4.setImage(nil, forState: UIControlState.Normal)
        button5.setImage(nil, forState: UIControlState.Normal)
        button6.setImage(nil, forState: UIControlState.Normal)
        button7.setImage(nil, forState: UIControlState.Normal)
        button8.setImage(nil, forState: UIControlState.Normal)
*/
    }
}
    

