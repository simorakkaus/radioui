//
//  ViewController.swift
//  RadioUI
//
//  Created by Simo on 16.02.17.
//  Copyright © 2017 Simo. All rights reserved.
//

import UIKit
import SwiftMessages

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    let genresIds = [11,22,33,44]
    let genres = ["ЭТНИЧЕСКАЯ / ФОЛК", "КЛАССИКА", "БЛЮЗ", "КАНТРИ", "РЕГГИ / СКА"]
    
    let stations = [
        
        ["ИНДИЙСКАЯ МУЗЫКА","РУССКИЙ ФОЛК","ПРАВОСЛАВНАЯ МУЗЫКА", "ФЛАМЕНКО", "ТАНГО", "СРЕДНИЙ ВОСТОК", "КЕЛЬТСКАЯ МУЗЫКА", "СЕВЕРОАМЕРИКАНСКАЯ МУЗЫКА", "ФОЛК", "ЛАТИНОАМЕРИКАНСКАЯ МУЗЫКА", "ВОСТОЧНОАЗИАТСКАЯ МУЗЫКА"],
        
        ["СИМФОНИЯ", "КЛАССИЧЕСКОЕ ФОРТЕПЬЯНО", "СИМФОНИЧЕСКАЯ МУЗЫКА", "КЛАССИЧЕСКИЙ ХОРАЛ / ВОКАЛЬНАЯ МУЗЫКА", "ОРГАН", "БАРОККО", "ОПЕРА", "СТРУННАЯ МУЗЫКА"],
        
        ["АКУСТИЧЕСКИЙ БЛЮЗ","СОУЛ / НЕО СОУЛ", "ГОСПЕЛ", "ДЕЛЬТА-БЛЮЗ", "ФАНК", "ХАРП-БЛЮЗ", "КАНТРИ-БЛЮЗ", "БУГИ-ВУГИ", "ЧИКАГО-БЛЮЗ", "ХАРД-БЛЮЗ", "БЛЮЗ", "ЭЛЕКТРИК-БЛЮЗ", "СОУЛ-БЛЮЗ"],
        
        ["АЛЬТ-КАНТРИ", "БЛЮГРАСС", "КАНТРИ", "ПОП КАНТРИ"],
        
        ["РЕГГИ", "ДЭНСХОЛЛ / РАГГАМАФФИН", "РУТС РЕГГИ", "ДАБ", "СКА", "СКА-ПАНК"]
        
    ]
    
    var index = Int()
    
    var userDefaults = UserDefaults.standard
    
    func stationsForSelectedGenre(i: Int) {
        index = i
        shownIndexes.removeAll()
        tableView.reloadData()
    }
    
    // UIElements
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var collectionViewIndexPath = IndexPath()
    var tableViewIndexPath = IndexPath()
    
    var shownIndexes : [IndexPath] = []
    
    func detailViewController() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.title = ""
        vc?.title = genres[collectionViewIndexPath.row]
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]

        SwiftMessages.hide()
    }
    
    func buyGenreToast(genreName: String){
        let toast = MessageView.viewFromNib(layout: .MessageView)
        var config = SwiftMessages.Config()
        
        toast.configureTheme(.info, iconStyle: .light)
        toast.configureContent(title: "Время вышло!", body: "Время бесплатного прослушивания \(genreName) истекло. Понравился жанр и хотите продолжить прослушивание?")
        toast.button?.setTitle("Да", for: .normal)
        toast.tapHandler = { _ in
            self.detailViewController()
        }
        toast.buttonTapHandler = { _ in
            self.detailViewController()
        }
        
        config.dimMode = .gray(interactive: true)
        config.duration = .forever
        config.presentationStyle = .top
        
        SwiftMessages.show(config: config, view: toast)
    }
    
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
        return stations[index].count
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationCell") as! StationCell
        cell.stationLabel.text = stations[index][indexPath.section]
        
        if cell.stationLabel.text == "ПРАВОСЛАВНАЯ МУЗЫКА" {
            cell.onAirLabel.isHidden = false
        } else {
            cell.onAirLabel.isHidden = true
        }
        
        if cell.stationLabel.text == "ДЭНСХОЛЛ / РАГГАМАФФИН" || cell.stationLabel.text == "РУТС РЕГГИ" || cell.stationLabel.text == "РЕГГИ" {
            cell.freeStationLockedView.isHidden = false
            cell.freeTimeStationView.isHidden = true
            cell.addedToFavStationView.isHidden = true
        } else if cell.stationLabel.text == "ИНДИЙСКАЯ МУЗЫКА" {
            cell.freeStationLockedView.isHidden = false
            cell.freeTimeStationView.isHidden = true
            cell.addedToFavStationView.isHidden = true
        } else if cell.stationLabel.text == "РУССКИЙ ФОЛК" {
            cell.freeStationLockedView.isHidden = true
            cell.freeTimeStationView.isHidden = true
            cell.addedToFavStationView.isHidden = false
        } else if cell.stationLabel.text == "ФЛАМЕНКО" {
            cell.freeStationLockedView.isHidden = true
            cell.freeTimeStationView.isHidden = true
            cell.addedToFavStationView.isHidden = true
        } else {
            cell.freeStationLockedView.isHidden = true
            cell.freeTimeStationView.isHidden = false
            cell.addedToFavStationView.isHidden = true
        }
        
        tableViewIndexPath = indexPath
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewIndexPath = indexPath
        if indexPath.section == 0 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "LockedStationDetailViewController")
            self.navigationController?.pushViewController(vc!, animated: true)
            self.navigationController?.navigationBar.tintColor = .white
            self.navigationItem.title = ""
            vc?.title = stations[collectionViewIndexPath.row][tableViewIndexPath.row]
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        } else if indexPath.section == 1 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "UnlockedStationDetailViewController")
            self.navigationController?.pushViewController(vc!, animated: true)
            self.navigationController?.navigationBar.tintColor = .white
            self.navigationItem.title = ""
            vc?.title = stations[collectionViewIndexPath.row][tableViewIndexPath.row]
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        } else if indexPath.section == 3 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "UnlockedStationDetailViewController")
            self.navigationController?.pushViewController(vc!, animated: true)
            self.navigationController?.navigationBar.tintColor = .white
            self.navigationItem.title = ""
            vc?.title = stations[collectionViewIndexPath.row][tableViewIndexPath.row]
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        }  else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "TemporaryUnlockedStationDetailViewController")
            self.navigationController?.pushViewController(vc!, animated: true)
            self.navigationController?.navigationBar.tintColor = .white
            self.navigationItem.title = ""
            vc?.title = stations[collectionViewIndexPath.row][tableViewIndexPath.row]
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        }
    }
    
    // CollectionView functions
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCell", for: indexPath) as! GenreCell
        
        cell.genreLabel.text = genres[indexPath.row]
        cell.numberOfStationsLabel.text = "\(stations[indexPath.row].count) станции"
        cell.freeTimeLeftLabel.text = "\(stations[indexPath.row].count * 10) часов осталось"
        
        collectionViewIndexPath = indexPath
        
        var gradientLayer: CAGradientLayer!
        func createGradientLayer() {
            gradientLayer = CAGradientLayer()
            
            gradientLayer.frame = cell.thumbnailImage.bounds
            
            gradientLayer.colors = [hex_081123_alpha_65.cgColor, hex_081123.cgColor]
            
            cell.thumbnailImage.layer.insertSublayer(gradientLayer, at: 1)
        }
        
        if cell.genreLabel.text == "РЕГГИ / СКА" {
            cell.freeTimeStatusIcon.image = UIImage(named: "lock_black")
            cell.freeTimeLeftLabel.text = "0 часов осталось"
            cell.quickBuyButton.isHidden = false
            cell.quickBuyButton.center = cell.thumbnailImage.center
            cell.quickBuyButton.layer.borderWidth = 1
            cell.quickBuyButton.layer.borderColor = UIColor.white.cgColor
            cell.quickBuyButton.layer.cornerRadius = 6
            createGradientLayer()
            
        } else {
            cell.freeTimeStatusIcon.image = UIImage(named: "timer_black")
            cell.quickBuyButton.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        stationsForSelectedGenre(i: indexPath.row)
        
        collectionViewIndexPath = indexPath
        
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        if indexPath.row == 4 {
            buyGenreToast(genreName: genres[4])
        }
        
        print("didSelectItemAt: \(collectionViewIndexPath.row)")
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
//        if indexPath.row == 4 {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
//                self.buyGenreToast(genreName: self.genres[4])
//            })
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.topItem?.titleView = createAttributedLabel(firstString: "Радио", secondString: " ЛИСТ")
        
        self.tableView.contentInset = UIEdgeInsetsMake(40, 0, 20, 0)
        
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back_white_nav_filled")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back_white_nav_filled")
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

