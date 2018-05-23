//
//  TemporaryUnlockedStationDetailViewController.swift
//  RadioUI
//
//  Created by Simo on 03.05.17.
//  Copyright © 2017 Simo. All rights reserved.
//

import UIKit
import SwiftMessages

class TemporaryUnlockedStationDetailViewController: UIViewController {
    
    var nowPlaying = false
    var addedToFav = false
    @IBOutlet weak var getForFreeButton: UIButton!
    @IBAction func getForFreeAction(_ sender: Any) {
        shareForStation()
    }
    @IBOutlet weak var coverImage: UIImageView!
    var gradientLayer: CAGradientLayer!
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = coverImage.bounds
        
        gradientLayer.colors = [hex_081123_alpha_65.cgColor, hex_081123.cgColor, hex_081123.cgColor]
        
        self.view.layer.insertSublayer(gradientLayer, at: 1)
    }
    
    @IBOutlet weak var buyButton: UIButton!
    
    @IBOutlet weak var shareButton: UIButton!
    @IBAction func shareAction(_ sender: Any) {
        print("share")
    }
    
    @IBOutlet weak var playPauseButton: UIButton!
    @IBAction func playPauseAction(_ sender: Any) {
        if nowPlaying {
            print("now paused")
            playPauseButton.setImage(UIImage(named: "play_white"), for: .normal)
            nowPlaying = false
        } else {
            print("now playing")
            nowPlaying = true
            playPauseButton.setImage(UIImage(named: "pause_white"), for: .normal)
        }
    }
    @IBOutlet weak var addToFavButton: UIButton!
    @IBAction func addToFavAction(_ sender: Any) {
        if addedToFav {
            print("removed from favs")
            addToFavButton.setImage(UIImage(named: "like_white"), for: .normal)
            addedToFav = false
        } else {
            print("added to favs")
            addedToFav = true
            addToFavButton.setImage(UIImage(named: "like_white_filled"), for: .normal)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SwiftMessages.hide()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        buyButton.layer.borderWidth = 2
        buyButton.layer.borderColor = UIColor.white.cgColor
        buyButton.layer.cornerRadius = 6
        
        createGradientLayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
