/*
 1주차
 21.06.04
 https://github.com/skyqnaqna/2021_iOS_Study
 */

import Foundation

// Arrays
var emptyArray = [Int]() // 빈 배열 생성
print(emptyArray.count, emptyArray.isEmpty) // 0 true

// 기본 값 설정
var sixNums = [Int](repeating: 6, count: 6)
var fourNums = [Int](repeating: 4, count: 4)

// 두 배열 더해서 초기화하기
var tenNums = sixNums + fourNums
print(tenNums) // [6, 6, 6, 6, 6, 6, 4, 4, 4, 4]

// Accessing and Modifying
// 추가
emptyArray.append(10)
emptyArray += [9, 8, 7]
emptyArray.insert(6, at: 1)
print(emptyArray) // [10, 6, 9, 8, 7]

// 접근
print(emptyArray[0], emptyArray.first) // 10 Optional(10)

print(emptyArray) // [10, 6, 9, 8, 7]
emptyArray[1...3] = [3, 3]
print(emptyArray) // [10, 3, 3, 7]

print(emptyArray.removeLast()) // 7
print(emptyArray) // [10, 3, 3]

// Iteraing
for num in fourNums{
  print(num)
}
/*
 4
 4
 4
 4
 */

for (index, num) in fourNums.enumerated() {
  print("\(index) : \(num)")
}
/*
 0 : 4
 1 : 4
 2 : 4
 3 : 4
 */

// Dictionaries
var emptyDic = [Int: String]()
var ascii = ["A": 65, "B": 66, "C": 67]

// Accessing and Modifying
print(ascii.count, ascii.isEmpty) // 3 false

// 추가
ascii["D"] = 6888
// 수정
ascii["D"] = 68

emptyDic[2] = "three"
if let oldValue = emptyDic.updateValue("two", forKey: 2) {
  print(oldValue) // three
}

if let num = emptyDic[2] {
  print(num) // two
}

emptyDic[2] = nil
print(emptyDic.count, emptyDic.isEmpty) // 0 true

if let removeValue = ascii.removeValue(forKey: "D") {
  print(removeValue, ascii) // 68 ["A": 65, "B": 66, "C": 67]
}

// Iterating
for (text, decimal) in ascii {
  print("\(text) is \(decimal)")
}
/*
 C is 67
 A is 65
 B is 66
 */

for text in ascii.keys {
  print(text)
}
/*
 C
 A
 B
 */

for decimal in ascii.values {
  print(decimal)
}
/*
 67
 65
 66
 */

// Sets
var alphabet = Set<Character>() // var alphabet: Set<Character> = []

// 추가
alphabet.insert("a")
alphabet.insert("b")

// Accessing and Modifying
print(alphabet.count, alphabet.isEmpty) // 2 false

if let removed = alphabet.remove("b") {
  print(removed) // b
}

if alphabet.contains("a") {
  print("exist")
} else {
  print("not exist")
}
// exist

// Iterating
let digits: Set<Int> = [9,8,7,6,5,4,3,2,1,0]

for digit in digits {
  print(digit, terminator: " ")
} // 8 6 5 7 9 4 3 2 1 0

print()

for digit in digits.sorted() { // 오름차순으로 정렬
  print(digit, terminator: " ")
} // 0 1 2 3 4 5 6 7 8 9

print()

// Set Operations
let a: Set<Int> = [1, 2, 4, 6, 8]
let b: Set<Int> = [1, 3, 6, 9, 12]

print(a.union(b).sorted()) // [1, 2, 3, 4, 6, 8, 9, 12]
print(a.intersection(b).sorted()) // [1, 6]
print(a.subtracting(b).sorted()) // [2, 4, 8]
print(a.symmetricDifference(b).sorted()) // [2, 3, 4, 8, 9, 12]

let c: Set<Int> = [2]

print(c.isSubset(of: a)) // true
print(a.isSuperset(of: c)) // true
print(c.isDisjoint(with: b)) // true

// Enumerations
enum Drink {
  case water
  case coke
  case milk
  case coffee
  case beer
}

var myPick = Drink.coffee
myPick = .beer

// Matching Enumeration Values with a Switch Statement
switch myPick {
case .water:
  print("Ice water")
case .coke:
  print("Coca Cola")
case .milk:
  print("Seoul Milk")
case .coffee:
  print("Ice Americano")
case .beer:
  print("Guinness")
}
// Guinness

// 원시 값 Raw Value
enum WeekDays: Character {
  case mon = "월", tue = "화", wed = "수", thu = "목", fri = "금", sat = "토", sun = "일"
}

let today = WeekDays.fri
print("오늘은 \(today.rawValue)요일입니다.") // 오늘은 금요일입니다.

enum Numbers: Int {
  case zero, one, two, six = 6
}

let one = Numbers(rawValue: 1) // one
let three = Numbers(rawValue: 3) // nil

print(Numbers.zero.rawValue, Numbers.one.rawValue, Numbers.two.rawValue, Numbers.six.rawValue) // 0 1 2 6

// 연관 값 Associated Values
enum Drink2 {
  case water
  case coke(zeroSugar: Bool)
  case milk(lowFat: Bool)
  case coffee(shot: Int)
  case beer(brand: String)
}

var myOrder = Drink2.coffee(shot: 2)
myOrder = .coke(zeroSugar: true)

// Iterating
// 열거형에 포함된 모든 케이스를 알기 위해서 CaseIterable 프로토콜을 채택한다
enum TopSize: CaseIterable {
  case S, M, L, XL
}

let allCases = TopSize.allCases
print(allCases) // [swiftTest.TopSize.S, swiftTest.TopSize.M, swiftTest.TopSize.L, swiftTest.TopSize.XL]

// 원시값을 갖는 열거형의 항목 순회
enum BottomSize: Int, CaseIterable {
  case S = 90
  case M = 95
  case L = 100
  case XL = 105
}

let allCases2 = BottomSize.allCases
print(allCases2) // [swiftTest.BottomSize.S, swiftTest.BottomSize.M, swiftTest.BottomSize.L, swiftTest.BottomSize.XL]

// 순환 열거형 Recursive Enumerations
// 열거형 항목의 연관 값이 열거의 다른 인스턴스를 갖는(열거형 자신의 값) 열거
// 특정 항목에 순환 열거형 항목 명시
enum ArithmeticExpression {
  case number(Int)
  indirect case addition(ArithmeticExpression, ArithmeticExpression)
  indirect case mulitplication(ArithmeticExpression, ArithmeticExpression)
}

// 열거형 전체에 순환 열거형 명시
indirect enum ArithmeticExp {
  case number(Int)
  case addition(ArithmeticExpression, ArithmeticExpression)
  case mulitplication(ArithmeticExpression, ArithmeticExpression)
}

// (5 + 4) * 2
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.mulitplication(sum, ArithmeticExpression.number(2))

print(product)
// mulitplication(swiftTest.ArithmeticExpression.addition(swiftTest.ArithmeticExpression.number(5), swiftTest.ArithmeticExpression.number(4)), swiftTest.ArithmeticExpression.number(2))

func evaluate(_ expression: ArithmeticExpression) -> Int {
  switch expression {
  case let .number(value):
    return value
  case let .addition(left, right):
    return evaluate(left) + evaluate(right)
  case let .mulitplication(left, right):
    return evaluate(left) * evaluate(right)
  }
}

print(evaluate(product)) // 18
