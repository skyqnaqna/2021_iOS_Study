/*
 4주차
 21.06.21 ~ 22
 https://github.com/skyqnaqna/2021_iOS_Study
 */

//===메서드 재정의===//
class Person {
  var name: String = ""
  var age: Int = 0

  var intro: String {
    return "name : \(name), age : \(age)"
  }

  func speak() {
    print("abcdefg")
  }

  class func introClass() -> String {
    return "Hello!"
  }
}

class Student: Person {
  var grade: String = "F"

  func study() {
    print("Study now...")
  }

  override func speak() {
    print("I'm student")
  }
}

class UniversityStudent: Student {
  var major: String = ""

  class func introClass() {
    print(super.introClass())
  }

  override class func introClass() -> String {
    return "Please A+!"
  }

  override func speak() {
    super.speak()
    print("University Student")
  }
}

let hong = Person()
hong.speak() // abcdefg

let pong = Student()
pong.speak() // I'm student

let jong = UniversityStudent()
jong.speak()
// I'm student
// University Student

print(Person.introClass()) // Hello!
print(Student.introClass()) // Hello!
print(UniversityStudent.introClass() as String) // Please A+!
UniversityStudent.introClass() as Void // Hello!


//===프로퍼티 재정의===//
class Person2 {
  var name: String = ""
  var age: Int = 0
  var koreanAge: Int {
    return self.age + 1
  }

  var intro: String {
    return "name : \(name), age : \(age)"
  }
}

class Student2: Person2 {
  var grade: String = "F"

  override var intro: String {
    return super.intro + " " + "grade : \(self.grade)"
  }
  override var koreanAge: Int {
    get {
      return super.koreanAge
    }

    set {
      self.age = newValue - 1
    }
  }
}

let song = Person2()
song.name = "song"
song.age = 55
//song.koreanAge = 54 // Error
print(song.intro) // name : song, age : 55
print(song.koreanAge) // 56

let lim = Student2()
lim.name = "lim"
lim.age = 25
lim.koreanAge = 24
print(lim.intro) // name : lim, age : 23 grade : F
print(lim.koreanAge) // 24


//===프로퍼티 감시자 재정의===//
class Person3 {
  var name: String = ""
  var age: Int = 0 {
    didSet {
      print("Person age : \(self.age)")
    }
  }
  var koreanAge: Int {
    return self.age + 1
  }

  var fullName: String {
    get {
      return self.name
    }

    set {
      self.name = newValue
    }
  }
}

class Student3: Person3 {
  var grade: String = "F"

  override var age: Int {
    didSet {
      print("Student age : \(self.age)")
    }
  }

  override var koreanAge: Int {
    get {
      return super.koreanAge
    }

    set {
      self.age = newValue - 1
    }

//    didSet { } // Error
  }

  override var fullName: String {
    didSet {
      print("Full name : \(self.fullName)")
    }
  }
}

let won = Person3()
won.name = "won"
won.age = 44 // Person age : 44
won.fullName = "Jo won"
print(won.koreanAge) // 45

let tang = Student3()
tang.name = "tang"
tang.age = 22
// Person age : 22
// Student age : 22
tang.koreanAge = 23 // Student age : 22
tang.fullName = "Han tang" // Full name : Han tang
print(tang.koreanAge) // 23


//===서브스크립트 재정의===//
class School {
  var students = [Student]()

  subscript(number: Int) -> Student {
    print("Scool subscript")
    return students[number]
  }
}

class MiddleSchool: School {
  var middleStudents = [Student]()

  override subscript(index: Int) -> Student {
    print("MiddleSchool subscript")
    return middleStudents[index]
  }
}

let university = School()
university.students.append(Student())
university[0] //Scool subscript

let middle = MiddleSchool()
middle.middleStudents.append(Student())
middle[0] // MiddleSchool subscript


//===지정 이니셜라이저와 편의 이니셜라이저===//
class Person4 {
  var name: String
  var age: Int

  init(name: String, age: Int) {
    self.name = name
    self.age = age
  }
}

class Student4: Person4 {
  var major: String

  init(name: String, age: Int, major: String) {
    self.major = "Swift"
    super.init(name: name, age: age)
  }

  convenience init(name: String) {
    self.init(name: name, age: 9, major: "")
  }
}


//===클래스 이니셜라이저의 재정의===//
class Person5 {
  var name: String
  var age: Int

  init(name: String, age: Int) {
    self.name = name
    self.age = age
  }

  convenience init(name: String) {
    self.init(name: name, age: 0)
  }
}

class Student5: Person5 {
  var major: String

  override init(name: String, age: Int) {
    self.major = "Swfit"
    super.init(name: name, age: age)
  }

  convenience init(name: String) {
    self.init(name: name, age: 7)
  }
}


//===실패 가능한 이니셜라이저의 재정의===//
class Person6 {
  var name: String
  var age: Int

  init() {
    self.name = "Unkown"
    self.age = 0
  }

  init?(name: String, age: Int) {
    if name.isEmpty {
      return nil
    }
    self.name = name
    self.age = age
  }

  init?(age: Int) {
    if age < 0 {
      return nil
    }
    self.name = "Unknown"
    self.age = age
  }
}

class Student6: Person6 {
  var major: String

  override init?(name: String, age: Int) {
    self.major = "Swift"
    super.init(name: name, age: age)
  }

  override init(age: Int) {
    self.major = "Swift"
    super.init()
  }
}


//===편의 이니셜라이저 자동 상속===//
class Person7 {
  var name: String

  init(name: String) {
    self.name = name
  }

  convenience init() {
    self.init(name: "Unknown")
  }
}

class Student7: Person7 {
  var major: String

  convenience init(major: String) {
    self.init()
    self.major = major
  }

  override convenience init(name: String) {
    self.init(name: name, major: "Unknown")
  }

  init(name: String, major: String) {
    self.major = major
    super.init(name: name)
  }
}

class UniversityStudent7: Student7 {
  var grade: String = "F"
  var description: String {
    return "\(self.name) \(self.major) \(self.grade)"
  }

  convenience init(name: String, major: String, grade: String) {
    self.init(name: name, major: major)
    self.grade = grade
  }
}

let aaa = Person7()
let bbb = Student7(major: "Swift")
print(aaa.name, bbb.name, bbb.major) // Unknown Unknown Swift

let ccc = UniversityStudent7()
let ddd = UniversityStudent7(name: "yon")
let eee = UniversityStudent7(name: "ker", major: "Python")
let fff = UniversityStudent7(name: "tim", major: "C++", grade: "A+")

print(ccc.description) // Unknown Unknown F
print(ddd.description) // yon Unknown F
print(eee.description) // ker Python F
print(fff.description) // tim C++ A+


//===요구 이니셜라이저 정의===//
class Person8 {
  var name: String

  required init() {
    self.name = "Unknown"
  }
}

class Student8: Person8 {
  var major: String = "Unknown"
}


//===요구 이니셜라이저 재구현===//
class Student9: Person8 {
  var major: String = "Unknown"

  // 자신의 지정 이니셜라이저 구현
  init(major: String) {
    self.major = major
    super.init()
  }

  required init() {
    self.major = "Unknown"
    super.init()
  }
}

class UniversityStudent9: Student9 {
  var grade: String

  // 자신의 지정 이니셜라이저 구현
  init(grade: String) {
    self.grade = grade
    super.init()
  }

  required init() {
    self.grade = "F"
    super.init()
  }
}

let jisu = Student9()
let aman = Student9(major: "Swift")
let ran = UniversityStudent9(grade: "A")

print(jisu.major) // Unknown
print(aman.major) // Swift
print(ran.grade) // A


//===일반 이니셜라이저의 요구 이니셜라이저 변경===//
class Person10 {
  var name: String

  init() {
    self.name = "Unknown"
  }
}

class Student10: Person10 {
  var major: String = "Unknown"

  init(major: String) {
    self.major = major
    super.init()
  }

  // 부모클래스의 이니셜라이저를 재정의함과 동시에 요구 이니셜라이저로 변경
  required override init() {
    self.major = "Unknown"
    super.init()
  }

  // 이 요구 이니셜라이저는 앞으로 계속 요구함
  required convenience init(name: String) {
    self.init()
    self.name = name
  }
}

class UniversityStudent10: Student10 {
  var grade: String

  init(grade: String) {
    self.grade = grade
    super.init()
  }

  // Student 클래스에서 요구한 것 구현
  required init() {
    self.grade = "F"
    super.init()
  }

  // Student 클래스에서 요구한 것 구현
  required convenience init(name: String) {
    self.init()
    self.name = name
  }
}

let gugu = UniversityStudent10()
let dal = UniversityStudent10(name: "dal")

print(gugu.grade) // F
print(dal.name) // dal

