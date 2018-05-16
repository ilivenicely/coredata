//
//  ViewController.swift
//  MccormickRob_CE55
//
//  Created by Robert  McCormick on 15/01/2018.
//  Copyright © 2018 Robert  McCormick. All rights reserved.
//


import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet var  ipadContForView: [UIImageView]!
    @IBOutlet var iphoneView: [UIImageView]!
    @IBOutlet var iphoneBackViews: [UIImageView]!
    @IBOutlet var ipadCont: [UIView]!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrange()
    }
    
    var timer = Timer()
    var phonePairs = [Int:UIImage]()
    @objc var amount = 0
    var pairsAmount = 0
    var padPairs = [Int:UIImage]()
    var pairs = [UIImageView]()
    var containsTag1 = 0
    var containsTag2 = 0
    var numberOfTurns = 0
    var playerName = "Player"
    
    //action begins game, setting play button as false,chooses format
    func showInputAlert(){
        let alertForName = UIAlertController(title: "Puzzle Game", message: "Please input your name", preferredStyle: .alert)
        alertForName.addTextField { (textField) in
            textField.placeholder = "Player name"
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            let nameTextField = alertForName.textFields![0] as UITextField
            
            if nameTextField.text != "" {
                self.playerName = nameTextField.text!
                self.startGame()
            } else {
                self.showInputAlert()
            }
        }
        alertForName.addAction(okAction)
        
        self.present(alertForName, animated: true, completion: nil)
    }
    @IBAction func playGame(_ sender: UIButton) {
        showInputAlert()
    }
    func startGame(){
        numberOfTurns = 0
        timer = Timer(timeInterval: 1.0, target: self, selector: #selector(self.count), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)
        playButton.isEnabled = false
        playButton.setTitle("", for: .disabled)
        
        switch (UIDevice.current.userInterfaceIdiom){
        case .pad :
            _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(ipadFlash), userInfo: nil, repeats: false)
            
            for itemsViews in  ipadContForView{
                
                if itemsViews.tag < 30 {
                    itemsViews.image = padPairs[itemsViews.tag]
                }
                
            }
        case .phone :
            
            _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(iphoneShow), userInfo: nil, repeats: false)
            
            for (view,itemsViews) in zip(iphoneBackViews,iphoneView){
                
                if itemsViews.tag < 20 {
                    view.image = phonePairs[itemsViews.tag]
                    itemsViews.image = padPairs[itemsViews.tag]
                }
            }
        default: print ("error")
        }
    }
    
    //select flashcard right or wrong
    @objc func imageSelected(tapGestureRecognizer: UITapGestureRecognizer)
    {
        numberOfTurns += 1
        if UIDevice.current.userInterfaceIdiom == .pad
        {
            //?
            let view = tapGestureRecognizer.view
            print(view!.tag)
            if pairs.count == 0{
                ipadContForView[(view?.tag)!].image = padPairs[(view?.tag)!]
                containsTag1 = (view?.tag)!
                pairs.append( ipadContForView[(view?.tag)!])
            }
            else if pairs.count == 1{
                ipadContForView[(view?.tag)!].image = padPairs[(view?.tag)!]
                sleep(UInt32(0.5))
                containsTag2 = (view?.tag)!
                pairs.append( ipadContForView[(view?.tag)!])
                _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: false)
            }
        }
            
        else if UIDevice.current.userInterfaceIdiom == .phone
        {
            let view = tapGestureRecognizer.view
            if pairs.count == 0{
                iphoneView[(view?.tag)!].image = phonePairs[(view?.tag)!]
                containsTag1 = (view?.tag)!
                pairs.append(iphoneView[(view?.tag)!])
            }
            else if pairs.count == 1{
                iphoneView[(view?.tag)!].image = phonePairs[(view?.tag)!]
                sleep(UInt32(0.3))
                containsTag2 = (view?.tag)!
                pairs.append(iphoneView[(view?.tag)!])
                _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: false)
            }
        }
    }
    
    //cooridinate sets
    func arrange(){
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            let iphoneMatchSet1:[UIImage] = [#imageLiteral(resourceName: "Garlic-2"),#imageLiteral(resourceName: "Grape-1"),#imageLiteral(resourceName: "Eye"),#imageLiteral(resourceName: "Chainsaw"),#imageLiteral(resourceName: "Katana-1"),#imageLiteral(resourceName: "Rope"),#imageLiteral(resourceName: "Vault"),#imageLiteral(resourceName: "Flame"),#imageLiteral(resourceName: "Green Magic"),#imageLiteral(resourceName: "Treasure Chest")];
            var iphoneMatchSet2 = [UIImage]()
            iphoneMatchSet2 = iphoneMatchSet1
            let iphoneArray1:[Int] = [0,1,2,3,4,5,6,7,8,9]
            let iphoneArray2:[Int] = [10,11,12,13,14,15,16,17,18,19]
            let shuffledIphoneArray1 = shuffle(deckShuffled: iphoneArray1)
            let shuffledIphoneArray2 = shuffle(deckShuffled: iphoneArray2)
            for view in ipadCont
            {
                view.layer.cornerRadius = 15
                view.layer.masksToBounds = true
                view.layer.shouldRasterize = true
            }
            for (view,num) in zip(iphoneMatchSet1,shuffledIphoneArray1)
            {
                phonePairs[num] = view
            }
            for (view,num) in zip(iphoneMatchSet2,shuffledIphoneArray2)
            {
                phonePairs[num] = view
            }
            for view in iphoneView
            {
                view.image = #imageLiteral(resourceName: "Memory")
            }
        }
        else  if UIDevice.current.userInterfaceIdiom == .pad
        {
            let pairsForIpad = [#imageLiteral(resourceName: "Construction Helmet-1"),#imageLiteral(resourceName: "Garlic"),#imageLiteral(resourceName: "Gold"),#imageLiteral(resourceName: "Blue Mineral"),#imageLiteral(resourceName: "Saw"),#imageLiteral(resourceName: "Eye"),#imageLiteral(resourceName: "Zombie"),#imageLiteral(resourceName: "Flame"),#imageLiteral(resourceName: "Green Magic"),#imageLiteral(resourceName: "Treasure Chest"),#imageLiteral(resourceName: "Vault"),#imageLiteral(resourceName: "Casino Chip"),#imageLiteral(resourceName: "Rope"),#imageLiteral(resourceName: "Das Cool"),#imageLiteral(resourceName: "Blue Magic")];
            var ipadMatchSet2 = [UIImage]()
            ipadMatchSet2 = pairsForIpad
            let arrayForIpad:[Int] = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
            let arrayForIpad2:[Int] = [15,16,17,18,19,20,21,22,23,24,25,26,27,28,29]
            let shuffleArrayIpad = shuffle(deckShuffled: arrayForIpad)
            let shuffleArrayIpad2 = shuffle(deckShuffled: arrayForIpad2)
            
            for view in ipadCont
            {   view.layer.cornerRadius = 15
                view.layer.masksToBounds = true
                view.layer.shouldRasterize = true
            }
            for (view,num) in zip(pairsForIpad,shuffleArrayIpad)
            {
                padPairs[num] = view
            }
            for (view,num) in zip(ipadMatchSet2,shuffleArrayIpad2)
            {
                padPairs[num] = view
            }
            for view in  ipadContForView
            {
                view.image = #imageLiteral(resourceName: "Memory")
            }
        }
    }
    
    //timer and adjust properties
    @objc func timerFunc()
    {
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            if pairsAmount < 10
            {
                if pairs[0].image == pairs[1].image
                {
                    pairsAmount += 1
                    iphoneView[containsTag1].image = nil
                    iphoneView[containsTag1].backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
                    iphoneView[containsTag1].isUserInteractionEnabled = false
                    iphoneView[containsTag2].isUserInteractionEnabled = false
                    iphoneView[containsTag2].image = nil
                    iphoneView[containsTag2].backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
                }
                else
                {
                    iphoneView[containsTag1].image = #imageLiteral(resourceName: "Memory")
                    iphoneView[containsTag2].image = #imageLiteral(resourceName: "Memory")
                }
                pairs.removeAll()
                if pairsAmount == 10{
                    timer.invalidate()
                    let alert = UIAlertController(title: "You Win!", message: "Final Time: "+timerLabel.text!, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler:nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    //save high score
                    self.saveHighScore()
                    
                    //Reset
                    playButton.isEnabled = true
                    playButton.setTitle("Play", for:.normal)
                    amount = -1
                    count()
                    pairsAmount = 0
                    arrange()
                }
            }
        }
        else if UIDevice.current.userInterfaceIdiom == .pad
        {
            if pairsAmount < 15{
                if pairs[0].image == pairs[1].image
                {
                    pairsAmount += 1
                    ipadContForView[containsTag1].image = nil
                    ipadContForView[containsTag1].backgroundColor = UIColor(red: 0/255, green: 65/255, blue: 0/255, alpha: 1)
                    ipadContForView[containsTag2].image = nil
                    ipadContForView[containsTag2].backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
                    ipadContForView[containsTag1].isUserInteractionEnabled = false
                    ipadContForView[containsTag1].isUserInteractionEnabled = false
                    
                }
                else
                {
                    ipadContForView[containsTag1].image = #imageLiteral(resourceName: "Memory")
                    ipadContForView[containsTag2].image = #imageLiteral(resourceName: "Memory")
                }
                pairs.removeAll()
                
                if pairsAmount == 15{
                    timer.invalidate()
                    let alert = UIAlertController(title: "You Win!", message: "Final Time:"+timerLabel.text!, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Great!", style: UIAlertActionStyle.default, handler:nil))
                    self.present(alert, animated: true, completion: nil)
                    playButton.isEnabled = true
                    playButton.setTitle("Play!", for:.normal)
                    amount = -1
                    count()
                    pairsAmount = 0
                    arrange()
                }
            }
        }
    }
    
    //display brain image after event
    @objc func iphoneShow()
    {
        for view in iphoneView
        {
            view.image = #imageLiteral(resourceName: "Memory")
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageSelected(tapGestureRecognizer:)))
            view.isUserInteractionEnabled = true
            view.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    // gesture recognizers / user interaction
    @objc func ipadFlash() {
        
        for v1 in  ipadContForView
        {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageSelected(tapGestureRecognizer:)))
            v1.isUserInteractionEnabled = true
            v1.addGestureRecognizer(tapGestureRecognizer)
            v1.image = #imageLiteral(resourceName: "Memory")
        }
    }
    
    //timing for counter
    @objc func count(){
        amount += 1
        
        let min = String(amount / 60)
        let sec = String(amount % 60)
        if Int(sec)! < 7{
            timerLabel.text = min + ":0" + sec
        }
        else{
            timerLabel.text = min + ":" + sec
        }
    }
    
    func shuffle( deckShuffled:[Int]) -> [Int] {
        var deckShuffled = deckShuffled
        let copyOfShuffle = deckShuffled.count
        
        if copyOfShuffle < 2 {
            return deckShuffled
        }
        
        for firstMix in 0..<(copyOfShuffle - 1) {
            let secondMix = Int(arc4random_uniform(UInt32(copyOfShuffle - firstMix))) + firstMix
            if firstMix != secondMix
            {
                deckShuffled.swapAt(firstMix, secondMix)
            }
        }
        return deckShuffled
    }
    
    //Save high score
    func saveHighScore(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "HighScores",
                                       in: managedContext)!
        
        let highScore = NSManagedObject(entity: entity,
                                        insertInto: managedContext)
        
        // 3
        highScore.setValue(playerName, forKeyPath: "playerName")
        highScore.setValue(numberOfTurns, forKeyPath: "numberOfTurns")
        highScore.setValue(Date(), forKeyPath: "timestamp")
        highScore.setValue(timerLabel.text!, forKeyPath: "timeToComplete")
        
        // 4
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func showHighScores(_ sender: Any) {
        let dest = storyboard?.instantiateViewController(withIdentifier: "HighScoresController") as! HighScoresController
        present(dest, animated: true, completion: nil)
    }
    
}
