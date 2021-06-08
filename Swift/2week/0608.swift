/*
 2주차
 21.06.08
 https://github.com/skyqnaqna/2021_iOS_Study
 */

// 클래스의 인스턴스 생성 및 소멸
class Person {
  var height = 0.0
  var weight = 0.0

  // 소괄호도 적지 않는다
  deinit {
    print("Person 클래스의 인스턴스가 소멸됩니다.")
  }
}

var person1: Person? = Person()
person1 = nil // Person 클래스의 인스턴스가 소멸됩니다.

// 값 타입과 참조 타입의 차이
struct BasicInfo {
  let name: String
  var age: Int
}

// 값 복사 할당
var aaInfo = BasicInfo(name: "aa", age: 38)
var bbInfo = aaInfo
bbInfo.age = 20

print(aaInfo.age, bbInfo.age) // 38 20

// 참조 할당
var aaPerson = Person()
var bbPerson = aaPerson

bbPerson.height = 170.7

print(aaPerson.height, bbPerson.height) // 170.7 170.7

// 식별 연산자 (Identity Operations)
print(aaPerson === bbPerson) // true
