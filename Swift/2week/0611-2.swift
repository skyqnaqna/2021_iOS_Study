/*
 2주차
 21.06.11
 https://github.com/skyqnaqna/2021_iOS_Study
 */

// 기본 클로저
let temp = ["abc", "back", "goal", "zip", "hole"]

func backwards(first: String, second: String) -> Bool {
  return first > second
}

print(temp.sorted(by: backwards))
// ["zip", "hole", "goal", "back", "abc"]

// backwards 함수의 클로저 표현
print(temp.sorted(by: { (first: String, second: String) -> Bool in
  return first > second
}))
// ["zip", "hole", "goal", "back", "abc"]

// 후행 클로저 사용
print(temp.sorted() { (first: String, second: String) -> Bool in
  return first > second
})
// ["zip", "hole", "goal", "back", "abc"]

// 메서드의 소괄호 생략
print(temp.sorted { (first: String, second: String) -> Bool in
  return first > second
})
// ["zip", "hole", "goal", "back", "abc"]

// 클로저의 타입 유추 - 매개변수 타입과 반환 타입 생략
print(temp.sorted { (first, second) in
  return first > second
})
// ["zip", "hole", "goal", "back", "abc"]

// 단축 인자 이름 사용
print(temp.sorted {
  return $0 > $1
})
// ["zip", "hole", "goal", "back", "abc"]

// 암시적 반환 표현
print(temp.sorted { $0 > $1 })
// ["zip", "hole", "goal", "back", "abc"]

// 클로저로서의 연산자 함수 사용
print(temp.sorted(by: >))
// ["zip", "hole", "goal", "back", "abc"]

// 값 획득
func makeIncrementer(forIncrement amount: Int) -> (() -> Int) {
  var runningTotal = 0
  func incrementer() -> Int {
    runningTotal += amount
    return runningTotal
  }
  return incrementer
}

let incrementByTwo: (() -> Int) = makeIncrementer(forIncrement: 2)

let first = incrementByTwo()
let second = incrementByTwo()
let third = incrementByTwo()

print(first, second, third) // 2, 4, 6

let incrementByTen: (() -> Int) = makeIncrementer(forIncrement: 10)

let ten = incrementByTen()
let twenty = incrementByTen()
let thirty = incrementByTen()

print(ten, twenty, thirty) // 10 20 30

// 참조 타입인 클로저
let incrementByTwo2: (() -> Int) = incrementByTwo

let fourth = incrementByTwo()
let fifth = incrementByTwo2()

print(fourth, fifth) // 8 10

// 함수를 탈출하는 클로저
typealias VoidVoidClosure = () -> Void
let firstClosure: VoidVoidClosure = {
  print("Closure A")
}

let secondClosure: VoidVoidClosure = {
  print("Closure B")
}

// first와 second 매개변수 클로저는 함수의 반환 값으로 사용될 수 있으므로 탈출 클로저
func returnOneClosure(first: @escaping VoidVoidClosure, second: @escaping VoidVoidClosure, shouldReturnFirstClosure: Bool) -> VoidVoidClosure {
  // 전달인자로 전달받은 클로저를 함수 외부로 다시 반환하기 때문에 함수를 탈출하는 클로저임
  return shouldReturnFirstClosure ? first : second
}

// 함수에서 반환한 클로저가 함수 외부의 상수에 저장됨
let returnedClosure: VoidVoidClosure = returnOneClosure(first: firstClosure, second: secondClosure, shouldReturnFirstClosure: true)

returnedClosure() // Closure A

var closures: [VoidVoidClosure] = []

// closure 매개변수 클로저는 함수 외부의 변수에 저장될 수 있으므로 탈출 클로저
func appendClosures(closure: @escaping VoidVoidClosure) {
  // 전달인자로 전달받은 클로저가 함수 외부의 변수 내부에 저장되므로 함수를 탈출함
  closures.append(closure)
}

// 클래스 인스턴스 메서드에 사용되는 탈출, 비탈출 클로저
func funcWithNoEscape(closure: VoidVoidClosure) {
  closure()
}

func funcWithEscape(completionHandler: @escaping VoidVoidClosure) -> VoidVoidClosure {
  return completionHandler
}

class Foo {
  var x = 10

  func runNoEscape() {
    // 비탈출 클로저에서 self 키워드 사용은 선택 사항
    funcWithNoEscape { x = 200 }
  }

  func runEscape() -> VoidVoidClosure {
    // 탈출 클로저에서 명시적으로 self 사용할 것
    return funcWithEscape { self.x = 100 }
  }
}

let foo = Foo()
foo.runNoEscape()
print(foo.x) // 200

let returned = foo.runEscape()
returned()
print(foo.x) // 100

// withoutActuallyEscaping 함수 활용
let numbers = [2, 4, 6, 8]

let evenNums = { (number: Int) -> Bool in
  return number % 2 == 0
}

let oddNums = { (number: Int) -> Bool in
  return number % 2 != 0
}

func hasElements(in array: [Int], match predicate: (Int) -> Bool) -> Bool {
  return withoutActuallyEscaping(predicate, do: { escapablePredicate in
    return (array.lazy.filter { escapablePredicate($0) }.isEmpty == false)
  })
}

let hasEvenNum = hasElements(in: numbers, match: evenNums)
let hasOddNum = hasElements(in: numbers, match: oddNums)

print(hasEvenNum, hasOddNum) // true false

// 클로저를 이용한 연산 지연
var queue = [68, 112, 45]
print(queue.count) // 3

// 클로저를 만들어두면 클로저 내부의 코드를 미리 실행(연산)하지 않고 가지고만 있음
let pop: () -> Int = {
  return queue.removeFirst()
}
print(queue.count) // 3

// 실제로 실행
print("Pop front : \(pop())") // Pop front : 68
print(queue.count) // 2

// 함수의 전달인자로 전달하는 클로저
func popFront(_ dequeue: () -> Int) {
  print("Pop front : \(dequeue())")
}

popFront( { queue.removeFirst() }) // Pop front : 112

// 자동 클로저의 사용
func dequeue(_ closure: @autoclosure () -> Int) {
  print("Pop front : \(closure())")
}

dequeue(queue.removeFirst()) // Pop front : 45

// 자동 클로저의 탈출
var customersInLine = ["min", "sp", "inoo"]

func returnProvider(_ customerProvider: @autoclosure @escaping () -> String) -> (() -> String) {
  return customerProvider
}

let customerProvider: () -> String = returnProvider(customersInLine.removeFirst())
print("Now serving \(customerProvider())") // Now serving min

