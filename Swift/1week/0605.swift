/*
 1주차
 21.06.05
 https://github.com/skyqnaqna/2021_iOS_Study
 */

import Foundation

// 구문 이름표
var numbers = [3, 2300, 6, 4300]

numbersLoop: for num in numbers {
  if num > 5 || num < 1 {
    continue numbersLoop
  }

  var count = 0

  printLoop: while true {
    print(num)
    count += 1

    if count == num {
      break printLoop
    }
  }

  removeLoop: while true {
    if numbers.first != num {
      break numbersLoop
    }
    numbers.removeFirst()
  }
}

// Function Argument Labels and Parameter
// 매개변수 이름만 지정
func add(a: Int, b: Int) -> Int {
  return a + b
}

print(add(a: 4, b: 6)) // 10

// 전달인자 레이블 지정
func sub(left a: Int, right b: Int) -> Int {
  return a - b
}

print(sub(left: 8, right: 1)) // 7

// 와일드카드 식별자 사용
func product(_ a: Int, _ b: Int) -> Int {
  return a * b
}

print(product(3, 3)) // 9

// 전달인자 레이블을 변경을 통한 오버로딩
func product(left a: Int, right b: Int) -> Int {
  return a * b
}

print(product(left: 2, right: 2)) // 4

// 매개변수 기본값
func _pow(base: Int, power: Int = 2) -> Int {
  var result = 1
  for _ in 1...power {
    result *= base
  }

  return result
}

print(_pow(base: 5)) // 25

// 가변 매개변수
func sum(x: Int...) -> Int {
  var result = 0

  for num in x {
    result += num
  }

  return result
}

print(sum(x: 1,2,3,4,5)) // 15

// inout 매개변수
var nums = [50, 50]

func nonReference(_ arr: [Int]) {
  var inArr = arr
  inArr[0] = 10
  inArr[1] = 90
}

func reference(_ arr: inout [Int]) {
  arr[0] = 20
  arr[1] = 80
}

nonReference(nums)
print(nums) // [50, 50]

reference(&nums)
print(nums) // [20, 80]

