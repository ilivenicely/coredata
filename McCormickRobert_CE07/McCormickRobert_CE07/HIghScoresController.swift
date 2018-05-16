//
//  HIghScoresController.swift
//  McCormickRobert_CE07
//
//  Created by Robert  McCormick on 26/01/2018.
//  Copyright © 2018 Robert  McCormick. All rights reserved.
//

import Foundation


import UIKit
import CoreData

class HighScoresController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var highscoreList : [HighScores] = []
    
    
    @IBAction func closeViewController(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load data
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "HighScores")
        do {
            highscoreList = try managedContext.fetch(fetch) as! [HighScores]
            if highscoreList.count > 0 {
                highscoreList.sort(by: { (hc1, hc2) -> Bool in
                    if hc1.timestamp!.compare(hc2.timestamp! as Date).rawValue >= 0 {
                        return true
                    }
                    return false
                })
                self.tableView.reloadData()
            }
        }
        catch{
            print(error.localizedDescription)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if highscoreList.count > 5
        {
            return 5
        }
        return highscoreList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HighScoreCell", for: indexPath) as! HighScoreCell
        
        let highScore = highscoreList[indexPath.row]
        cell.playerLabel.text = highScore.playerName
        cell.timeToCompleteLabel.text = highScore.timeToComplete
        cell.numberOfTurnsLabel.text = "\(highScore.numberOfTurns)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yy-h:m"
        cell.timeStamp.text = dateFormatter.string(from: highScore.timestamp! as Date)
        
        return cell
    }
}
