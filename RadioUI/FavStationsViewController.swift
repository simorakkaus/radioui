//
//  FavStationsViewController.swift
//  RadioUI
//
//  Created by Simo on 05.05.17.
//  Copyright © 2017 Simo. All rights reserved.
//

import UIKit

class FavStationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let favStations = ["ИНДИЙСКАЯ МУЗЫКА","РУССКИЙ ФОЛК","ПРАВОСЛАВНАЯ МУЗЫКА", "ФЛАМЕНКО", "ТАНГО", "СРЕДНИЙ ВОСТОК", "КЕЛЬТСКАЯ МУЗЫКА", "СЕВЕРОАМЕРИКАНСКАЯ МУЗЫКА", "ФОЛК", "ЛАТИНОАМЕРИКАНСКАЯ МУЗЫКА", "ВОСТОЧНОАЗИАТСКАЯ МУЗЫКА"]
    
    @IBOutlet weak var tableView: UITableView!
    
    var shownIndexes : [IndexPath] = []
    
    
    // TableView functions
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return favStations.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (shownIndexes.contains(indexPath) == false) {
            shownIndexes.append(indexPath)
            cell.transform = CGAffineTransform(translationX: 0, y: 80)
            cell.alpha = 0
            
            UIView.animate(withDuration: 0.6, delay: 0.1 + Double(indexPath.section) / 20, usingSpringWithDamping: 2, initialSpringVelocity: 1, options: [.curveEaseInOut, .allowUserInteraction], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                cell.alpha = 1
            }, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavStationCell") as! FavStationCell
        
        if indexPath.section == 2 {
            cell.backgroundColor = hex_5629F3
        } else {
            cell.backgroundColor = hex_121135
        }
        
        if indexPath.section == 1 {
            cell.lockedStation.isHidden = false
            cell.tempFreeStation.isHidden = true
            cell.favStation.isHidden = true
        } else if indexPath.section == 2 {
            cell.lockedStation.isHidden = true
            cell.tempFreeStation.isHidden = false
            cell.favStation.isHidden = true
        } else {
            cell.lockedStation.isHidden = true
            cell.tempFreeStation.isHidden = true
            cell.favStation.isHidden = false
        }
        
        cell.stationLabel.text = favStations[indexPath.section]
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "LockedStationDetailViewController")
            self.navigationController?.pushViewController(vc!, animated: true)
            self.navigationController?.navigationBar.tintColor = .white
            self.navigationItem.title = ""
            vc?.title = favStations[indexPath.section]
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        } else if indexPath.section == 2 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "TemporaryUnlockedStationDetailViewController")
            self.navigationController?.pushViewController(vc!, animated: true)
            self.navigationController?.navigationBar.tintColor = .white
            self.navigationItem.title = ""
            vc?.title = favStations[indexPath.section]
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "UnlockedStationDetailViewController")
            self.navigationController?.pushViewController(vc!, animated: true)
            self.navigationController?.navigationBar.tintColor = .white
            self.navigationItem.title = ""
            vc?.title = favStations[indexPath.section]
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back_white_nav_filled")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back_white_nav_filled")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
