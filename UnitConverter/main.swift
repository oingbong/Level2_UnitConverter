//
//  main.swift
//  UnitConverter
//
//  Created by oingbong on 2018. 7. 9..
//  Copyright © 2018년 oingbong. All rights reserved.
//

/*
 완료된 작업 내용
 1. 함수 로직 수정 : 줄줄이 이어지는 -> 하나의 작업 후 리턴
 2. 단위별 Default 값 설정
 3. 입력 반복
 4. 종료키
 5. enum 사용
 6. CharacterSet 응용하여 함수 만듬
*/

import Foundation

// 인치 길이 변환과 예외 처리

typealias StringTuple = (first: String, last: String, index: Int)
typealias UnitTuple = (first: String, last: String, value: Double)

// 값 받기
func main() -> Bool {
    print("값을 입력하세요 ex : 18cm inch // 종료는 q 혹은 quit")
    let inputValue = readLine()
    
    // 종료하기
    if inputValue == "q" || inputValue == "quit" {
        return false
    }
    
    if let input = inputValue {
        let divide: StringTuple = divideUnit(input: input)
        let extract: UnitTuple = extractUnit(StringTuple: divide)
        compareUnit(UnitTuple: extract)
    }

    return true
}

enum LengthUnit:Double{
    case Cm = 1
    case M = 100
    case Inch = 2.54
    case Yard = 91.44
}

// 문자열 나누기
func divideUnit(input:String) -> StringTuple {
    let separatorStr = input.split(separator: " ")
    let firstStr:String = String(separatorStr.first!)
    let lastStr:String = String(separatorStr.last!)
    
    let index:Int = getIndex(characters: firstStr)
    let result: StringTuple = (firstStr, lastStr, index)
    
    return result
}

func getIndex(characters:String) -> Int {
    let characterSet:String = "abcdefghijklmnopqrstuvwxyz"

    var characters:String = characters
    // startindex값부터 순서대로 확인후 characterSet에 포함되지 않은 경우 지워주고 포함되면 멈춥니다.
    for character in characters {
        if characterSet.contains(character){
            break
        }else{
            characters.remove(at: characters.startIndex)
        }
    }
    
    // ex : 2 -> -2 / 4 -> -4 convert
    let index:Int = characters.count - 2 * characters.count
    return index
}

// Number, Unit 구하기
func extractUnit(StringTuple: StringTuple) -> UnitTuple {
    
    let firstStr = StringTuple.first
    let lastStr = StringTuple.last
    let index = StringTuple.index
    
    // 숫자 추출 및 Double로 변환
    let indexEndOfText = firstStr.index(firstStr.endIndex, offsetBy: index)
    let beforeNumber = firstStr[..<indexEndOfText]
    let doubleNumber:Double = Double(beforeNumber)!
    
    // 첫 번째 Unit 구하기
    let numberIndex = firstStr.count + index
    let indexStartOfText = firstStr.index(firstStr.startIndex, offsetBy: numberIndex)
    let firstUnit:String = String(firstStr[indexStartOfText...])
    
    // 두 번째 Unit 구하기 : 두번째 값이 입력받지 않은 경우 firstUnit으로 세팅합니다.
    let lastUnit:String = firstStr == lastStr ? firstUnit : lastStr
    
    // 리턴값
    let result:UnitTuple = (firstUnit, lastUnit, doubleNumber)
    return result
}

func convertUnit(unit:String, value:Double, isCM:Bool) -> Double{
    // isCM = true  -> *
    // isCM = false -> /
    var number:Double = 0
    var result:Double = 0
    
    switch unit {
    case "m":
        number = LengthUnit.M.rawValue
    case "inch":
        number = LengthUnit.Inch.rawValue
    case "yard":
        number = LengthUnit.Yard.rawValue
    default:
        number = LengthUnit.Cm.rawValue
    }
    
    if isCM {
        result = value * number
    }else{
        result = value / number
    }
    
    return result
}

// Unit 비교
func compareUnit(UnitTuple:UnitTuple){
    let firstUnit = UnitTuple.first
    var lastUnit = UnitTuple.last
    let value = UnitTuple.value
    
    var result:Double = 0
    
    // 1) cm 으로 변환하거나 건너뛰거나
    if firstUnit == "cm" {
        // 그대로 세팅
        result = value
    }else{
        // cm 로 변환 (Default)
        result = convertUnit(unit: firstUnit, value: value, isCM: true)
    }
    
    // 2) last 값에 따라 분기
    if firstUnit == lastUnit {
        // m -> cm or !m -> m
        if firstUnit == "m" {
            // 그대로 위에서 나온 값 전달
            // lastUnit을 cm 으로 지정
            lastUnit = "cm"
        }else{
            // unit을 m 으로 지정해서 변환
            // lastUnit을 m 으로 지정
            result = convertUnit(unit: "m", value: result, isCM: false)
            lastUnit = "m"
        }
    }else if lastUnit == "cm" {
        // 그대로 위에서 나온 값 전달
    }else{
        // last 값에 따라 변환
        result = convertUnit(unit: lastUnit, value: result, isCM: false)
    }
    
    print("\(result)\(lastUnit)")
}

// 실행
var play:Bool = true
while(play){
    play = main()
}
