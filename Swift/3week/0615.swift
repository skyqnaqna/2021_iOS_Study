/*
 3주차
 21.06.15
 https://github.com/skyqnaqna/2021_iOS_Study
 */

//===서브스크립트 구현===//
struct Student {
  var name: String
  var number: Int
}

class School {
  var number: Int = 0
  var students: [Student] = [Student]()

  func addStudent(name: String) {
    let student = Student(name: name, number: self.number)
    self.students.append(student)
    self.number += 1
  }

  func addStudents(names: String...) {
    for name in names {
      self.addStudent(name: name)
    }
  }

  subscript(index: Int) -> Student? {
    if index < self.number {
      return self.students[index]
    }
    return nil
  }
}

let highSchool = School()
highSchool.addStudents(names: "Mi", "Su", "Ho")

let aStudent: Student? = highSchool[1]
print("\(aStudent?.number) \(aStudent?.name)") // Optional(1) Optional("Su")


//===복수 서브스크립트===//
class School2 {
  var number: Int = 0
  var students: [Student] = [Student]()

  func addStudent(name: String) {
    let student = Student(name: name, number: self.number)
    self.students.append(student)
    self.number += 1
  }

  func addStudents(names: String...) {
    for name in names {
      self.addStudent(name: name)
    }
  }

  subscript(index: Int) -> Student? {
    get {
      if index < self.number {
        return self.students[index]
      }
      return nil
    }

    set {
      guard var newStudnet: Student = newValue else {
        return
      }

      var number = index

      if index > self.number {
        number = self.number
        self.number += 1
      }

      newStudnet.number = number
      self.students[number] = newStudnet
    }
  }

  subscript(name: String) -> Int? {
    get {
      return self.students.filter{ $0.name == name }.first?.number
    }

    set {
      guard var number: Int = newValue else {
        return
      }

      if number > self.number {
        number = self.number
        self.number += 1
      }

      let newStudent: Student = Student(name: name, number: number)
      self.students[number] = newStudent
    }
  }

  subscript(name: String, number: Int) -> Student? {
    return self.students.filter{ $0.name == name && $0.number == number }.first
  }
}

let middleSchool: School2 = School2()
middleSchool.addStudents(names: "Pio", "Mark", "Gon", "Li")

let bStudent: Student? = middleSchool[1]
print("\(bStudent?.number) \(bStudent?.name)") // Optional(1) Optional("Mark")

print(middleSchool["Pio"], middleSchool["Jin"]) // Optional(0) nil

middleSchool[0] = Student(name: "Bob", number: 0)
middleSchool["Ken"] = 1

print(middleSchool["Juho"]) // nil
print(middleSchool["Ken"]) // Optional(1)
print(middleSchool["Gon", 2]) // Optional(swiftTest.Student(name: "Gon", number: 2))
print(middleSchool["Hee", 3]) // nil


//===타입 서브스크립트===//
enum School3: Int {
  case elementary = 1, middle, high, university

  static subscript(level: Int) -> School3? {
    return Self(rawValue: level)
    //= return School3(rawValue: level)
  }
}

let schooool: School3? = School3[2]
print(schooool) // Optional(swiftTest.School3.middle)

