//
//  ViewController.swift
//  Simon
//
//  Created by Komari Herring on 9/21/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

import UIKit


import AVFoundation

class ViewController: UIViewController
{
    //animation
    var audioPlayer:AVAudioPlayer!
    var delayedTimer = 0.9 //seconds
    var timer: Timer!
    
    var keepPlaying = true
    var hasLostYet = false
    
    var theIndex = 0
    var simonIndex = -1
    
    //BOOL
    var isSimonsTurn = false
    var isPlayerTurn = false
    
    enum ColorInt: Int
    {
        case redColor = 1
        case greenColor
        case blueColor
        case yellowColor
        
    }
    
    var playerChoice = [ColorInt]()
    
    var computerChoice = [ColorInt]()
    
    var simonArray = [UIButton]()
    
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    
    @IBOutlet weak var gameStatusLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var lastGameLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        gameStatusLabel.text = "Simon Says!"
        view.backgroundColor = UIColor.black
        
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK - Beginning of game
    
    @IBAction func startGameTapped(_ sender: UIButton)
    {
        scoreLabel.text = "Score:"
        
        keepPlaying = true
        simonGoes()
        
    }
    
    // MARK - Button Actions Handled
    
    @IBAction func yellowTapped(_ sender: UIButton)
    {
        animateButtonPress(sender)
        playerChoice.append(.yellowColor)
        checkForLoser()
        theIndex = theIndex + 1
        if playerChoice.count == computerChoice.count
        {
            scoreLabel.text = "Score: \(computerChoice.count)"
            simonGoes()
            theIndex = 0
        }
        print("Player's Stuff")
        print(playerChoice)
    }
    
    @IBAction func blueTapped(_ sender: UIButton)
    {
        animateButtonPress(sender)
        playerChoice.append(.blueColor)
        checkForLoser()
        theIndex = theIndex + 1
        
        if playerChoice.count >= computerChoice.count
        
        {
            scoreLabel.text = "Score: \(computerChoice.count)"
            simonGoes()
            theIndex = 0
        }
        print("Player's Stuff")
        print(playerChoice)
    }
    
    @IBAction func redTapped(_ sender: UIButton)
    {
        animateButtonPress(sender)
        playerChoice.append(.redColor)
        checkForLoser()
        theIndex = theIndex + 1
        if playerChoice.count == computerChoice.count
        {
            scoreLabel.text = "Score: \(computerChoice.count)"
            simonGoes()
            theIndex = 0
        }
        
        print("Player")
        
        print(playerChoice)
        
    }
    
    
    @IBAction func greenTapped(_ sender: UIButton)
    {
        animateButtonPress(sender)
        playerChoice.append(.greenColor)
        checkForLoser()
        theIndex = theIndex + 1
        if playerChoice.count == computerChoice.count
        {
            scoreLabel.text = "Score: \(computerChoice.count)"
            simonGoes()
            theIndex = 0
        }
        print("Player's Stuff")
        print(playerChoice)
        
    }
    
    // MARK - Simon logic
    
    func simonGoes()
    {
        if keepPlaying == true
        {
            
            let newInt =  arc4random_uniform(4) + 1
            var simonColor: ColorInt
            switch newInt
            {
            case 1:
                simonColor = .redColor
                computerChoice.append(simonColor)
                simonArray.append(redButton)
            case 2:
                simonColor = .greenColor
                computerChoice.append(simonColor)
                simonArray.append(greenButton)
            case 3:
                simonColor = .blueColor
                computerChoice.append(simonColor)
                simonArray.append(blueButton)
            case 4:
                simonColor = .yellowColor
                computerChoice.append(simonColor)
                simonArray.append(yellowButton)
            default:
                print("no color")
                
            }
            
            timer = Timer.scheduledTimer(timeInterval: delayedTimer, target: self, selector: #selector(simonAnimates), userInfo: nil, repeats: true)
            
            print("Simon")
            
            print(computerChoice)
            
            clearPlayerArray()
            simonIndex = -1
            
        }
    }
    
    func simonAnimates()
    {
        simonIndex = simonIndex + 1
        if simonIndex < computerChoice.count
        {
            animateButtonPress(simonArray[simonIndex])
        }
        else
        {
            timer.invalidate()
        }
    }
    
    
    
    
    func clearPlayerArray()
    {
        playerChoice = []
    }
    
    
    // MARK - Check for loser
    
    func checkForLoser()
    {
        if playerChoice[theIndex] == computerChoice[theIndex]
        {
            
            print("Good start!")
        }
        else
        {
            let audioFilePath = Bundle.main.path(forResource: "loserSound", ofType: "mp3")
            if audioFilePath != nil {
                let audioFileUrl = NSURL.fileURL(withPath: audioFilePath!)
                do {
                    audioPlayer =  try AVAudioPlayer(contentsOf: audioFileUrl)
                } catch let error1 as NSError {
                    print(error1)
                }
            }
            audioPlayer.play()
            lastGameLabel.text = "Last Game \(scoreLabel.text!)"
            playerChoice = []
            computerChoice = []
            simonArray = []
            
            theIndex = 0
            simonIndex = -1
            keepPlaying = false
            
            
            timer.invalidate()
            
            
        }
    }
    
    // MARK - Button Animation
    
    func animateButtonPress(_ button: UIButton)
    {
        let tempColor = button.backgroundColor
        
        let audioName = button.title(for: .normal)!
        
        let audioFilePath = Bundle.main.path(forResource: audioName, ofType: "mp3")
        if audioFilePath != nil {
            let audioFileUrl = NSURL.fileURL(withPath: audioFilePath!)
            do {
                audioPlayer =  try AVAudioPlayer(contentsOf: audioFileUrl)
            } catch let error1 as NSError {
                print(error1)
            }
        }
        audioPlayer.play()
        button.backgroundColor = UIColor.white
        UIView.animate(withDuration: 0.3) {
            button.backgroundColor = tempColor!
        }
        
        //return nil
        
    }
    
    //SOUNDS FROM GREG
    
    
    
    
    
    
}

