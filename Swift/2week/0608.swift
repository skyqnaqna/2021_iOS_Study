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
