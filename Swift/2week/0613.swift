/*
 2주차
 21.06.13
 https://github.com/skyqnaqna/2021_iOS_Study
 */

//===필터 메서드 사용====//
let numbers = [0, 1, 2, 3, 4, 5]

let evenNums = numbers.filter { (number: Int) -> Bool in
  return number % 2 == 0
}

print(evenNums) // [0, 2, 4]


//===맵과 필터 메서드 연계===//
let oddNums = numbers.map { $0 + 3 }.filter { $0 % 2 != 0 }

print(oddNums) // [3, 5, 7]


//===리듀스 메서드의 사용===//

// #1. 첫 번째 형태인 reduce(_:_:) 메서드 사용
// 초깃값은 0, 정수 배열의 모든 값 더하기
var sum = numbers.reduce(0, { (result: Int, next: Int) -> Int in
  print("\(result) + \(next)")
  return result + next
})
/*
0 + 0
0 + 1
1 + 2
3 + 3
6 + 4
10 + 5
 */

print(sum) // 15

// 문자열 배열을 reduce(_:_:) 메서드를 이용해 연결
let names = ["Kim", "Lee", "Park"]

let reduceName = names.reduce("Name is " ) {
  return $0 + $1
}

print(reduceName) // Name is KimLeePark


// #2. 두 번재 형태인 reducd(into:_:) 메서드 사용
// 초깃값은 5, 정수 배열의 모든 값 더하기
// 첫 번째 리듀스 형태와 달리 클로저의 값을 반환하지 않고 내부에서 직접
// 이전 값을 변경한다는 점이 다름
sum = numbers.reduce(into: 5, {
  print("\($0) + \($1)")
  $0 += $1
})
/*
5 + 0
5 + 1
6 + 2
8 + 3
11 + 4
15 + 5
 */

print(sum) // 20


// 첫 번째 리듀스 형태와 다르기 때문에 다른 컨테이너에 값을 변경하여 넣어줄 수 있음
// 맵이나 필터와 유사한 형태로 사용 가능

// 홀수는 걸러내고 짝수만 두 배로 변경
var doubledNums = numbers.reduce(into: []) { (result: inout [Int], next: Int) in
  print("result: \(result) next: \(next)")

  guard next.isMultiple(of: 2) else {
    return
  }

  print("\(result) append \(next)")

  result.append(next * 2)
}
/*
result: [] next: 0
[] append 0
result: [0] next: 1
result: [0] next: 2
[0] append 2
result: [0, 4] next: 3
result: [0, 4] next: 4
[0, 4] append 4
result: [0, 4, 8] next: 5
 */

print(doubledNums) // [0, 4, 8]


// 필터와 맵을 사용한 모습
doubledNums = [] + numbers.filter { $0.isMultiple(of: 2) }.map { $0 * 2 }

print(doubledNums) // [0, 4, 8]


// 이름을 모두 대문자로 변환하여 초깃값인 빈 배열에 직접 연산
var upperNames = names.reduce(into: [], {
  $0.append($1.uppercased())
})

print(upperNames) // ["KIM", "LEE", "PARK"]


// 맵을 사용한 모습
upperNames = names.map { $0.uppercased() }

print(upperNames) // ["KIM", "LEE", "PARK"]


//===맵, 필터, 리듀스 메서드의 연계 사용===//

// 짝수에 3을 곱해준 후 모든 값 더하기
var result = numbers.filter { $0.isMultiple(of: 2) }.map { $0 * 3 }.reduce(0) {
  $0 + $1
}

print(result) // 18


// for-in 구문 사용
result = 0

for num in numbers {
  guard num.isMultiple(of: 2) else {
    continue
  }

  result += num * 3
}

print(result) // 18

