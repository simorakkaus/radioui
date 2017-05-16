//
//  StationDetailViewController.swift
//  RadioUI
//
//  Created by Simo on 28.04.17.
//  Copyright © 2017 Simo. All rights reserved.
//

import UIKit
import SwiftMessages

class LockedStationDetailViewController: UIViewController {

    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var getForFreeButton: UIButton!
    @IBAction func getForFreeAction(_ sender: Any) {
        print("get for free")
        shareForStation()
    }
    
    
    
    var gradientLayer: CAGradientLayer!
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = coverImage.bounds
        
        gradientLayer.colors = [hex_081123_alpha_85.cgColor, hex_081123.cgColor, hex_081123.cgColor]
        
        self.view.layer.insertSublayer(gradientLayer, at: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        buyButton.layer.borderWidth = 1
        buyButton.layer.borderColor = UIColor.white.cgColor
        buyButton.layer.cornerRadius = 6
        
        createGradientLayer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SwiftMessages.hide()
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
