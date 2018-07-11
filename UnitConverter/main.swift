//
//  main.swift
//  UnitConverter
//
//  Created by oingbong on 2018. 7. 9..
//  Copyright © 2018년 oingbong. All rights reserved.
//

import Foundation

// 인치 길이 변환과 예외 처리

// 값 받기
func main(){
    print("값을 입력하세요 ex : 18cm inch")
    let inputValue = readLine()
    if let input = inputValue {
        divideUnit(input: input)
    }
}

// 문자열 나누기
func divideUnit(input:String){
    let separatorStr = input.split(separator: " ")
    let firstStr:String = String(separatorStr.first!)
    let lastStr:String = String(separatorStr.last!)
    
    var index:Int = 0
    if firstStr.contains("cm"){
        index = -2
    }else if firstStr.contains("m"){
        index = -1
    }else if firstStr.contains("inch"){
        index = -4
    }
    extractUnit(firstStr: firstStr, lastUnit: lastStr, index: index)
}

// Number, Unit 구하기
func extractUnit(firstStr:String, lastUnit:String, index:Int){
    
    // 숫자 추출 및 Double로 변환
    let indexEndOfText = firstStr.index(firstStr.endIndex, offsetBy: index)
    let beforeNumber = firstStr[..<indexEndOfText]
    let doubleNumber:Double = Double(beforeNumber)!
    
    // 첫 번째 Unit 구하기
    let numberIndex = firstStr.count + index
    let indexStartOfText = firstStr.index(firstStr.startIndex, offsetBy: numberIndex)
    let firstUnit:String = String(firstStr[indexStartOfText...])
    
    compareUnit(firstUnit: firstUnit, lastUnit: lastUnit, doubleNumber: doubleNumber)
}

// Unit 비교
func compareUnit(firstUnit:String, lastUnit:String, doubleNumber:Double){
    let units = (firstUnit, lastUnit)
    switch units {
        // cm   -> m
        // cm   -> inch
        // m    -> cm
        // m    -> inch
        // inch -> cm
    // inch -> m
    case ("cm","m"):
        let result = convertCMtoM(number: doubleNumber)
        print("\(result)m")
    case ("cm","inch"):
        let result = convertCMtoINCH(number: doubleNumber)
        print("\(result)inch")
    case ("m","cm"):
        let result = convertMtoCM(number: doubleNumber)
        print("\(result)cm")
    case ("m","inch"):
        // m -> cm -> inch
        let cm = convertMtoCM(number: doubleNumber)
        let result = convertCMtoINCH(number: cm)
        print("\(result)inch")
    case ("inch","cm"):
        let result = convertINCHtoCM(number: doubleNumber)
        print("\(result)cm")
    case ("inch","m"):
        // inch -> cm -> m
        let cm = convertINCHtoCM(number: doubleNumber)
        let result = convertCMtoM(number: cm)
        print("\(result)m")
    default:
        print("지원하지 않는 단위입니다.")
        main()
    }
}

func convertCMtoM(number:Double) -> Double{
    let value = number / 100
    return value
}
func convertCMtoINCH(number:Double) -> Double{
    let value = number / 2.54
    return value
}
func convertMtoCM(number:Double) -> Double{
    let value = number * 100
    return value
}
func convertINCHtoCM(number:Double) -> Double{
    let value = number * 2.54
    return value
}

// 실행
main()
