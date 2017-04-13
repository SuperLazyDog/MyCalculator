//
//  TouchOutsideCatcher.swift
//  MyCalculator
//
//  Created by shareAccount on 2017/03/17.
//  Copyright © 2017年 shareAccount. All rights reserved.
//
import UIKit
import Foundation
//今タッチしたコントロール以外のところにドラックすることの処理

class TouchOutsideCatcher {
    var allButtonRect: [(CalButtonType, CGRect, UIButton)] = []
    var touchPoint: CGPoint = CGPoint(x: 0, y: 0)
    var button: UIButton = UIButton()
    var targetButton: UIButton = UIButton()
    var highlightAlready = false
    private var preHighlighted: CalButtonType = .wrong
    private var preButton = UIButton()
    func touchUpOutsideProcesser(_ point: CGPoint) -> (Bool, CalButtonType, UIButton) {
        //新たにポイントを追加する必要がある
        recoverButtonWhenLeave(self.preButton, preHighlighted)
        let (isInButton, buttontype, button) = isInButtonRect()
        return (isInButton, buttontype, button)
    }
    func dragInsideProcesser() {
        recoverButtonWhenLeave(self.preButton, preHighlighted)
    }
    func dragOutsideProcesser() {
        if !isContain(self.preButton.frame) {
            recoverButtonWhenLeave(self.preButton, preHighlighted)
            highlightAlready = false
        }
        if !highlightAlready {
            let (isInOtherButtonrect, buttonType, preButton) = isInButtonRect()
            if isInOtherButtonrect {
                highlightButtonAndMark(preButton, buttonType)
            }
            highlightAlready = true
        }
    }
    private func isInButtonRect() -> (Bool, CalButtonType, UIButton) {
        for buttonRect in allButtonRect {
            if isContain(buttonRect.1) {
                return (true, buttonRect.0, buttonRect.2)
            }
        }
        return (false, .wrong, UIButton())
    }
    private func highlightButtonAndMark(_ button: UIButton, _ buttonType: CalButtonType) {
        switch buttonType {
        case .Zero,.one,.two,.three,.four,.five,.six, .seven, .eight, .nine:
            let bkColor = TouchAndHighlight(button, "num")
            button.backgroundColor = bkColor.getNewColorToButton()
        case .Dot:
            let bkColor = TouchAndHighlight(button, "dot")
            button.backgroundColor = bkColor.getNewColorToButton()
        case .PM, .C, .Percent:
            let bkColor = TouchAndHighlight(button, "func")
            button.backgroundColor = bkColor.getNewColorToButton()
        case .Div, .Multi, .Minus, .Plus, .Equal:
            let bkColor = TouchAndHighlight(button, "OE")
            button.backgroundColor = bkColor.getNewColorToButton()
        default:
            break
        }
        preHighlighted = buttonType
        self.preButton = button
    }
    private func recoverButtonWhenLeave(_ button: UIButton, _ preButtonType: CalButtonType) {
        switch preButtonType {
        case .Zero,.one,.two,.three,.four,.five,.six, .seven, .eight, .nine:
            let bkColor = TouchAndHighlight(button, "num")
            button.backgroundColor = bkColor.getNewColorToButton()
        case .Dot:
            let bkColor = TouchAndHighlight(button, "dot")
            button.backgroundColor = bkColor.getNewColorToButton()
        case .PM, .C, .Percent:
            let bkColor = TouchAndHighlight(button, "func")
            button.backgroundColor = bkColor.getNewColorToButton()
        case .Div, .Multi, .Minus, .Plus, .Equal:
            let bkColor = TouchAndHighlight(button, "OE")
            button.backgroundColor = bkColor.getNewColorToButton()
        default:
            break
        }
        preHighlighted = .wrong
    }
    func recoverButtonWhenReturn() {
        switch preHighlighted {
        case .Zero,.one,.two,.three,.four,.five,.six, .seven, .eight, .nine:
            let bkColor = TouchAndHighlight(preButton, "num")
            button.backgroundColor = bkColor.getNewColorToButton()
        case .Dot:
            let bkColor = TouchAndHighlight(preButton, "dot")
            button.backgroundColor = bkColor.getNewColorToButton()
        case .PM, .C, .Percent:
            let bkColor = TouchAndHighlight(preButton, "func")
            button.backgroundColor = bkColor.getNewColorToButton()
        case .Div, .Multi, .Minus, .Plus, .Equal:
            let bkColor = TouchAndHighlight(preButton, "OE")
            button.backgroundColor = bkColor.getNewColorToButton()
        default:
            break
        }
        preHighlighted = .wrong
        preButton = UIButton()
        
    }
    private func isContain(_ buttonRect: CGRect) -> Bool {
        let isXIn = (touchPoint.x > buttonRect.minX) && (touchPoint.x < buttonRect.maxX)
        let isYIn = (touchPoint.y > buttonRect.minY) && (touchPoint.y < buttonRect.maxY)
        if isXIn && isYIn {
            return true
        }
        return false
    }
}
