/*
 4주차
 21.06.21
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



















