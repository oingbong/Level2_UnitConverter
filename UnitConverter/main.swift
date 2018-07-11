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

// 문자열 나누기
func divideUnit(input:String) -> StringTuple {
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
    }else if firstStr.contains("yard"){
        index = -4
    }
    let result: StringTuple = (firstStr, lastStr, index)
    return result
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

// Unit 비교
func compareUnit(UnitTuple:UnitTuple){
    
    let firstUnit = UnitTuple.first
    let lastUnit = UnitTuple.last
    let value = UnitTuple.value
    
    let units = (firstUnit, lastUnit)
    
    switch units {
    case ("cm","m"):
        let result = convertCMtoM(number: value)
        print("\(result)m")
    case ("cm","inch"):
        let result = convertCMtoINCH(number: value)
        print("\(result)inch")
    case ("cm","yard"):
        let result = convertCMtoYARD(number: value)
        print("\(result)yard")
    case ("cm","cm"):
        let result = convertCMtoM(number: value)
        print("\(result)m")
    case ("m","cm"):
        let result = convertMtoCM(number: value)
        print("\(result)cm")
    case ("m","inch"):
        // m -> cm -> inch
        let cm = convertMtoCM(number: value)
        let result = convertCMtoINCH(number: cm)
        print("\(result)inch")
    case ("m","yard"):
        let cm = convertMtoCM(number: value)
        let result = convertCMtoYARD(number: cm)
        print("\(result)yard")
    case ("m","m"):
        let result = convertMtoCM(number: value)
        print("\(result)cm")
    case ("inch","cm"):
        let result = convertINCHtoCM(number: value)
        print("\(result)cm")
    case ("inch","m"):
        // inch -> cm -> m
        let cm = convertINCHtoCM(number: value)
        let result = convertCMtoM(number: cm)
        print("\(result)m")
    case ("inch","yard"):
        // inch -> cm -> yard
        let cm = convertINCHtoCM(number: value)
        let result = convertCMtoYARD(number: cm)
        print("\(result)yard")
    case ("inch","inch"):
        // inch -> cm -> yard
        let cm = convertINCHtoCM(number: value)
        let result = convertCMtoM(number: cm)
        print("\(result)m")
    case ("yard","m"):
        let cm = convertYARDtoCM(number: value)
        let result = convertCMtoM(number: cm)
        print("\(result)m")
    case ("yard","cm"):
        let result = convertYARDtoCM(number: value)
        print("\(result)cm")
    case ("yard","inch"):
        let cm = convertYARDtoCM(number: value)
        let result = convertCMtoINCH(number: cm)
        print("\(result)inch")
    case ("yard","yard"):
        let cm = convertYARDtoCM(number: value)
        let result = convertCMtoM(number: cm)
        print("\(result)m")
    default:
        print("지원하지 않는 단위입니다.")
    }
}

func convertCMtoM(number:Double) -> Double{
    let value = number / 100
    return value
}
func convertMtoCM(number:Double) -> Double{
    let value = number * 100
    return value
}
func convertCMtoINCH(number:Double) -> Double{
    let value = number / 2.54
    return value
}
func convertINCHtoCM(number:Double) -> Double{
    let value = number * 2.54
    return value
}
func convertCMtoYARD(number:Double) -> Double{
    let value = number / 91.44
    return value
}
func convertYARDtoCM(number:Double) -> Double{
    let value = number * 91.44
    return value
}

// 실행
var play:Bool = true
while(play){
    play = main()
}
