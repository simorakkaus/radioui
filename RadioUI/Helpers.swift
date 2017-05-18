//
//  Helpers.swift
//  RadioUI
//
//  Created by Simo on 17.04.17.
//  Copyright © 2017 Simo. All rights reserved.
//

import UIKit
import SwiftMessages

let userDefaults = UserDefaults.standard

func createAttributedLabel(firstString: String, secondString: String) -> UILabel {
    let attrStr = NSMutableAttributedString()
    let radioAttrStr = NSMutableAttributedString(
        string: firstString,
        attributes: [NSFontAttributeName:UIFont(
            name: "HelveticaNeue-MediumItalic",
            size: 22.0)!])
    let listAttrStr = NSMutableAttributedString(
        string: secondString,
        attributes: [NSFontAttributeName:UIFont(
            name: "HelveticaNeue-LightItalic",
            size: 22.0)!])
    
    attrStr.append(radioAttrStr)
    attrStr.append(listAttrStr)
    
    let attrLbl = UILabel()
    attrLbl.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
    attrLbl.attributedText = attrStr
    attrLbl.textColor = .white
    attrLbl.textAlignment = .center
    
    return attrLbl
}

func shareForStation(){
    let toast = try! SwiftMessages.viewFromNib(named: "ShareView")
    var config = SwiftMessages.Config()
    
    config.dimMode = .gray(interactive: true)
    config.duration = .forever
    config.presentationStyle = .top
    
    SwiftMessages.show(config: config, view: toast)
}

func printUserDefaults() {
    for (key, value) in userDefaults.dictionaryRepresentation() {
        print("\(key) = \(value) \n")
    }
}

let hex_9b12f4 = UIColor(red:0.61, green:0.07, blue:0.96, alpha:1.0)
let hex_5629F3 = UIColor(red:0.34, green:0.16, blue:0.95, alpha:1.0)
let hex_081123 = UIColor(red:0.03, green:0.07, blue:0.14, alpha:1.0)
let hex_081123_alpha_95 = UIColor(red:0.03, green:0.07, blue:0.14, alpha:0.95)
let hex_081123_alpha_85 = UIColor(red:0.03, green:0.07, blue:0.14, alpha:0.85)
let hex_081123_alpha_65 = UIColor(red:0.03, green:0.07, blue:0.14, alpha:0.65)
let hex_081123_alpha_25 = UIColor(red:0.03, green:0.07, blue:0.14, alpha:0.25)

let hex_121135 = UIColor(red:0.07, green:0.07, blue:0.21, alpha:1.0)
