/*
 1주차
 21.06.06
 https://github.com/skyqnaqna/2021_iOS_Study
 */

import Foundation

// 함수 타입
func countOddNums(_ arr: inout [Int]) -> Int {
  var result = 0

  for num in arr {
    if num % 2 != 0 {
      result += 1
    }
  }

  return result
}

func countEvenNums(_ arr: inout [Int]) -> Int {
  var result = 0

  for num in arr {
    if num % 2 == 0 {
      result += 1
    }
  }

  return result
}

var nums = [0,1,2,3,4,5,6,7,8,9, 10]
var numOfOdd: (inout [Int]) -> Int = countOddNums

print(numOfOdd(&nums)) // 5

// 전달인자를 함수로 전달받는 함수
func printCountResult(_ countFunc: (inout [Int]) -> Int, _ arr: inout [Int]) {
  print("count : \(countFunc(&arr)) total : \(arr.count)")
}

printCountResult(countOddNums, &nums) // count : 5 total : 11

// 함수를 반환하는 함수
func chooseFunction(_ countEven: Bool) -> (inout [Int]) -> Int {
  return countEven ? countEvenNums : countOddNums
}

printCountResult(chooseFunction(true), &nums) // count : 6 total : 11

// 중첩 함수
typealias MoveFunc = (Int) -> Int

func functionForMove(_ shouldGoLeft: Bool) -> MoveFunc {
  func goRight(_ currentPosition: Int) -> Int {
    return currentPosition + 1
  }

  func goLeft(_ currentPosition: Int) -> Int {
    return currentPosition - 1
  }

  return shouldGoLeft ? goLeft : goRight
}

var position = -3

let moveToZero: MoveFunc = functionForMove(position > 0)

while position != 0 {
  print(position)
  position = moveToZero(position)
}
// -3
// -2
// -1

// 비반환 함수
func crashAndBurn() -> Never {
  fatalError("Something wrong")
}

crashAndBurn()

func someFunc(isAllIsWell: Bool) {
  guard isAllIsWell else {
    print("멈춰!")
    crashAndBurn()
  }
  print("All is well")
}

someFunc(isAllIsWell: true)
someFunc(isAllIsWell: false)

// 반환 값 무시 함수
func say(_ str: String) -> String {
  print(str)
  return str
}

@discardableResult func discardSay(_ str: String) -> String {
  print(str)
  return str
}

say("Hello") // 컴파일러가 경고 표시
discardSay("Hi") // 경고 ㄴㄴ

// 옵셔널
var optStr: String? = nil
var str: String = nil // error

// switch를 통한 옵셔널 값 확인
func checkOptionalValue(value optionalValue: Any?) {
  switch optionalValue {
  case .none:
    print("This Optional variable is nil")
  case .some(let value):
    print("Value is \(value)")
  }
}

checkOptionalValue(value: optStr) // This Optional variable is nil

let numbers: [Int?] = [2, nil, -4, 0]

for number in numbers {
  switch number {
  case .some(let val) where val < 0 :
    print("Negative value")
  case .some(let val) where val > 0:
    print("Positive value")
  case .some(let val):
    print("Zero")
  case .none:
    print("nil")
  }
}
/*
 Positive value
 nil
 Negative value
 Zero
 */

// 옵셔널 바인딩
var myName: String? = "subin"

if let name = myName {
  print(name)
} else {
  print("name == nil")
} // subin

var myAge: Int? = 99

if let name = myName, let age = myAge {
  print("My name is \(name). I'm \(age) years old")
} // My name is subin. I'm 99 years old

// 암시적 추출 옵셔널
let lang: String? = "Python"
let py: String = lang! // 강제 추출
print(py) // Python

let lang2: String! = "Swift"
let swift: String = lang2 // 강제 추출 필요X
print(swift) // Swfit
