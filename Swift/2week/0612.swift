/*
 2주차
 21.06.12
 https://github.com/skyqnaqna/2021_iOS_Study
 */

//===옵셔널 체이닝===//
class Room {
  var number: Int

  init(num: Int) {
    self.number = num
  }
}

class Building {
  var name: String
  var room: Room?

  init(name: String) {
    self.name = name
  }
}

struct Address {
  var province: String
  var city: String
  var street: String
  var building: Building?
  var detailAddress: String?

  func fullAddress() -> String? {
    var restAddress: String? = nil

    if let buildingInfo = self.building {
      restAddress = buildingInfo.name
    } else if let detail = self.detailAddress {
      restAddress = detail
    }

    if let rest = restAddress {
      var fullAddress = self.province

      fullAddress += " " + self.city
      fullAddress += " " + self.street
      fullAddress += " " + rest

      return fullAddress
    } else {
      return nil
    }
  }

  func printAddress() {
    if let address = self.fullAddress() {
      print(address)
    }
  }
}

class Person {
  var name: String
  var address: Address?

  init(name: String) {
    self.name = name
  }
}

let minsu = Person(name: "Minsu")
let minsuRoomNum: Int? = minsu.address?.building?.room?.number
print(minsuRoomNum) // nil

//let minsuRommNumOptionalUnwraping: Int = minsu.address!.building!.room!.number // Error


//===옵셔널 바인딩===//
let bob = Person(name: "Bob")

var roomNum: Int? = nil

if let bobAddress = bob.address {
  if let bobBuilding = bobAddress.building {
    if let bobRoom = bobBuilding.room {
      roomNum = bobRoom.number
    }
  }
}

if let number = roomNum {
  print(number)
} else {
  print("Can not find room number")
}
// Can not find room number


//===옵셔널 체이닝과 바인딩 결합===//
let mike = Person(name: "Mike")

if let roomNumber = mike.address?.building?.room?.number {
  print(roomNumber)
} else {
  print("Can not find room number")
}
// Can not find room number


//===옵셔널 체이닝을 통한 값 할당===//
mike.address = Address(province: "Seoul", city: "Nowon", street: "Gongneung", building: nil, detailAddress: nil)
mike.address?.building = Building(name: "AAA")
mike.address?.building?.room = Room(num: 0)
mike.address?.building?.room?.number = 301

print(mike.address?.building?.room?.number) // Optional(301)


//===옵셔널 체이닝을 통한 메서드 호출===//
print(mike.address?.fullAddress()?.isEmpty) // Optional(false)
mike.address?.printAddress() // Seoul Nowon Gongneung AAA


//===옵셔널 체이닝을 통한 서브스크립트 호출===//
let optArray: [Int]? = [1, 2, 3]
print(optArray?[1]) // Optional(2)

var optDic: [String: [Int]]? = [String: [Int]]()
optDic?["numArray"] = optArray
print(optDic?["numArray"]?[2]) // Optional(3)


//===guard 구문의 옵셔널 바인딩 활용===//
func greet(_ person: [String: String]) {
  guard let name = person["name"] else {
    return
  }
  
  print("Hello \(name)")
  
  guard let location = person["location"] else {
    print("I hope the weather is nice near you")
    return
  }
  
  print("I hope the weather is nice in \(location)")
}

var personInfo = [String: String]()
personInfo["name"] = "Jenny"

greet(personInfo)
// Hello Jenny
// I hope the weather is nice near you

personInfo["location"] = "Korea"

greet(personInfo)
// Hello Jenny
// I hope the weather is nice in Korea


//===guard 구문에 구체적인 조건 추가===//
func enterClub(name: String?, age: Int?) {
  guard let name: String = name, let age: Int = age, age > 19, name.isEmpty == false else {
    print("You are too young to enter the club")
    return
  }

  print("Welcome \(name)")
}


//===for-in 구문과 맵 메서드 비교===//
let arr = [0, 1, 2, 3, 4]

var doubleArr = [Int]()
var strings = [String]()

// for 구문
for i in arr {
  doubleArr.append(i * 2)
  strings.append("\(i)")
}

print(doubleArr) // [0, 2, 4, 6, 8]
print(strings) // ["0", "1", "2", "3", "4"]

// map 메서드
doubleArr = arr.map ({ (i: Int) -> Int in
  return i * 2
})
strings = arr.map ({ (i: Int) -> String in
  return "\(i)"
})

print(doubleArr) // [0, 2, 4, 6, 8]
print(strings) // ["0", "1", "2", "3", "4"]


//===클로저 표현의 간략화===//

// 매개변수 및 반환 타입 생략
doubleArr = arr.map({ return $0 * 2 })
print(doubleArr) // [0, 2, 4, 6, 8]

// 반환 키워드 생략
doubleArr = arr.map({ $0 * 2 })
print(doubleArr) // [0, 2, 4, 6, 8]

// 후행 클로저 사용
doubleArr = arr.map { $0 * 2 }
print(doubleArr) // [0, 2, 4, 6, 8]


//===클로저의 반복 사용===//
let evenNums = [0, 2, 4, 6, 8]
let oddNums = [1, 3, 5, 7, 9]
let multiplyTwo: (Int) -> Int = { $0 * 2 }

let doubleEvenNums = evenNums.map(multiplyTwo)
let doubleOddNums = oddNums.map(multiplyTwo)

print(doubleEvenNums) // [0, 4, 8, 12, 16]
print(doubleOddNums) // [2, 6, 10, 14, 18]


//===다양한 컨테이너 타입에서의 맵===//
let alphabet = ["a": "A", "b": "B"]

var keys = alphabet.map { (tuple: (String, String)) -> String in
  return tuple.0
}

keys = alphabet.map{ $0.0 }

let values = alphabet.map { $0.1 }

print(keys) // ["b", "a"]
print(values) // ["B", "A"]

var numSet: Set<Int> = [1,2,3,4,5]
let resultSet = numSet.map{ $0 * 2 }

print(resultSet) // [10, 8, 6, 4, 2]

let optionalInt: Int? = 3
let resultInt: Int? = optionalInt.map{ $0 * 2 }

print(resultInt) // Optional(6)

let range: CountableClosedRange = (0...3)
let resultRange: [Int] = range.map{ $0 * 2 }

print(resultRange) // [0, 2, 4, 6]











