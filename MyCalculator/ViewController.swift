//
//  ViewController.swift
//  MyCalculator
//
//  Created by shareAccount on 2017/03/02.
//  Copyright © 2017年 shareAccount. All rights reserved.
//消すコピペ、AC、ハイライトとキャッチ、演算子ボダんを押した場合に枠線を
//touch down up
//drag enter exit
import UIKit
class ViewController: UIViewController {

    //var calcuNum1 = 0.0
    //var calcuNum2 = 0.0
    //オペンラントがいくつでもいいから、配列で作る
    var operantArray = Array<Double>()
    var operatorArray = Array<Operator>()
    var output: Double = 0.0
    var touchedOperator = false
    var isAlreadyCalcu = false
    var waitNextNum = false
    var equalButtonStart = true //イコール自動計算機能を制御する
    var isDoubleTouched = LimitDoubleTouched()
    var isDoubleTouchedEqual = DoubleEqual()
    var equalNeedFirstCal = true
    var isPMTouched = false
    var nowOperator: Operator! = nil
    let numButtonColorWithoutTouch = UIColor(red: 175.0/255, green: 175.0/255, blue: 175.0/255, alpha: 1.0)
    let numButtonColorDuringTouch = UIColor(red: 153.0/255, green: 153.0/255, blue: 153.0/255, alpha: CGFloat(1.0))
    let funcButtonColorWithoutTouch = UIColor(red: 120.0/255, green: 120.0/255, blue: 120.0/255, alpha: 1.0)
    let funcButtonColorDuringTouch = UIColor(red: 100.0/255, green: 100.0/255, blue: 100.0/255, alpha: 1.0)
    let operAndEqualColorWithoutTouch = UIColor(red: 235.0/255, green: 130.0/255, blue: 60.0/255, alpha: 1.0)
    let operAndEqualColorDuringTouch = UIColor(red: 225.0/255, green: 125.0/255, blue: 55.0/255, alpha: 1.0)
    //UIView
    @IBOutlet var viewMain: UIView!
    //------------------------------------------
    //ボダんの変数
    @IBOutlet weak var buttonDot: UIButton!
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonPM: UIButton!
    @IBOutlet weak var buttonPercent: UIButton!
    @IBOutlet weak var buttonDivi: UIButton!
    @IBOutlet weak var buttonMulti: UIButton!
    @IBOutlet weak var buttonMinus: UIButton!
    @IBOutlet weak var buttonPlus: UIButton!
    @IBOutlet weak var buttonEqual: UIButton!
    //ボダンの位置情報配列
    var buttonPositionArray: [(CalButtonType, CGRect, UIButton)] = []
    let touchOutSideProcessed = TouchOutsideCatcher()
    //------------------------------------------
    @IBOutlet weak var resultTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewMain.isExclusiveTouch = true
        //viewMain.isMultipleTouchEnabled = true
        let numButtonColorWithoutTouch = UIColor(red: 182/255.0, green: 182/255.0, blue: 182/255.0, alpha: 1)
        let funcButtonColorWithoutTouch = UIColor(red: 138/255, green: 138/255, blue: 138/255, alpha: 1)
        let operAndEqualColorWithoutTouch = UIColor(red: 235/255, green: 130/255, blue: 60/255, alpha: 1)
        button0.backgroundColor = numButtonColorWithoutTouch
        button1.backgroundColor = numButtonColorWithoutTouch
        button2.backgroundColor = numButtonColorWithoutTouch
        button3.backgroundColor = numButtonColorWithoutTouch
        button4.backgroundColor = numButtonColorWithoutTouch
        button5.backgroundColor = numButtonColorWithoutTouch
        button6.backgroundColor = numButtonColorWithoutTouch
        button7.backgroundColor = numButtonColorWithoutTouch
        button8.backgroundColor = numButtonColorWithoutTouch
        button9.backgroundColor = numButtonColorWithoutTouch
        buttonDot.backgroundColor = numButtonColorWithoutTouch
        buttonC.backgroundColor = funcButtonColorWithoutTouch
        buttonPM.backgroundColor = funcButtonColorWithoutTouch
        buttonPercent.backgroundColor = funcButtonColorWithoutTouch
        buttonDivi.backgroundColor = operAndEqualColorWithoutTouch
        buttonMulti.backgroundColor = operAndEqualColorWithoutTouch
        buttonMinus.backgroundColor = operAndEqualColorWithoutTouch
        buttonPlus.backgroundColor = operAndEqualColorWithoutTouch
        buttonEqual.backgroundColor = operAndEqualColorWithoutTouch
        buttonPositionArray.append((.Zero, button0.frame, button0))
        buttonPositionArray.append((.one, button1.frame, button1))
        buttonPositionArray.append((.two, button2.frame, button2))
        buttonPositionArray.append((.three, button3.frame, button3))
        buttonPositionArray.append((.four, button4.frame, button4))
        buttonPositionArray.append((.five, button5.frame, button5))
        buttonPositionArray.append((.six, button6.frame, button6))
        buttonPositionArray.append((.seven, button7.frame, button7))
        buttonPositionArray.append((.eight, button8.frame, button8))
        buttonPositionArray.append((.nine, button9.frame, button9))
        buttonPositionArray.append((.Dot, buttonDot.frame, buttonDot))
        buttonPositionArray.append((.PM, buttonPM.frame, buttonPM))
        buttonPositionArray.append((.C, buttonC.frame, buttonC))
        buttonPositionArray.append((.Percent, buttonPercent.frame, buttonPercent))
        buttonPositionArray.append((.Div, buttonDivi.frame, buttonDivi))
        buttonPositionArray.append((.Multi, buttonMulti.frame, buttonMulti))
        buttonPositionArray.append((.Plus, buttonPlus.frame, buttonPlus))
        buttonPositionArray.append((.Minus, buttonMinus.frame, buttonMinus))
        buttonPositionArray.append((.Equal, buttonEqual.frame, buttonEqual))
        //resultTextView.font
        //resultTextView.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        buttonDot.isExclusiveTouch = true
        button0.isExclusiveTouch = true
        button1.isExclusiveTouch = true
        button2.isExclusiveTouch = true
        button3.isExclusiveTouch = true
        button4.isExclusiveTouch = true
        button5.isExclusiveTouch = true
        button6.isExclusiveTouch = true
        button7.isExclusiveTouch = true
        button8.isExclusiveTouch = true
        button9.isExclusiveTouch = true
        buttonC.isExclusiveTouch = true
        buttonPM.isExclusiveTouch = true
        buttonPercent.isExclusiveTouch = true
        buttonDivi.isExclusiveTouch = true
        buttonMulti.isExclusiveTouch = true
        buttonMinus.isExclusiveTouch = true
        buttonPlus.isExclusiveTouch = true
        buttonEqual.isExclusiveTouch = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //--------------------------------------------------------------------
    //                         数字ボダん 0~9
    //--------------------------------------------------------------------
    //---------touch upinside---------
    @IBAction func tap0Button(_ sender: UIButton) {    //button 0
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
        numButtonFunc(numberString: "0")
    }
    @IBAction func tap1Button(_ sender: UIButton) {    //button 1
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
        numButtonFunc(numberString: "1")
    }
    @IBAction func tap2Button(_ sender: UIButton) {    //button 2
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
        numButtonFunc(numberString: "2")
    }
    @IBAction func tap3Button(_ sender: UIButton) {    //button 3
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
        numButtonFunc(numberString: "3")
    }
    @IBAction func tap4Button(_ sender: UIButton) {    //button 4
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
        numButtonFunc(numberString: "4")
    }
    @IBAction func tap5Button(_ sender: UIButton) {    //button 5
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
        numButtonFunc(numberString: "5")
    }
    @IBAction func tap6Button(_ sender: UIButton) {    //button 6
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
        numButtonFunc(numberString: "6")
    }
    @IBAction func tap7Button(_ sender: UIButton) {    //button 7
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
        numButtonFunc(numberString: "7")
    }
    @IBAction func tap8Button(_ sender: UIButton) {    //button 8
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
        numButtonFunc(numberString: "8")
    }
    @IBAction func tap9Button(_ sender: UIButton) {    //button 9
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
        numButtonFunc(numberString: "9")
    }
    //----------------------------------------------
    //---------touch up outside---------
    func touchUpOutsideProcesser(_ buttonType: CalButtonType) {
        switch buttonType {
        case .Zero,.one,.two,.three,.four,.five,.six, .seven, .eight, .nine:
            numButtonFunc(numberString: buttonType.rawValue)
        case .Dot:
            equalButtonStart = false
            isPMTouched = false
            //var isDouble = false
            isDoubleTouchedEqual.reSet()
            let getCorrectTextStringPro = ConvertToAppropriateDataType(textString: resultTextView.text)
            let correctInputTextString = getCorrectTextStringPro.getInputAppropriateFormat(commandString: ".")
            resultTextView.text = ConvertToAppropriateDataType(textString: correctInputTextString).outWithAppropriateDataType()
        case .PM:
            equalButtonStart = false
            isDoubleTouchedEqual.reSet()
            isPMTouched = true
            //-------------------------------------
            //エラーと表示されていた場合に無視 2017/03/16
            //ここをコメントアウトすると、画面にエラーを表示されている時に
            //PMを押すと-０に戻る（元の機能）
            let outTemp = resultTextView.text!
            for char in outTemp.characters {
                if char == "エ" {
                    return
                }
            }
            //-------------------------------------
            /*if isPMTouched {
             if resultTextView.text.hasPrefix("-") {
             resultTextView.text.remove(at: resultTextView.text.startIndex)
             }else {
             resultTextView.text.insert("-", at: resultTextView.text.startIndex)
             }
             }*/
            let getCorrectTextStringPro = ConvertToAppropriateDataType(textString: resultTextView.text)
            let correctInputTextString = getCorrectTextStringPro.getInputAppropriateFormat(commandString: "PM")
            resultTextView.text = ConvertToAppropriateDataType(textString: correctInputTextString).outWithAppropriateDataType()
            isPMTouched = false
        case .C:
            //resultTextView.text = "0"
            let getCorrectTextStringPro = ConvertToAppropriateDataType(textString: resultTextView.text)
            let correctInputTextString = getCorrectTextStringPro.getInputAppropriateFormat(commandString: "C")
            resultTextView.text = ConvertToAppropriateDataType(textString: correctInputTextString).outWithAppropriateDataType()
            nowOperator = nil
            operatorArray = []; operantArray = []
            output = 0
            touchedOperator = false
            isAlreadyCalcu = false
            isDoubleTouched.neverBeDoubleTouch()
            waitNextNum = false
            isDoubleTouchedEqual.reSet()
            equalButtonStart = true
            equalNeedFirstCal = true
            isPMTouched = false
        case .Percent:

            isPMTouched = false
            equalButtonStart = false
            isDoubleTouchedEqual.reSet()
            for char in resultTextView.text.characters {
                if char == "エ" {
                    return
                }
            }
            var resultTemp = ConvertToAppropriateDataType(textString: resultTextView.text!).getInputAppropriateFormat(commandString: "%")
            var isDouble = false
            if resultTemp.hasSuffix(".") { //最後の文字が"."の場合、それを削除する
                //最後の文字が"."だったら、この前に"."がない（.ボタンの仕組みだから)
                //つまり、この数字が整数だ。
                let beforeLaseIndex = resultTemp.index(before: resultTemp.endIndex)
                resultTemp.remove(at: beforeLaseIndex)
                let doubleValue = Double(resultTemp)! / 100.0
                resultTextView.text = ConvertToAppropriateDataType(textString: String(doubleValue)).outWithAppropriateDataType()
            }else {//最後がドットでない場合はまず整数か浮動小数点数かを確かめる
                //9e-180のような場合、ドットがない
                for char in resultTemp.characters {
                    if char == "." {
                        isDouble = true
                    }
                }
                if !isDouble {//isDoubleっていう名前だが、Eeの場合もfalseだ
                    /*let intValue = Int(resultTemp)! / 100 //いらない処理
                     resultTextView.text = String(intValue)*/
                    if resultTemp != "percent over range エラー" {
                        let doubleValueTemp = Double(resultTemp)! / 100.0
                        //resultTextView.text = ConvertToAppropriateDataType(textString: String(doubleValueTemp)).outWithAppropriateDataType()
                        let (overZero, underZero) =
                            ((doubleValueTemp > 0 && ( doubleValueTemp < 1.0e-170 || doubleValueTemp > 1.0e170)),(doubleValueTemp < 0 && ( doubleValueTemp > -1.0e-170 || doubleValueTemp < -1.0e170)))
                        //if doubleValueTemp < 1.0e-170 || doubleValueTemp > 1.0e170 {
                        if doubleValueTemp == 0 {
                            resultTextView.text = "0"
                            return
                        }
                        if overZero || underZero {
                            //なぜこの場合に0が含まれるかわからないが、次の文がないと
                            //0の時に%を押したら0.0になり、もう一回押す場合やっとエラーが出る
                            //2017/03/12 わかった、上の条件式の左が間違ったのだ
                            if doubleValueTemp == 0 {//????????????
                                resultTextView.text = "0"
                            }else {
                                resultTextView.text = ConvertToAppropriateDataType(textString: String(doubleValueTemp)).outWithAppropriateDataType()
                                //resultTextView.text = "percent over range エラー"
                                //operantArray = []; operatorArray = []
                                //output = 0.0
                            }
                        }else {
                            resultTextView.text = ConvertToAppropriateDataType(textString: String(doubleValueTemp)).outWithAppropriateDataType()
                        }
                    }else {
                        operantArray = []; operatorArray = []
                        output = 0.0
                        resultTextView.text = "0"
                    }
                }else {//小数点以下の数字をキャッチ
                    let doubleValueTemp = Double(resultTemp)! / 100.0
                    let (overZero, underZero) =
                        ((doubleValueTemp > 0 && ( doubleValueTemp < 1.0e-170 || doubleValueTemp > 1.0e170)),(doubleValueTemp < 0 && ( doubleValueTemp > -1.0e-170 || doubleValueTemp < -1.0e170)))
                    if  overZero||underZero {
                        //resultTextView.text = "\(doubleValueTemp) エラー"
                        resultTextView.text = "percent over range エラー"
                        operantArray = []; operatorArray = []
                        output = 0.0
                    }else {
                        resultTextView.text = ConvertToAppropriateDataType(textString: String(doubleValueTemp)).outWithAppropriateDataType()
                    }
                }
            }
        case .Div:
            fourArithmeticOperationsfunc(operater: .divi)
        case .Multi:
            fourArithmeticOperationsfunc(operater: .multi)
        case .Minus:
            fourArithmeticOperationsfunc(operater: .minus)
        case .Plus:
            fourArithmeticOperationsfunc(operater: .plus)
        case .Equal:
            isPMTouched = false
            //-------------------------------------
            //エラーと表示されていた場合に無視  2017/03/16
            //ここをコメントアウトすると、画面にエラーを表示されている時に
            //イコールを押すと０に戻る（元の機能）
            let outTemp = resultTextView.text!
            for char in outTemp.characters {
                if char == "エ" {
                    return
                }
            }
            //-------------------------------------
            let getCorrectTextStringPro = ConvertToAppropriateDataType(textString: resultTextView.text)
            let correctInputTextString = getCorrectTextStringPro.getInputAppropriateFormat(commandString: "=")
            if let doubleValue = Double(correctInputTextString) {
                operantArray.append(doubleValue)
                //resultTextView.text = "\(operantArray[0])\(operatorArray[0])\(operantArray[1])\(operatorArray[1])\(operantArray[2])"
                //return
            }else {
                operantArray = []; operatorArray = []
                output = 0.0
                resultTextView.text = "0"
                return
            }
            if operantArray.count == 2 && operatorArray.count == 0 {
                operatorArray.append(nowOperator)
            }
            if operatorArray.count == 1 && operantArray.count == 2 && operatorArray[0] == .divi && operantArray[1] == 0 {
                resultTextView.text = "/0 エラー"
                operantArray = []; operatorArray = []
                output = 0.0
                return
            }
            //test
            //resultTextView.text = "operator: \(operatorArray.count) operant: \(operantArray.count)"
            //resultTextView.text = "\(operantArray[0])\(operatorArray[0])\(operantArray[1])\(operatorArray[1])\(operantArray[2])"
            //\(operatorArray[2])"
            //return
            //5+3*2=
            // a ? b ? c ?    operantArray.count = operatorArray.count (+1)
            if operantArray.count != operatorArray.count && operantArray.count != operatorArray.count+1 {
                operantArray = []; operatorArray = []
                output = 0.0
                isAlreadyCalcu = true
                resultTextView.text = "0"
                return
            }
            
            if operantArray.count == 2 && operatorArray.count == 1 && equalNeedFirstCal{
                isDoubleTouchedEqual.hasTouchedEqual()
                equalNeedFirstCal = false
                touchedOperator = true
                let operatorTrueLaseIndex = operatorArray.endIndex-1 > 0 ? operatorArray.endIndex-1:0
                let lastOperator = operatorArray[operatorTrueLaseIndex]
                let lastOperantTrueIndex = operantArray.endIndex - 1
                let lastOperantEle = operantArray[lastOperantTrueIndex]
                operantArray.remove(at: lastOperantTrueIndex)
                //operatorArray.remove(at:operatorTrueLaseIndex)
                if arithmeticProcesser(operant: operantArray, operator: operatorArray) {
                    //計算成功 (a?b)?の形なので、(a?b)をオペラント配列に　次の?を演算子配列に初期化する
                    //resultTextView.text = String(output)
                    //operatorArray = [operatorArray[1]]
                    operatorArray = [lastOperator]
                    operantArray = [output, lastOperantEle]
                    isDoubleTouchedEqual.operantTemp = operantArray[1]
                    isDoubleTouchedEqual.operatorTemp = operatorArray[0]
                    arithmeticProcesser(operant: operantArray, operator: operatorArray)
                    isDoubleTouchedEqual.nowNum = output
                    let outputString = ConvertToAppropriateDataType(textString: String(output))
                    resultTextView.text = outputString.outWithAppropriateDataTypeByEqual()
                    //適当な結果文字列を求める
                    //resultTextView.text = String(output)
                    //return
                }else {
                    operantArray = []; operatorArray = []
                    output = 0.0
                    resultTextView.text = "0"
                    return
                }
                //ダブルタッチをできるようにするため
                operantArray = []; operatorArray = []
                output = 0.0
                isAlreadyCalcu = true
                return
            }else if operantArray.count == 3 && operatorArray.count == 2 && equalNeedFirstCal {
                //二番目の演算子の方が優先度が高い場合
                //前の演算を全部終わらせる
                isDoubleTouchedEqual.hasTouchedEqual()
                equalNeedFirstCal = false
                touchedOperator = true
                //let operatorTrueLaseIndex = operatorArray.endIndex-1 > 0 ? operatorArray.endIndex-1:0
                //let lastOperator = operatorArray[operatorTrueLaseIndex]
                let lastOperantTrueIndex = operantArray.endIndex - 1
                let lastOperantEle = operantArray[lastOperantTrueIndex]
                operantArray.remove(at: lastOperantTrueIndex)
                waitNextNum = true// a+(b* C ) ?
                switch operatorArray[1] {
                case .multi:
                    if operatorArray[0] == .plus {
                        output = operantArray[0] + (operantArray[1] * lastOperantEle)
                        isDoubleTouchedEqual.operatorTemp = operatorArray[0]
                        isDoubleTouchedEqual.nowNum = output
                        isDoubleTouchedEqual.operantTemp = operantArray[1] * lastOperantEle
                    }else {
                        output = operantArray[0] - (operantArray[1] * lastOperantEle)
                        isDoubleTouchedEqual.operatorTemp = operatorArray[0]
                        isDoubleTouchedEqual.nowNum = output
                        isDoubleTouchedEqual.operantTemp = operantArray[1] * lastOperantEle
                    }
                case .divi:
                    if operatorArray[0] == .plus {
                        output = operantArray[0] + (operantArray[1] / lastOperantEle)
                        isDoubleTouchedEqual.operatorTemp = operatorArray[0]
                        isDoubleTouchedEqual.nowNum = output
                        isDoubleTouchedEqual.operantTemp = operantArray[1] / lastOperantEle
                    }else {
                        output = operantArray[0] - (operantArray[1] / lastOperantEle)
                        isDoubleTouchedEqual.operatorTemp = operatorArray[0]
                        isDoubleTouchedEqual.nowNum = output
                        isDoubleTouchedEqual.operantTemp = operantArray[1] / lastOperantEle
                    }
                default:
                    resultTextView.text = "operator 3 エラー"
                    break
                }
                waitNextNum = false
                //適当な結果文字列を求める
                let outputString = ConvertToAppropriateDataType(textString: String(output))
                resultTextView.text = outputString.outWithAppropriateDataTypeByEqual()
                //resultTextView.text = "result" + outputString.intString + outputString.dot + outputString.doubleString
                //return
                //resultTextView.text = String(output)
                operantArray = []; operatorArray = []
                output = 0.0
                isAlreadyCalcu = true
                return
            }
            
            if equalButtonStart {
                isDoubleTouchedEqual.reSet()
            }
            equalButtonStart = false
            /*if operatorArray.count == 1 && operatorArray[0] == .divi && operantArray.count == 0 {
             operantArray = []; operatorArray = []
             output = 0.0
             resultTextView.text = "0"
             return
             }*/
            //let (a,b) = (operantArray.count, operatorArray.count)
            if !isDoubleTouchedEqual.touchedEqual {
                if operantArray.count == 2 && operatorArray.count == 1 {
                    isDoubleTouchedEqual.nowNum = operantArray[0]
                    isDoubleTouchedEqual.operantTemp = operantArray[1]
                    isDoubleTouchedEqual.operatorTemp = operatorArray[0]
                }else {
                    operantArray = []; operatorArray = []
                    output = 0.0
                    resultTextView.text = "0"
                }
            }
            if operantArray.count == 2 && operatorArray.count == 1 {
                isDoubleTouchedEqual.hasTouchedEqual()//ダブルタッチ処理
            }
            if isDoubleTouchedEqual.isDoubleTouched() {
                isDoubleTouchedEqual.nowNum =  isDoubleTouchedEqual.doubleTouchProcessor(nowNum: isDoubleTouchedEqual.nowNum)
                //let isOverRange = LimitDoubleMax(num: isDoubleTouchedEqual.nowNum)
                if isDoubleTouchedEqual.nowNum > 9e290/*DBL_MAX*/ || isDoubleTouchedEqual.nowNum < -9e290/*DBL_MIN*/ {
                    resultTextView.text = "\(isDoubleTouchedEqual.nowNum)over エラー"
                    isDoubleTouchedEqual.reSet()
                    operantArray = []; operatorArray = []
                    output = 0.0
                    isAlreadyCalcu = true
                    equalNeedFirstCal = false
                }else {
                    //適当な結果文字列を求める
                    let outputString = ConvertToAppropriateDataType(textString: String(isDoubleTouchedEqual.nowNum))
                    resultTextView.text = outputString.outWithAppropriateDataTypeByEqual()
                    //resultTextView.text = String(isDoubleTouchedEqual.nowNum)
                }
                
                /*if !isOverRange.isOveRange {
                 resultTextView.text = "エラー"
                 isDoubleTouchedEqual.reSet()
                 }*/
                operantArray = []; operatorArray = []
                output = 0.0
                isAlreadyCalcu = true
                return
                //resultTextView.text = "!!!"
            }else {
                //arithmeticProcesser(operant: operantArray, operator: operatorArray)
                if operatorArray.count == 1 {
                    switch operatorArray[0] {//8*9 *3 =
                    case .plus:
                        output = operantArray[0] + operantArray[1]
                    case .minus:
                        output = operantArray[0] - operantArray[1]
                    case .multi:
                        output = operantArray[0] * operantArray[1]
                    case .divi:
                        if operantArray[1] == 0 {
                            resultTextView.text = "/0 エラー"
                        }else {
                            output = operantArray[0] / operantArray[1]
                        }
                    }
                    operantArray = []; operatorArray = []
                    //operantArray.append(output)
                }else {
                    let getCorrectTextStringPro = ConvertToAppropriateDataType(textString: resultTextView.text)
                    let correctInputTextString = getCorrectTextStringPro.getInputAppropriateFormat(commandString: "=")
                    if let doubleValue = Double(correctInputTextString) {
                        output = doubleValue
                    }
                    //output = Double(resultTextView.text!)!
                }
                if resultTextView.text != "エラー" {
                    //適当な結果文字列を求める
                    let outputString = ConvertToAppropriateDataType(textString: String(output))
                    resultTextView.text = outputString.outWithAppropriateDataTypeByEqual()
                    //resultTextView.text = String(output)
                }
                output = 0.0
                isAlreadyCalcu = true
                //isDoubleTouched.neverBeDoubleTouch()
                return
            }
        default:
            break
        }
    }
    @IBAction func tap0ButtonUpOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        let (isInButton, buttonType, _) = touchOutSideProcessed.touchUpOutsideProcesser(point!)
        if isInButton {
            touchUpOutsideProcesser(buttonType)
        }
    }
    @IBAction func tap1ButtonUpOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        let (isInButton, buttonType, _) = touchOutSideProcessed.touchUpOutsideProcesser(point!)
        if isInButton {
            touchUpOutsideProcesser(buttonType)
        }
    }
    @IBAction func tap2ButtonUpOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        let (isInButton, buttonType, _) = touchOutSideProcessed.touchUpOutsideProcesser(point!)
        if isInButton {
            touchUpOutsideProcesser(buttonType)
        }
    }
    @IBAction func tap3ButtonUpOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        let (isInButton, buttonType, _) = touchOutSideProcessed.touchUpOutsideProcesser(point!)
        if isInButton {
            touchUpOutsideProcesser(buttonType)
        }
    }
    @IBAction func tap4ButtonUpOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        let (isInButton, buttonType, _) = touchOutSideProcessed.touchUpOutsideProcesser(point!)
        if isInButton {
            touchUpOutsideProcesser(buttonType)
        }
    }
    @IBAction func tap5ButtonUpOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        let (isInButton, buttonType, _) = touchOutSideProcessed.touchUpOutsideProcesser(point!)
        if isInButton {
            touchUpOutsideProcesser(buttonType)
        }
    }
    @IBAction func tap6ButtonUpOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        let (isInButton, buttonType, _) = touchOutSideProcessed.touchUpOutsideProcesser(point!)
        if isInButton {
            touchUpOutsideProcesser(buttonType)
        }
    }
    @IBAction func tap7ButtonUpOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        let (isInButton, buttonType, _) = touchOutSideProcessed.touchUpOutsideProcesser(point!)
        if isInButton {
            touchUpOutsideProcesser(buttonType)
        }
    }
    @IBAction func tap8ButtonUpOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        let (isInButton, buttonType, _) = touchOutSideProcessed.touchUpOutsideProcesser(point!)
        if isInButton {
            touchUpOutsideProcesser(buttonType)
        }
    }
    @IBAction func tap9ButtonUpOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        let (isInButton, buttonType, _) = touchOutSideProcessed.touchUpOutsideProcesser(point!)
        if isInButton {
            touchUpOutsideProcesser(buttonType)
        }
    }
    //----------------------------------------------

    //---------drag exit---------
    @IBAction func tap0ButtonDragExit(_ sender: UIButton) {    //button 0
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tap1ButtonDragExit(_ sender: UIButton) {    //button 1
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tap2ButtonDragExit(_ sender: UIButton) {    //button 2
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tap3ButtonDragExit(_ sender: UIButton) {    //button 3
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tap4ButtonDragExit(_ sender: UIButton) {    //button 4
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tap5ButtonDragExit(_ sender: UIButton) {    //button 5
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tap6ButtonDragExit(_ sender: UIButton) {    //button 6
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tap7ButtonDragExit(_ sender: UIButton) {    //button 7
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tap8ButtonDragExit(_ sender: UIButton) {    //button 8
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tap9ButtonDragExit(_ sender: UIButton) {    //button 9
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    //----------------------------------------------
    //---------drag enter---------
    @IBAction func tap0ButtonDragEnter(_ sender: UIButton) {    //button 0
        touchOutSideProcessed.dragInsideProcesser()
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tap1ButtonDragEnter(_ sender: UIButton) {    //button 1
        touchOutSideProcessed.dragInsideProcesser()
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tap2ButtonDragEnter(_ sender: UIButton, forEvent event: UIEvent) {    //button 2
        touchOutSideProcessed.dragInsideProcesser()
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tap3ButtonDragEnter(_ sender: UIButton) {    //button 3
        touchOutSideProcessed.dragInsideProcesser()
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tap4ButtonDragEnter(_ sender: UIButton) {    //button 4
        touchOutSideProcessed.dragInsideProcesser()
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tap5ButtonDragEnter(_ sender: UIButton) {    //button 5
        touchOutSideProcessed.dragInsideProcesser()
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tap6ButtonDragEnter(_ sender: UIButton) {    //button 6
        touchOutSideProcessed.dragInsideProcesser()
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tap7ButtonDragEnter(_ sender: UIButton) {    //button 7
        touchOutSideProcessed.dragInsideProcesser()
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tap8ButtonDragEnter(_ sender: UIButton) {    //button 8
        touchOutSideProcessed.dragInsideProcesser()
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tap9ButtonDragEnter(_ sender: UIButton) {    //button 9
        touchOutSideProcessed.dragInsideProcesser()
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }

    //----------------------------------------------
    //---------touch down---------
    @IBAction func tap0ButtonDown(_ sender: UIButton) {    //button 0
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tap1ButtonDown(_ sender: UIButton) {    //button 1
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tap2ButtonDown(_ sender: UIButton) {    //button 2
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tap3ButtonDown(_ sender: UIButton) {    //button 3
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tap4ButtonDown(_ sender: UIButton) {    //button 4
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tap5ButtonDown(_ sender: UIButton) {    //button 5
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tap6ButtonDown(_ sender: UIButton) {    //button 6
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tap7ButtonDown(_ sender: UIButton) {    //button 7
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tap8ButtonDown(_ sender: UIButton) {    //button 8
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tap9ButtonDown(_ sender: UIButton) {    //button 9
        let bkColor = TouchAndHighlight(sender, "num")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    
    //----------------------------------------------
    //------------drag Outside----------------
    @IBAction func button0DragOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        touchOutSideProcessed.button = sender
        touchOutSideProcessed.allButtonRect = buttonPositionArray
        touchOutSideProcessed.dragOutsideProcesser()
    }
    @IBAction func button1DragOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        touchOutSideProcessed.button = sender
        touchOutSideProcessed.allButtonRect = buttonPositionArray
        touchOutSideProcessed.dragOutsideProcesser()
    }

    @IBAction func button2DragOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        touchOutSideProcessed.button = sender
        touchOutSideProcessed.allButtonRect = buttonPositionArray
        touchOutSideProcessed.dragOutsideProcesser()
    }
    @IBAction func button3DragOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        touchOutSideProcessed.button = sender
        touchOutSideProcessed.allButtonRect = buttonPositionArray
        touchOutSideProcessed.dragOutsideProcesser()
    }
    @IBAction func button4DragOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        touchOutSideProcessed.button = sender
        touchOutSideProcessed.allButtonRect = buttonPositionArray
        touchOutSideProcessed.dragOutsideProcesser()
    }
    @IBAction func button5DragOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        touchOutSideProcessed.button = sender
        touchOutSideProcessed.allButtonRect = buttonPositionArray
        touchOutSideProcessed.dragOutsideProcesser()
    }
    @IBAction func button6DragOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        touchOutSideProcessed.button = sender
        touchOutSideProcessed.allButtonRect = buttonPositionArray
        touchOutSideProcessed.dragOutsideProcesser()
    }
    @IBAction func button7DragOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        touchOutSideProcessed.button = sender
        touchOutSideProcessed.allButtonRect = buttonPositionArray
        touchOutSideProcessed.dragOutsideProcesser()
    }
    @IBAction func button8DragOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        touchOutSideProcessed.button = sender
        touchOutSideProcessed.allButtonRect = buttonPositionArray
        touchOutSideProcessed.dragOutsideProcesser()
    }
    @IBAction func button9DragOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        touchOutSideProcessed.button = sender
        touchOutSideProcessed.allButtonRect = buttonPositionArray
        touchOutSideProcessed.dragOutsideProcesser()
    }

    
    //--------------------------------------------------------------------
    //                         functionボダん . C PM %
    //--------------------------------------------------------------------
    //----touch up outside----
    @IBAction func tapDotButtonUpOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        let (isInButton, buttonType, _) = touchOutSideProcessed.touchUpOutsideProcesser(point!)
        if isInButton {
            touchUpOutsideProcesser(buttonType)
        }
    }
    @IBAction func tapCButtonUpOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        let (isInButton, buttonType, _) = touchOutSideProcessed.touchUpOutsideProcesser(point!)
        if isInButton {
            touchUpOutsideProcesser(buttonType)
        }
    }
    @IBAction func tapPMButtonUpOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        let (isInButton, buttonType, _) = touchOutSideProcessed.touchUpOutsideProcesser(point!)
        if isInButton {
            touchUpOutsideProcesser(buttonType)
        }
    }
    @IBAction func tapPercentButtonUpOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        let (isInButton, buttonType, _) = touchOutSideProcessed.touchUpOutsideProcesser(point!)
        if isInButton {
            touchUpOutsideProcesser(buttonType)
        }
    }
    //----drag exit----
    @IBAction func tapDotButtonDragExit(_ sender: UIButton) {
        let bkColor = TouchAndHighlight(sender, "dot")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tapCButtonDragExit(_ sender: UIButton) {
        let bkColor = TouchAndHighlight(sender, "func")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tapPEButtonDragExit(_ sender: UIButton) {
        let bkColor = TouchAndHighlight(sender, "func")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tapPercentButtonDragExit(_ sender: UIButton) {
        let bkColor = TouchAndHighlight(sender, "func")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    //----------------------------------------------
    //------------drag Outside----------------
    @IBAction func buttonDotDragOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        touchOutSideProcessed.button = sender
        touchOutSideProcessed.allButtonRect = buttonPositionArray
        touchOutSideProcessed.dragOutsideProcesser()
    }
    @IBAction func buttonCDragOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        touchOutSideProcessed.button = sender
        touchOutSideProcessed.allButtonRect = buttonPositionArray
        touchOutSideProcessed.dragOutsideProcesser()
    }
    @IBAction func buttonPEDragOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        touchOutSideProcessed.button = sender
        touchOutSideProcessed.allButtonRect = buttonPositionArray
        touchOutSideProcessed.dragOutsideProcesser()
    }
    @IBAction func buttonPercentDragOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        touchOutSideProcessed.button = sender
        touchOutSideProcessed.allButtonRect = buttonPositionArray
        touchOutSideProcessed.dragOutsideProcesser()
    }

    //-----------------------------------------------
    //-------touch down------
    @IBAction func tapDotButtonDown(_ sender: UIButton) {
        let bkColor = TouchAndHighlight(sender, "dot")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tapCButtonDown(_ sender: UIButton) {
        let bkColor = TouchAndHighlight(sender, "func")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tapPEButtonDown(_ sender: UIButton) {
        let bkColor = TouchAndHighlight(sender, "func")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tapPercentButtonDown(_ sender: UIButton) {
        let bkColor = TouchAndHighlight(sender, "func")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    //-----------------------------------------------
    //-----------------------------------------------
    //------touch in inside
    @IBAction func tapDotButon(_ sender: UIButton) {    //button .
        let bkColor = TouchAndHighlight(sender, "dot")
        sender.backgroundColor = bkColor.getNewColorToButton()
        equalButtonStart = false
        isPMTouched = false
        //var isDouble = false
        isDoubleTouchedEqual.reSet()
        let getCorrectTextStringPro = ConvertToAppropriateDataType(textString: resultTextView.text)
        let correctInputTextString = getCorrectTextStringPro.getInputAppropriateFormat(commandString: ".")
        resultTextView.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        resultTextView.text = ConvertToAppropriateDataType(textString: correctInputTextString).outWithAppropriateDataType()
        resultTextView.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        //カンマなし文字列の機能（元の機能)
        /*var outSting = getCorrevtTextString.getInputAppropriateFormat()
        for char in outSting.characters {
            if char == "." {// すでに"."があるかどうかを確かめる
                isDouble = true
            }
        }
        if !isDouble {
            outSting = outSting + "."
        }*/////xian zai
        /*for char in resultTextView.text.characters {
            if char == "." {// すでに"."があるかどうかを確かめる
                isDouble = true
            }
        }
        if !isDouble {
            resultTextView.text = resultTextView.text + "."
        }*/
    }
    @IBAction func tapCButton(_ sender: UIButton) {    //button C
        let bkColor = TouchAndHighlight(sender, "func")
        sender.backgroundColor = bkColor.getNewColorToButton()
        //resultTextView.text = "0"
        let getCorrectTextStringPro = ConvertToAppropriateDataType(textString: resultTextView.text)
        let correctInputTextString = getCorrectTextStringPro.getInputAppropriateFormat(commandString: "C")
        resultTextView.text = ConvertToAppropriateDataType(textString: correctInputTextString).outWithAppropriateDataType()
        nowOperator = nil
        operatorArray = []; operantArray = []
        output = 0
        touchedOperator = false
        isAlreadyCalcu = false
        isDoubleTouched.neverBeDoubleTouch()
        waitNextNum = false
        isDoubleTouchedEqual.reSet()
        equalButtonStart = true
        equalNeedFirstCal = true
        isPMTouched = false
    }
    @IBAction func tapPMButton(_ sender: UIButton) {   //button +/-
        let bkColor = TouchAndHighlight(sender, "func")
        sender.backgroundColor = bkColor.getNewColorToButton()
        equalButtonStart = false
        isDoubleTouchedEqual.reSet()
        isPMTouched = true
        //-------------------------------------
        //エラーと表示されていた場合に無視 2017/03/16
        //ここをコメントアウトすると、画面にエラーを表示されている時に
        //PMを押すと-０に戻る（元の機能）
        let outTemp = resultTextView.text!
        for char in outTemp.characters {
            if char == "エ" {
                return
            }
        }
        //-------------------------------------
        /*if isPMTouched {
            if resultTextView.text.hasPrefix("-") {
                resultTextView.text.remove(at: resultTextView.text.startIndex)
            }else {
                resultTextView.text.insert("-", at: resultTextView.text.startIndex)
            }
        }*/
        let getCorrectTextStringPro = ConvertToAppropriateDataType(textString: resultTextView.text)
        let correctInputTextString = getCorrectTextStringPro.getInputAppropriateFormat(commandString: "PM")
        resultTextView.text = ConvertToAppropriateDataType(textString: correctInputTextString).outWithAppropriateDataType()
        isPMTouched = false
    }
    @IBAction func tapPercentButton(_ sender: UIButton) {   //button %
        //          いらない機能、削除しました。無視してください
        // iOSのデフォルトの電卓には以下の問題があって、自作においてそれを解決した
        // 問題点
        /*----------------------------------------------------------------------
         123.00のように浮動小数点数なのに、％を押したら、最後の有効数字以下の0が全部なくなる
            デフォルト：  123456.000    ------  1234.56
            自作のやり方: 123456.000    ------  1234.56000
 　　　　　----------------------------------------------------------------------*/
        let bkColor = TouchAndHighlight(sender, "func")
        sender.backgroundColor = bkColor.getNewColorToButton()
        isPMTouched = false
        equalButtonStart = false
        isDoubleTouchedEqual.reSet()
        for char in resultTextView.text.characters {
            if char == "エ" {
                return
            }
        }
        var resultTemp = ConvertToAppropriateDataType(textString: resultTextView.text!).getInputAppropriateFormat(commandString: "%")
        var isDouble = false
        if resultTemp.hasSuffix(".") { //最後の文字が"."の場合、それを削除する
            //最後の文字が"."だったら、この前に"."がない（.ボタンの仕組みだから)
            //つまり、この数字が整数だ。
            let beforeLaseIndex = resultTemp.index(before: resultTemp.endIndex)
            resultTemp.remove(at: beforeLaseIndex)
            let doubleValue = Double(resultTemp)! / 100.0
            resultTextView.text = ConvertToAppropriateDataType(textString: String(doubleValue)).outWithAppropriateDataType()
        }else {//最後がドットでない場合はまず整数か浮動小数点数かを確かめる
            //9e-180のような場合、ドットがない
            for char in resultTemp.characters {
                if char == "." {
                    isDouble = true
                }
            }
            if !isDouble {//isDoubleっていう名前だが、Eeの場合もfalseだ
                /*let intValue = Int(resultTemp)! / 100 //いらない処理
                 resultTextView.text = String(intValue)*/
                if resultTemp != "percent over range エラー" {
                    let doubleValueTemp = Double(resultTemp)! / 100.0
                    //resultTextView.text = ConvertToAppropriateDataType(textString: String(doubleValueTemp)).outWithAppropriateDataType()
                    let (overZero, underZero) =
                        ((doubleValueTemp > 0 && ( doubleValueTemp < 1.0e-170 || doubleValueTemp > 1.0e170)),(doubleValueTemp < 0 && ( doubleValueTemp > -1.0e-170 || doubleValueTemp < -1.0e170)))
                    //if doubleValueTemp < 1.0e-170 || doubleValueTemp > 1.0e170 {
                    if doubleValueTemp == 0 {
                        resultTextView.text = "0"
                        return 
                    }
                    if overZero || underZero {
                        //なぜこの場合に0が含まれるかわからないが、次の文がないと
                        //0の時に%を押したら0.0になり、もう一回押す場合やっとエラーが出る
                        //2017/03/12 わかった、上の条件式の左が間違ったのだ
                        if doubleValueTemp == 0 {//????????????
                            resultTextView.text = "0"
                        }else {
                            resultTextView.text = ConvertToAppropriateDataType(textString: String(doubleValueTemp)).outWithAppropriateDataType()
                            //resultTextView.text = "percent over range エラー"
                            //operantArray = []; operatorArray = []
                            //output = 0.0
                        }
                    }else {
                        resultTextView.text = ConvertToAppropriateDataType(textString: String(doubleValueTemp)).outWithAppropriateDataType()
                    }
                }else {
                    operantArray = []; operatorArray = []
                    output = 0.0
                    resultTextView.text = "0"
                }
            }else {//小数点以下の数字をキャッチ
                let doubleValueTemp = Double(resultTemp)! / 100.0
                let (overZero, underZero) =
                    ((doubleValueTemp > 0 && ( doubleValueTemp < 1.0e-170 || doubleValueTemp > 1.0e170)),(doubleValueTemp < 0 && ( doubleValueTemp > -1.0e-170 || doubleValueTemp < -1.0e170)))
                if  overZero||underZero {
                    //resultTextView.text = "\(doubleValueTemp) エラー"
                    resultTextView.text = "percent over range エラー"
                    operantArray = []; operatorArray = []
                    output = 0.0
                }else {
                    resultTextView.text = ConvertToAppropriateDataType(textString: String(doubleValueTemp)).outWithAppropriateDataType()
                }
            }
        }
        /*-----------------------------------------------------------------------
        var resultTemp = resultTextView.text!
        var isDouble = false
        if resultTemp.hasSuffix(".") { //最後の文字が"."の場合、それを削除する
            //最後の文字が"."だったら、この前に"."がない（.ボタンの仕組みだから)
            //つまり、この数字が整数だ。
            let beforeLaseIndex = resultTemp.index(before: resultTemp.endIndex)
            resultTemp.remove(at: beforeLaseIndex)
            let doubleValue = Double(resultTemp)! / 100.0
            resultTextView.text = String(doubleValue)
        }else {//最後がドットでない場合はまず整数か浮動小数点数かを確かめる
            //9e-180のような場合、ドットがない
            for char in resultTemp.characters {
                if char == "." {
                    isDouble = true
                }
            }
            if !isDouble {
                /*let intValue = Int(resultTemp)! / 100 //いらない処理
                resultTextView.text = String(intValue)*/
                if resultTemp != "percent over エラー" {
                    let doubleValueTemp = Double(resultTemp)! / 100.0
                    if doubleValueTemp < 1.0e-170 || doubleValueTemp > 1.0e170 {
                        if doubleValueTemp == 0 {//????????????
                            resultTextView.text = "0"
                        }else {
                            resultTextView.text = "percent over エラー"
                            operantArray = []; operatorArray = []
                            output = 0.0
                        }
                    }else {
                        resultTextView.text = String(doubleValueTemp)
                    }

                }else {
                    operantArray = []; operatorArray = []
                    output = 0.0
                    resultTextView.text = "0"
                }
                //let doubleValueTemp = Double(resultTemp)! / 100.0
                /*if doubleValueTemp < 1.0e-170 || doubleValueTemp > 1.0e170 {
                    resultTextView.text = "エラー"
                    operantArray = []; operatorArray = []
                    output = 0.0
                }else {
                    resultTextView.text = String(doubleValueTemp)
                }*/
                //resultTextView.text = String(doubleValueTemp)
            }else {//小数点以下の数字をキャッチ
                //複雑なやり方、削除するのはもったいないと思うから、あえてコメントアウトする
                //var isAfterTheDecimalPoint = false
                //var doubleNumArray = [String]()
                
                /*for char in resultTemp.characters {
                    if char == "." {
                        isAfterTheDecimalPoint = true
                        continue
                    }
                    if isAfterTheDecimalPoint {
                        doubleNumArray.append(String(char))//いらない
                    }
                }*/
                /*let doubleValueTemp = Double(resultTemp)! / 100.0
                resultTextView.text = String(doubleValueTemp)
                let zeroNum = resultTemp.characters.count - resultTextView.text.characters.count
                if zeroNum > 0 {
                    resultTextView.text = "\(zeroNum)"
                    for _ in 0 ..< zeroNum {
                        resultTextView.text.append("0")
                    }
                }*/
                let doubleValueTemp = Double(resultTemp)! / 100.0
                if doubleValueTemp < 1.0e-170 || doubleValueTemp > 1.0e170 {
                    resultTextView.text = "\(doubleValueTemp)"
                    operantArray = []; operatorArray = []
                    output = 0.0
                }else {
                    resultTextView.text = String(doubleValueTemp)
                }
            }
        }
         -----------------------------------------------------------------------*/
    }
    //--------------------------------------------------------------------
    //                       演算子ボタン
    //                      +   -   *  /
    //--------------------------------------------------------------------
    //----touch up outside----
    @IBAction func tapDivButtonUpOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        let (isInButton, buttonType, _) = touchOutSideProcessed.touchUpOutsideProcesser(point!)
        if isInButton {
            touchUpOutsideProcesser(buttonType)
        }
    }
    @IBAction func tapMultiButtonUpOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        let (isInButton, buttonType, _) = touchOutSideProcessed.touchUpOutsideProcesser(point!)
        if isInButton {
            touchUpOutsideProcesser(buttonType)
        }
    }

    @IBAction func tapMinusButtonUpOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        let (isInButton, buttonType, _) = touchOutSideProcessed.touchUpOutsideProcesser(point!)
        if isInButton {
            touchUpOutsideProcesser(buttonType)
        }
    }

    @IBAction func tapPlusButtonUpOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        let (isInButton, buttonType, _) = touchOutSideProcessed.touchUpOutsideProcesser(point!)
        if isInButton {
            touchUpOutsideProcesser(buttonType)
        }
    }

    //------------drag Outside----------------
    @IBAction func buttonDivDragOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        touchOutSideProcessed.button = sender
        touchOutSideProcessed.allButtonRect = buttonPositionArray
        touchOutSideProcessed.dragOutsideProcesser()
    }
    @IBAction func buttonMultiDragOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        touchOutSideProcessed.button = sender
        touchOutSideProcessed.allButtonRect = buttonPositionArray
        touchOutSideProcessed.dragOutsideProcesser()
    }
    @IBAction func buttonMinusDragOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        touchOutSideProcessed.button = sender
        touchOutSideProcessed.allButtonRect = buttonPositionArray
        touchOutSideProcessed.dragOutsideProcesser()
    }
    @IBAction func buttonPlusDragOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        touchOutSideProcessed.button = sender
        touchOutSideProcessed.allButtonRect = buttonPositionArray
        touchOutSideProcessed.dragOutsideProcesser()
    }

    //----drag exit----
    @IBAction func tapDivButtonDragExit(_ sender: UIButton) {
        let bkColor = TouchAndHighlight(sender, "OE")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tapMultiButtonDragExit(_ sender: UIButton) {
        let bkColor = TouchAndHighlight(sender, "OE")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tapMinusButtonDragExit(_ sender: UIButton) {
        let bkColor = TouchAndHighlight(sender, "OE")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tapPlusButtonDragExit(_ sender: UIButton) {
        let bkColor = TouchAndHighlight(sender, "OE")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    //-----------------------------------------------
    //-------touch down------
    @IBAction func tapDivButtonDown(_ sender: UIButton) {
        let bkColor = TouchAndHighlight(sender, "OE")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tapMultiButtonDown(_ sender: UIButton) {
        let bkColor = TouchAndHighlight(sender, "OE")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tapMinusButtonDown(_ sender: UIButton) {
        let bkColor = TouchAndHighlight(sender, "OE")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    @IBAction func tapPlusButtonDown(_ sender: UIButton) {
        let bkColor = TouchAndHighlight(sender, "OE")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    //-----------------------------------------------
    //-----------------------------------------------

    @IBAction func tapDivButton(_ sender: UIButton) {
        let bkColor = TouchAndHighlight(sender, "OE")
        sender.backgroundColor = bkColor.getNewColorToButton()
        fourArithmeticOperationsfunc(operater: .divi)
 
    }
    @IBAction func tapMultiButton(_ sender: UIButton) {
        let bkColor = TouchAndHighlight(sender, "OE")
        sender.backgroundColor = bkColor.getNewColorToButton()
        fourArithmeticOperationsfunc(operater: .multi)
    }
    @IBAction func tapMinusButton(_ sender: UIButton) {
        let bkColor = TouchAndHighlight(sender, "OE")
        sender.backgroundColor = bkColor.getNewColorToButton()
        fourArithmeticOperationsfunc(operater: .minus)
    }
    @IBAction func tapPlusButton(_ sender: UIButton) {
        let bkColor = TouchAndHighlight(sender, "OE")
        sender.backgroundColor = bkColor.getNewColorToButton()
        fourArithmeticOperationsfunc(operater: .plus)
    }

    //--------------------------------------------------------------------
    //                         イコールボダん関数　=
    //--------------------------------------------------------------------
    //----touch up outside----
    @IBAction func tapEqualButtonUpOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        let (isInButton, buttonType, _) = touchOutSideProcessed.touchUpOutsideProcesser(point!)
        if isInButton {
            touchUpOutsideProcesser(buttonType)
        }
    }
    //----drag exit----------
    @IBAction func tapEqualButtonDragExit(_ sender: UIButton) {
        let bkColor = TouchAndHighlight(sender, "OE")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    //-----------------------------------------------
    //----------------------------------------------
    //-------------touch dragOutside----------------
    @IBAction func buttonEqualDragOutside(_ sender: UIButton, forEvent event: UIEvent) {
        let allTouches = event.allTouches
        let point = allTouches?.first?.location(in: self.view)
        touchOutSideProcessed.touchPoint = point!
        touchOutSideProcessed.button = sender
        touchOutSideProcessed.allButtonRect = buttonPositionArray
        touchOutSideProcessed.dragOutsideProcesser()
    }
    //-------touch down------
    @IBAction func tapEqualButtonDown(_ sender: UIButton) {
        let bkColor = TouchAndHighlight(sender, "OE")
        sender.backgroundColor = bkColor.getNewColorToButton()
    }
    //-----------------------------------------------
    //-----------------------------------------------
    @IBAction func tapEqualButton(_ sender: UIButton) {
        let bkColor = TouchAndHighlight(sender, "OE")
        sender.backgroundColor = bkColor.getNewColorToButton()
        isPMTouched = false
        //-------------------------------------
        //エラーと表示されていた場合に無視  2017/03/16
        //ここをコメントアウトすると、画面にエラーを表示されている時に
        //イコールを押すと０に戻る（元の機能）
        let outTemp = resultTextView.text!
        for char in outTemp.characters {
            if char == "エ" {
                return
            }
        }
        //-------------------------------------
        let getCorrectTextStringPro = ConvertToAppropriateDataType(textString: resultTextView.text)
        let correctInputTextString = getCorrectTextStringPro.getInputAppropriateFormat(commandString: "=")
        if let doubleValue = Double(correctInputTextString) {
            operantArray.append(doubleValue)
            //resultTextView.text = "\(operantArray[0])\(operatorArray[0])\(operantArray[1])\(operatorArray[1])\(operantArray[2])"
            //return
        }else {
            operantArray = []; operatorArray = []
            output = 0.0
            resultTextView.text = "0"
            return
        }
        if operantArray.count == 2 && operatorArray.count == 0 {
            operatorArray.append(nowOperator)
        }
        if operatorArray.count == 1 && operantArray.count == 2 && operatorArray[0] == .divi && operantArray[1] == 0 {
            resultTextView.text = "/0 エラー"
            operantArray = []; operatorArray = []
            output = 0.0
            return
        }
        //test
        //resultTextView.text = "operator: \(operatorArray.count) operant: \(operantArray.count)"
        //resultTextView.text = "\(operantArray[0])\(operatorArray[0])\(operantArray[1])\(operatorArray[1])\(operantArray[2])"
        //\(operatorArray[2])"
        //return
        //5+3*2=
        // a ? b ? c ?    operantArray.count = operatorArray.count (+1)
        if operantArray.count != operatorArray.count && operantArray.count != operatorArray.count+1 {
            operantArray = []; operatorArray = []
            output = 0.0
            isAlreadyCalcu = true
            resultTextView.text = "0"
            return
        }
        
        if operantArray.count == 2 && operatorArray.count == 1 && equalNeedFirstCal{
            isDoubleTouchedEqual.hasTouchedEqual()
            equalNeedFirstCal = false
            touchedOperator = true
            let operatorTrueLaseIndex = operatorArray.endIndex-1 > 0 ? operatorArray.endIndex-1:0
            let lastOperator = operatorArray[operatorTrueLaseIndex]
            let lastOperantTrueIndex = operantArray.endIndex - 1
            let lastOperantEle = operantArray[lastOperantTrueIndex]
            operantArray.remove(at: lastOperantTrueIndex)
            //operatorArray.remove(at:operatorTrueLaseIndex)
            if arithmeticProcesser(operant: operantArray, operator: operatorArray) {
                //計算成功 (a?b)?の形なので、(a?b)をオペラント配列に　次の?を演算子配列に初期化する
                //resultTextView.text = String(output)
                //operatorArray = [operatorArray[1]]
                operatorArray = [lastOperator]
                operantArray = [output, lastOperantEle]
                isDoubleTouchedEqual.operantTemp = operantArray[1]
                isDoubleTouchedEqual.operatorTemp = operatorArray[0]
                arithmeticProcesser(operant: operantArray, operator: operatorArray)
                isDoubleTouchedEqual.nowNum = output
                let outputString = ConvertToAppropriateDataType(textString: String(output))
                resultTextView.text = outputString.outWithAppropriateDataTypeByEqual()
                //適当な結果文字列を求める
                //resultTextView.text = String(output)
                //return
            }else {
                operantArray = []; operatorArray = []
                output = 0.0
                resultTextView.text = "0"
                return
            }
            //ダブルタッチをできるようにするため
            operantArray = []; operatorArray = []
            output = 0.0
            isAlreadyCalcu = true
            return
        }else if operantArray.count == 3 && operatorArray.count == 2 && equalNeedFirstCal {
            //二番目の演算子の方が優先度が高い場合
            //前の演算を全部終わらせる
            isDoubleTouchedEqual.hasTouchedEqual()
            equalNeedFirstCal = false
            touchedOperator = true
            //let operatorTrueLaseIndex = operatorArray.endIndex-1 > 0 ? operatorArray.endIndex-1:0
            //let lastOperator = operatorArray[operatorTrueLaseIndex]
            let lastOperantTrueIndex = operantArray.endIndex - 1
            let lastOperantEle = operantArray[lastOperantTrueIndex]
            operantArray.remove(at: lastOperantTrueIndex)
            waitNextNum = true// a+(b* C ) ?
            switch operatorArray[1] {
            case .multi:
                if operatorArray[0] == .plus {
                    output = operantArray[0] + (operantArray[1] * lastOperantEle)
                    isDoubleTouchedEqual.operatorTemp = operatorArray[0]
                    isDoubleTouchedEqual.nowNum = output
                    isDoubleTouchedEqual.operantTemp = operantArray[1] * lastOperantEle
                }else {
                    output = operantArray[0] - (operantArray[1] * lastOperantEle)
                    isDoubleTouchedEqual.operatorTemp = operatorArray[0]
                    isDoubleTouchedEqual.nowNum = output
                    isDoubleTouchedEqual.operantTemp = operantArray[1] * lastOperantEle
                }
            case .divi:
                if operatorArray[0] == .plus {
                    output = operantArray[0] + (operantArray[1] / lastOperantEle)
                    isDoubleTouchedEqual.operatorTemp = operatorArray[0]
                    isDoubleTouchedEqual.nowNum = output
                    isDoubleTouchedEqual.operantTemp = operantArray[1] / lastOperantEle
                }else {
                    output = operantArray[0] - (operantArray[1] / lastOperantEle)
                    isDoubleTouchedEqual.operatorTemp = operatorArray[0]
                    isDoubleTouchedEqual.nowNum = output
                    isDoubleTouchedEqual.operantTemp = operantArray[1] / lastOperantEle
                }
            default:
                resultTextView.text = "operator 3 エラー"
                break
            }
            waitNextNum = false
            //適当な結果文字列を求める
            let outputString = ConvertToAppropriateDataType(textString: String(output))
            resultTextView.text = outputString.outWithAppropriateDataTypeByEqual()
            //resultTextView.text = "result" + outputString.intString + outputString.dot + outputString.doubleString
            //return
            //resultTextView.text = String(output)
            operantArray = []; operatorArray = []
            output = 0.0
            isAlreadyCalcu = true
            return
        }
        
        if equalButtonStart {
            isDoubleTouchedEqual.reSet()
        }
        equalButtonStart = false
        /*if operatorArray.count == 1 && operatorArray[0] == .divi && operantArray.count == 0 {
         operantArray = []; operatorArray = []
         output = 0.0
         resultTextView.text = "0"
         return
         }*/
        //let (a,b) = (operantArray.count, operatorArray.count)
        if !isDoubleTouchedEqual.touchedEqual {
            if operantArray.count == 2 && operatorArray.count == 1 {
                isDoubleTouchedEqual.nowNum = operantArray[0]
                isDoubleTouchedEqual.operantTemp = operantArray[1]
                isDoubleTouchedEqual.operatorTemp = operatorArray[0]
            }else {
                operantArray = []; operatorArray = []
                output = 0.0
                resultTextView.text = "0"
            }
        }
        if operantArray.count == 2 && operatorArray.count == 1 {
            isDoubleTouchedEqual.hasTouchedEqual()//ダブルタッチ処理
        }
        if isDoubleTouchedEqual.isDoubleTouched() {
            isDoubleTouchedEqual.nowNum =  isDoubleTouchedEqual.doubleTouchProcessor(nowNum: isDoubleTouchedEqual.nowNum)
            //let isOverRange = LimitDoubleMax(num: isDoubleTouchedEqual.nowNum)
            if isDoubleTouchedEqual.nowNum > 9e290/*DBL_MAX*/ || isDoubleTouchedEqual.nowNum < -9e290/*DBL_MIN*/ {
                resultTextView.text = "\(isDoubleTouchedEqual.nowNum)over エラー"
                isDoubleTouchedEqual.reSet()
                operantArray = []; operatorArray = []
                output = 0.0
                isAlreadyCalcu = true
                equalNeedFirstCal = false
            }else {
                //適当な結果文字列を求める
                let outputString = ConvertToAppropriateDataType(textString: String(isDoubleTouchedEqual.nowNum))
                resultTextView.text = outputString.outWithAppropriateDataTypeByEqual()
                //resultTextView.text = String(isDoubleTouchedEqual.nowNum)
            }
            
            /*if !isOverRange.isOveRange {
             resultTextView.text = "エラー"
             isDoubleTouchedEqual.reSet()
             }*/
            operantArray = []; operatorArray = []
            output = 0.0
            isAlreadyCalcu = true
            return
            //resultTextView.text = "!!!"
        }else {
            //arithmeticProcesser(operant: operantArray, operator: operatorArray)
            if operatorArray.count == 1 {
                switch operatorArray[0] {//8*9 *3 =
                case .plus:
                    output = operantArray[0] + operantArray[1]
                case .minus:
                    output = operantArray[0] - operantArray[1]
                case .multi:
                    output = operantArray[0] * operantArray[1]
                case .divi:
                    if operantArray[1] == 0 {
                        resultTextView.text = "/0 エラー"
                    }else {
                        output = operantArray[0] / operantArray[1]
                    }
                }
                operantArray = []; operatorArray = []
                //operantArray.append(output)
            }else {
                let getCorrectTextStringPro = ConvertToAppropriateDataType(textString: resultTextView.text)
                let correctInputTextString = getCorrectTextStringPro.getInputAppropriateFormat(commandString: "=")
                if let doubleValue = Double(correctInputTextString) {
                    output = doubleValue
                }
                //output = Double(resultTextView.text!)!
            }
            if resultTextView.text != "エラー" {
                //適当な結果文字列を求める
                let outputString = ConvertToAppropriateDataType(textString: String(output))
                resultTextView.text = outputString.outWithAppropriateDataTypeByEqual()
                //resultTextView.text = String(output)
            }
            output = 0.0
            isAlreadyCalcu = true
            //isDoubleTouched.neverBeDoubleTouch()
            return
        }
        /*if let doubleValue = Double(resultTextView.text) {
            operantArray.append(doubleValue)
        }else {
            operantArray = []; operatorArray = []
            output = 0.0
            resultTextView.text = "0"
            return
        }
        if operantArray.count == 2 && operatorArray.count == 0 {
            operatorArray.append(nowOperator)
        }
        if operatorArray.count == 1 && operantArray.count == 2 && operatorArray[0] == .divi && operantArray[1] == 0 {
            resultTextView.text = "/0 エラー"
            operantArray = []; operatorArray = []
            output = 0.0
            return
        }
        //test
        //resultTextView.text = "operator: \(operatorArray.count) operant: \(operantArray.count)"
        //resultTextView.text = "\(operantArray[0])\(operatorArray[0])\(operantArray[1])\(operatorArray[1])\(operantArray[2])"
        //\(operatorArray[2])"
        //return
        //5+3*2=
        // a ? b ? c ?    operantArray.count = operatorArray.count (+1)
        if operantArray.count != operatorArray.count && operantArray.count != operatorArray.count+1 {
            operantArray = []; operatorArray = []
            output = 0.0
            isAlreadyCalcu = true
            return
        }
        if operantArray.count == operatorArray.count+1 && equalNeedFirstCal{
            isDoubleTouchedEqual.hasTouchedEqual()
            equalNeedFirstCal = false
            touchedOperator = true
            let operatorTrueLaseIndex = operatorArray.endIndex-1 > 0 ? operatorArray.endIndex-1:0
            let lastOperator = operatorArray[operatorTrueLaseIndex]
            let lastOperantTrueIndex = operantArray.endIndex - 1
            let lastOperantEle = operantArray[lastOperantTrueIndex]
            operantArray.remove(at: lastOperantTrueIndex)
            //operatorArray.remove(at:operatorTrueLaseIndex)
            if arithmeticProcesser(operant: operantArray, operator: operatorArray) {
                //計算成功 (a?b)?の形なので、(a?b)をオペラント配列に　次の?を演算子配列に初期化する
                //resultTextView.text = String(output)
                //operatorArray = [operatorArray[1]]
                operatorArray = [lastOperator]
                operantArray = [output, lastOperantEle]
                isDoubleTouchedEqual.operantTemp = operantArray[1]
                isDoubleTouchedEqual.operatorTemp = operatorArray[0]
                arithmeticProcesser(operant: operantArray, operator: operatorArray)
                isDoubleTouchedEqual.nowNum = output
                let outputString = ConvertToAppropriateDataType(textString: String(output))
                resultTextView.text = outputString.outWithAppropriateDataType()
                //適当な結果文字列を求める
                //resultTextView.text = String(output)
                //return
            }else {
                //二番目の演算子の方が優先度が高い場合
                //前の演算を全部終わらせる
                waitNextNum = true// a+(b* C ) ?
                switch operatorArray[1] {
                case .multi:
                    if operatorArray[0] == .plus {
                        output = operantArray[0] + (operantArray[1] * lastOperantEle)
                        isDoubleTouchedEqual.operatorTemp = operatorArray[0]
                        isDoubleTouchedEqual.nowNum = output
                        isDoubleTouchedEqual.operantTemp = operantArray[1] * lastOperantEle
                    }else {
                        output = operantArray[0] - (operantArray[1] * lastOperantEle)
                        isDoubleTouchedEqual.operatorTemp = operatorArray[0]
                        isDoubleTouchedEqual.nowNum = output
                        isDoubleTouchedEqual.operantTemp = operantArray[1] * lastOperantEle
                    }
                case .divi:
                    if operatorArray[0] == .plus {
                        output = operantArray[0] + (operantArray[1] / lastOperantEle)
                        isDoubleTouchedEqual.operatorTemp = operatorArray[0]
                        isDoubleTouchedEqual.nowNum = output
                        isDoubleTouchedEqual.operantTemp = operantArray[1] / lastOperantEle
                    }else {
                        output = operantArray[0] - (operantArray[1] / lastOperantEle)
                        isDoubleTouchedEqual.operatorTemp = operatorArray[0]
                        isDoubleTouchedEqual.nowNum = output
                        isDoubleTouchedEqual.operantTemp = operantArray[1] / lastOperantEle
                    }
                default:
                    resultTextView.text = "operator 3 エラー"
                    break
                }
                waitNextNum = false
                //適当な結果文字列を求める
                let outputString = ConvertToAppropriateDataType(textString: String(output))
                resultTextView.text = outputString.outWithAppropriateDataType()
                //resultTextView.text = "result" + outputString.intString + outputString.dot + outputString.doubleString
                return
                //resultTextView.text = String(output)
            }
            //ダブルタッチをできるようにするため
            operantArray = []; operatorArray = []
            output = 0.0
            isAlreadyCalcu = true
            return
        }
        if equalButtonStart {
            isDoubleTouchedEqual.reSet()
        }
        equalButtonStart = false
        /*if operatorArray.count == 1 && operatorArray[0] == .divi && operantArray.count == 0 {
            operantArray = []; operatorArray = []
            output = 0.0
            resultTextView.text = "0"
            return
        }*/
        if !isDoubleTouchedEqual.touchedEqual {
            if operantArray.count == 2 && operatorArray.count == 1 {
                isDoubleTouchedEqual.nowNum = operantArray[0]
                isDoubleTouchedEqual.operantTemp = operantArray[1]
                isDoubleTouchedEqual.operatorTemp = operatorArray[0]
            }else {
                operantArray = []; operatorArray = []
                output = 0.0
                resultTextView.text = "0"
            }
        }
        if operantArray.count == 2 && operatorArray.count == 1 {
            isDoubleTouchedEqual.hasTouchedEqual()//ダブルタッチ処理
        }
        if isDoubleTouchedEqual.isDoubleTouched() {
            isDoubleTouchedEqual.nowNum =  isDoubleTouchedEqual.doubleTouchProcessor(nowNum: isDoubleTouchedEqual.nowNum)
            //let isOverRange = LimitDoubleMax(num: isDoubleTouchedEqual.nowNum)
            if isDoubleTouchedEqual.nowNum > 9e290/*DBL_MAX*/ || isDoubleTouchedEqual.nowNum < -9e290/*DBL_MIN*/ {
                resultTextView.text = "\(isDoubleTouchedEqual.nowNum)over エラー"
                isDoubleTouchedEqual.reSet()
                operantArray = []; operatorArray = []
                output = 0.0
                isAlreadyCalcu = true
                equalNeedFirstCal = false
            }else {
                //適当な結果文字列を求める
                let outputString = ConvertToAppropriateDataType(textString: String(isDoubleTouchedEqual.nowNum))
                resultTextView.text = outputString.outWithAppropriateDataType()
                //resultTextView.text = String(isDoubleTouchedEqual.nowNum)
            }

            /*if !isOverRange.isOveRange {
                resultTextView.text = "エラー"
                isDoubleTouchedEqual.reSet()
            }*/
            operantArray = []; operatorArray = []
            output = 0.0
            isAlreadyCalcu = true
            return
            //resultTextView.text = "!!!"
        }else {
            //arithmeticProcesser(operant: operantArray, operator: operatorArray)
            if operatorArray.count == 1 {
                switch operatorArray[0] {//8*9 *3 =
                case .plus:
                    output = operantArray[0] + operantArray[1]
                case .minus:
                    output = operantArray[0] - operantArray[1]
                case .multi:
                    output = operantArray[0] * operantArray[1]
                case .divi:
                    if operantArray[1] == 0 {
                        resultTextView.text = "/0 エラー"
                    }else {
                        output = operantArray[0] / operantArray[1]
                    }
                }
                operantArray = []; operatorArray = []
                //operantArray.append(output)
            }else {
                if let doubleValue = Double(resultTextView.text) {
                    output = doubleValue
                }
                //output = Double(resultTextView.text!)!
            }
            if resultTextView.text != "エラー" {
                //適当な結果文字列を求める
                let outputString = ConvertToAppropriateDataType(textString: String(output))
                resultTextView.text = outputString.outWithAppropriateDataType()
                //resultTextView.text = String(output)
            }
            output = 0.0
            isAlreadyCalcu = true
            //isDoubleTouched.neverBeDoubleTouch()
            return
        }*/
    }
    
    //--------------------------------------------------------------------
    //                         数字ボダん関数
    //          func numButtonFunc(numberString: String)
    //　　　　　　引数： ボダんナンバー
    //--------------------------------------------------------------------
    @discardableResult
    func numButtonFunc(numberString n: String) -> Bool {
        equalButtonStart = false
        isPMTouched = false
        isDoubleTouched.neverBeDoubleTouch()//数字の場合は重複処理エラーがありえない
        isDoubleTouchedEqual.reSet()
        //計算できない場合、イコールを押しても計算しないように
        /*if operatorArray.count != 0 && operantArray.count == 0 {
            operatorArray = []; operantArray = []
            equalNeedFirstCal = false
        }else {
            equalNeedFirstCal = true
        }*/
        equalNeedFirstCal = true
        //var isDouble = false
        if touchedOperator {
            resultTextView.text = "0"
            touchedOperator = false
        }
        let getCorrevctInputTextString = ConvertToAppropriateDataType(textString: resultTextView.text)
        let inString = getCorrevctInputTextString.getInputAppropriateFormat(commandString: n)
        //let tempString = inString + n //1234567 7
        //let tempString = inString.appending(n)
        //---test 3/11 13:05
        let outStringIns = ConvertToAppropriateDataType(textString: inString)
        //return false
        resultTextView.text = outStringIns.outWithAppropriateDataType()
        //resultTextView.text = inString
        return true
        //----------------
        /*カンマ機能より廃止
        //let tempString = resultTextView.text + n
        for char in resultTextView.text.characters {
            if char == "." {
                isDouble = true
                break
            }
        }
        if isDouble {
            if n != "0" {
                if let doubleValue = Double(tempString) {
                    //適当な結果文字列を求める
                    let outputString = ConvertToAppropriateDataType(textString: String(doubleValue))
                    resultTextView.text = outputString.outWithAppropriateDataType()
                    //resultTextView.text = String(doubleValue)
                }
            }else {
                resultTextView.text = tempString//加えない
            }
        }else {
            if let intValue = Int(tempString) {
                //適当な結果文字列を求める
                let outputString = ConvertToAppropriateDataType(textString: String(intValue))
                resultTextView.text = outputString.outWithAppropriateDataType()
                //resultTextView.text = String(intValue)
            }
        }
        return true*/
    }
    //--------------------------------------------------------------------
    //                         四則演算ボダん関数
    //          func numButtonFunc(numberString: String)
    //　　　　　　引数： ボダンナンバー (((1+1)+)1 ) +
    //          1 +(+-*/) 1 ++ 1|   5 + 1*3 -1
    //--------------------------------------------------------------------
    @discardableResult
    func fourArithmeticOperationsfunc(operater o: Operator) -> Bool{
        /*equalNeedFirstCal = false
        if equalButtonStart {
            return false
        }
        equalButtonStart = false
        touchedOperator = true
        isDoubleTouched.insertElement(operatorEnum: o)
        isDoubleTouchedEqual.reSet()
        nowOperator = o
        if !isDoubleTouched.judgeIfDoubleTouched() {//ダブルタッチの場合戻る
            //resultTextView.text = "wrong"
            //equalNeedFirstCal = false
            return false
        }*/
        touchedOperator = true
        let getCorrectTextStringPro = ConvertToAppropriateDataType(textString: resultTextView.text)
        let correctInputTextString = getCorrectTextStringPro.getInputAppropriateFormat(commandString: o.rawValue)
        //resultTextView.text = correctInputTextString  //test
        //return false
        if let nowNum = Double(correctInputTextString) {
            //数字入力されなかった場合、無視
            nowOperator = o
            if operatorArray.count == 0 && nowNum == 0 {
                operantArray.append(0.0)
            }else {
                operantArray.append(nowNum)
            }
            if nowNum == 0 && operatorArray.count != 0{
                if operatorArray[operatorArray.endIndex-1] == .divi {
                    resultTextView.text = "/0　エラー"
                    operatorArray = []; operantArray = []
                    return false
                }
            }
        }else{
            resultTextView.text = "数字エラー,クリアしました。"
            operatorArray = []; operantArray = []
            return false
        }
        equalNeedFirstCal = false
        if equalButtonStart {
            return false
        }
        equalButtonStart = false
        touchedOperator = true
        isDoubleTouched.insertElement(operatorEnum: o)
        isDoubleTouchedEqual.reSet()
        if !isDoubleTouched.judgeIfDoubleTouched() {//ダブルタッチの場合戻る
            //resultTextView.text = "wrong"
            //equalNeedFirstCal = false
            return false
        }
        operatorArray.append(o)
        
        if operatorArray.count == 2 {
            //operantArray.append(Double(resultTextView.text)!)
            if arithmeticProcesser(operant: operantArray, operator: operatorArray) {
                //計算成功 (a?b)?の形なので、(a?b)をオペラント配列に　次の?を演算子配列に初期化する
                //適当な結果文字列を求める
                let outputString = ConvertToAppropriateDataType(textString: String(output))
                resultTextView.text = outputString.outWithAppropriateDataTypeByEqual()
                //resultTextView.text = String(output)
                operatorArray = [operatorArray[1]]
                operantArray = [output]
                isAlreadyCalcu = true
                //isDoubleTouched.neverBeDoubleTouch()
                isDoubleTouched.touchedOperator()
                //testのため
                //resultTextView.text = "operatorlength = \(operatorArray.count) operantlength = \(operantArray.count)"
                /*if operantArray.count == 1 && operatorArray.count == 1 {
                 resultTextView.text = //"output = \(output)  operant: \(operantArray[0])"
                 "operatorlength = \(operatorArray.count) operantlength = \(operantArray.count)\noperator: \(operatorArray[0]), operant: \(operantArray[0])"
                 }*/
                //resultTextView.text = "operator: \(operatorArray[0]), operant: \(operantArray[0])"
            }else {
                //二番目の演算子の方が優先度が高い場合
                //前の演算を全部終わらせる
                waitNextNum = true// a+(b* C ) ?
            }
        }else if operatorArray.count == 3 { //a+(b* C ) ?
            switch operatorArray[1] {
            case .multi:
                if operatorArray[0] == .plus {
                    output = operantArray[0] + (operantArray[1] * operantArray[2])
                }else {
                    output = operantArray[0] - (operantArray[1] * operantArray[2])
                }
            case .divi:
                if operatorArray[0] == .plus {
                    output = operantArray[0] + (operantArray[1] / operantArray[2])
                }else {
                    output = operantArray[0] - (operantArray[1] / operantArray[2])
                }
            default:
                resultTextView.text = "operator 3 エラー"
                break
            }
            waitNextNum = false
            //適当な結果文字列を求める
            let outputString = ConvertToAppropriateDataType(textString: String(output))
            resultTextView.text = outputString.outWithAppropriateDataTypeByEqual()
            //resultTextView.text = String(output)
            //test
            //resultTextView.text = "operator: \(operatorArray.count) operant: \(operantArray.count)"
            //resultTextView.text = "\(operantArray[0])\(operatorArray[0])\(operantArray[1])\(operatorArray[1])\(operantArray[2])\(operatorArray[2])"
            operatorArray = [operatorArray[2]]
            operantArray = [output]
            isAlreadyCalcu = true
            
        }
        return true
        /*if let nowNum = Double(resultTextView.text) {
            //数字入力されなかった場合、無視
            nowOperator = o
            if operatorArray.count == 0 && nowNum == 0 {
                operantArray.append(0.0)
            }else {
                operantArray.append(nowNum)
            }
            if nowNum == 0 && operatorArray.count != 0{
                if operatorArray[operatorArray.endIndex-1] == .divi {
                    resultTextView.text = "/0　エラー"
                    operatorArray = []; operantArray = []
                    return false
                }
            }
        }else{
            resultTextView.text = "数字エラー,クリアしました。"
            operatorArray = []; operantArray = []
            return false
        }
        equalNeedFirstCal = false
        if equalButtonStart {
            return false
        }
        equalButtonStart = false
        touchedOperator = true
        isDoubleTouched.insertElement(operatorEnum: o)
        isDoubleTouchedEqual.reSet()
        if !isDoubleTouched.judgeIfDoubleTouched() {//ダブルタッチの場合戻る
            //resultTextView.text = "wrong"
            //equalNeedFirstCal = false
            return false
        }
        operatorArray.append(o)
        
        if operatorArray.count == 2 {
            //operantArray.append(Double(resultTextView.text)!)
            if arithmeticProcesser(operant: operantArray, operator: operatorArray) {
                //計算成功 (a?b)?の形なので、(a?b)をオペラント配列に　次の?を演算子配列に初期化する
                //適当な結果文字列を求める
                let outputString = ConvertToAppropriateDataType(textString: String(output))
                resultTextView.text = outputString.outWithAppropriateDataType()
                //resultTextView.text = String(output)
                operatorArray = [operatorArray[1]]
                operantArray = [output]
                isAlreadyCalcu = true
                //isDoubleTouched.neverBeDoubleTouch()
                isDoubleTouched.touchedOperator()
                //testのため
                //resultTextView.text = "operatorlength = \(operatorArray.count) operantlength = \(operantArray.count)"
                /*if operantArray.count == 1 && operatorArray.count == 1 {
                    resultTextView.text = //"output = \(output)  operant: \(operantArray[0])"
                    "operatorlength = \(operatorArray.count) operantlength = \(operantArray.count)\noperator: \(operatorArray[0]), operant: \(operantArray[0])"
                }*/
                //resultTextView.text = "operator: \(operatorArray[0]), operant: \(operantArray[0])"
            }else {
                //二番目の演算子の方が優先度が高い場合
                //前の演算を全部終わらせる
                waitNextNum = true// a+(b* C ) ?
            }
        }else if operatorArray.count == 3 { //a+(b* C ) ?
            switch operatorArray[1] {
            case .multi:
                if operatorArray[0] == .plus {
                    output = operantArray[0] + (operantArray[1] * operantArray[2])
                }else {
                    output = operantArray[0] - (operantArray[1] * operantArray[2])
                }
            case .divi:
                if operatorArray[0] == .plus {
                    output = operantArray[0] + (operantArray[1] / operantArray[2])
                }else {
                    output = operantArray[0] - (operantArray[1] / operantArray[2])
                }
            default:
                resultTextView.text = "operator 3 エラー"
                break
            }
            waitNextNum = false
            //適当な結果文字列を求める
            let outputString = ConvertToAppropriateDataType(textString: String(output))
            resultTextView.text = outputString.outWithAppropriateDataType()
            //resultTextView.text = String(output)
            //test
            //resultTextView.text = "operator: \(operatorArray.count) operant: \(operantArray.count)"
            //resultTextView.text = "\(operantArray[0])\(operatorArray[0])\(operantArray[1])\(operatorArray[1])\(operantArray[2])\(operatorArray[2])"
            operatorArray = [operatorArray[2]]
            operantArray = [output]
            isAlreadyCalcu = true
            
        }
        return true*/
    }
    /*-----------------------------------------------------
     　　　　　　　　オペレーターの制限に関する制限
     　　縦画面の場合、一つの演算子と二つのオペラントを指定したら、
     次に"="を押さないまま新たな演算子を指定してオペンラント、強制的に
     今までの演算を実行する
     言い換えば、溜まる演算子の上限が2
     それを超えないように、演算子指定配列の長さを制限する関数をすぐ
     下に作っておく
     limitOperatorArrayLength(:[Operator]) -> Bool
     要素が2以下の場合はtrue,2より大きい場合はfalse
     　　-----------------------------------------------------*/
    func limitOperatorArrayLength(OperatorArray OA: [Operator]) -> Bool {
        if OA.count > 2 {
            return false
        }
        return true
    }
    /*-----------------------------------------------------
     　　　　　　　　　　　　　演算処理
     　　オペレーターの制限のような考え方から拡張して、"="を押すというのは
     今まで溜まった演算子とオペラントを計算するすると考えられ、そのため、
     演算処理を専用関数に任せた方が後ほど機能追加の時は楽だろうと
     @discardableResult
     arithmeticProcesser(:[Double], :[Operator]) -> Bool
     成功すれば true 失敗すればfalse(入力待ち)
     結果は全部浮動小数点数として描画する
     　-----------------------------------------------------*/
    @discardableResult
    func arithmeticProcesser(operant oUnit: [Double], operator oCommand: [Operator]) -> Bool {
        if oCommand.count == 1 {
            if oUnit.count == 2 {
                switch oCommand[0] {
                case .plus:
                    output = oUnit[0] + oUnit[1]
                case .minus:
                    output = oUnit[0] - oUnit[1]
                case .multi:
                    output = oUnit[0] * oUnit[1]
                case .divi:
                    output = oUnit[0] / oUnit[1]
                }
            }else {
                output = oUnit[0]
            }
            
        }else if oCommand.count == 2{//演算子が二つの場合
            switch oCommand[1] {
            case .multi:// a?b*c   a+-b*c  a*/b *c
                if oCommand[0] == .plus || oCommand[0] == .minus {
                    return false
                }else if oCommand[0] == .multi {
                    output = oUnit[0] * oUnit[1]
                }else if oCommand[0] == .divi {
                    output = oUnit[0] / oUnit[1]
                }
            case .divi:
                if oCommand[0] == .plus || oCommand[0] == .minus {
                    return false
                }else if oCommand[0] == .multi {
                    output = oUnit[0] * oUnit[1]
                }else if oCommand[0] == .divi {
                    output = oUnit[0] / oUnit[1]
                }
            case .minus:
                fallthrough
            case .plus:// a?b+c  a+-b+c  a*/b +c
                if oCommand[0] == .plus {
                    output = oUnit[0] + oUnit[1]
                }else if oCommand[0] == .minus {
                    output = oUnit[0] - oUnit[1]
                }else if oCommand[0] == .multi {
                    output = oUnit[0] * oUnit[1]
                }else {
                    output = oUnit[0] / oUnit[1]
                }
            }
            
        }else {
            resultTextView.text = "エラー, count = \(oCommand.count)"
        }
        return true
    }

}

