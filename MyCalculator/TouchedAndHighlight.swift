//
//  TouchedAndHighlight.swift
//  MyCalculator
//
//  Created by shareAccount on 2017/03/17.
//  Copyright © 2017年 shareAccount. All rights reserved.
//
import UIKit
import Foundation
class TouchAndHighlight {
    private let numButtonColorWithoutTouch = UIColor(red: 182/255.0, green: 182/255.0, blue: 182/255.0, alpha: 1)
    private let numButtonColorDuringTouch = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
    private let funcButtonColorWithoutTouch = UIColor(red: 138/255, green: 138/255, blue: 138/255, alpha: 1)
    private let funcButtonColorDuringTouch = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
    private let operAndEqualColorWithoutTouch = UIColor(red: 235/255, green: 130/255, blue: 60/255, alpha: 1)
    private let operAndEqualColorDuringTouch = UIColor(red: 225/255, green: 125/255, blue: 55/255, alpha: 1)
    private let errorColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0)
    private let buttonTar: UIButton!
    private let buttonType: String
    private var isFirst = true
    init(_ uIButton: UIButton, _ buttonType: String) {
        buttonTar = uIButton
        self.buttonType = buttonType
    }
    func getNewColorToButton() -> UIColor {
        if buttonType == "num" || buttonType == "dot"{
            if buttonTar.backgroundColor == numButtonColorWithoutTouch {
                return numButtonColorDuringTouch
            }
            return numButtonColorWithoutTouch
        }
        if buttonType == "func" {
            if buttonTar.backgroundColor == funcButtonColorWithoutTouch {
                return funcButtonColorDuringTouch
            }
            return funcButtonColorWithoutTouch
        }
        if buttonType == "OE" {
            if buttonTar.backgroundColor == operAndEqualColorWithoutTouch {
                return operAndEqualColorDuringTouch
            }
            return operAndEqualColorWithoutTouch
        }
        return numButtonColorWithoutTouch
    }
    /*func getNewColorToButton() -> UIColor {
        if buttonType == "num" || buttonType == "dot"{
            if buttonTar.backgroundColor == numButtonColorWithoutTouch {
                return numButtonColorDuringTouch
            }
            return numButtonColorWithoutTouch
        }
        if buttonType == "func" {
            if buttonTar.backgroundColor == funcButtonColorWithoutTouch {
                return funcButtonColorDuringTouch
            }
            return funcButtonColorWithoutTouch
        }
        if buttonType == "OE" {
            if buttonTar.backgroundColor == operAndEqualColorWithoutTouch {
                return operAndEqualColorDuringTouch
            }
            return operAndEqualColorWithoutTouch
        }
        return numButtonColorWithoutTouch
    }*/

}
