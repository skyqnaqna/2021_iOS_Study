/*
 2주차
 21.06.11
 https://github.com/skyqnaqna/2021_iOS_Study
 */

// 이니셜라이저
enum SomeEnum {
  case someCase

  init() {
    // 열거형은 초기화할 때 반드시 case중 하나가 되어야 함
    self = .someCase
  }
}

// 멤버와이즈 이니셜라이저
struct Point {
  var x: Int = 0
  var y: Int
}

let point = Point(x: 5, y: 9)
let point2 = Point(y: 10)

// 초기화 위임
enum Student {
  case elementary, middle, high
  case none
  init() {
    self = .none
  }

  init(koreanAge: Int) {
    switch koreanAge {
    case 8...13:
      self = .elementary
    case 14...16:
      self = .middle
    case 17...19:
      self = .high
    default:
      self = .none
    }
  }

  init(bornAt: Int, currentYear: Int) {
    self.init(koreanAge: currentYear - bornAt + 1) // 첫 번째 이니셜라이저에 초기화 위임
  }
}

var younger = Student(koreanAge: 14)
print(younger) // middle

younger = Student(bornAt: 1998, currentYear: 2014)
print(younger) // high

// 실패 가능한 이니셜라이저
class PositiveNumber {
  var number: Int?

  init?(_ n: Int) {
    if n <= 0 {
      return nil
    }
    self.number = n
  }
}

let one = PositiveNumber(-1)
print(one) // nil

// 열거형의 실패 가능한 이니셜라이저
enum Student2: String {
  case elementary = "초딩", middle = "중딩", high = "고딩"

  init?(koreanAge: Int) {
    switch koreanAge {
    case 8...13:
      self = .elementary
    case 14...16:
      self = .middle
    case 17...19:
      self = .high
    default:
      return nil
    }
  }

  init?(bornAt: Int, currentYear: Int) {
    self.init(koreanAge: currentYear - bornAt + 1)
  }
}

var someone = Student2(koreanAge: 20)
print(someone) // nil

someone = Student2(rawValue: "대학생")
print(someone) // nil

// 클로저를 통한 프로퍼티 기본값 설정
struct Candidate {
  var candidates: [Int] = {
    var arr = [Int]()

    for num in 1...10 {
      arr.append(num)
    }
    return arr
  }()
}

let candidates = Candidate()
print(candidates.candidates.count) // 10

// 디이셜라이저
class Foo {
  deinit {
    print("Instance will be deallocated immediately")
  }
}

var foo: Foo? = Foo()
foo = nil // Instance will be deallocated immediately

// 설정자의 접근수준 지정
public struct SomeType {
  private var count = 0

  public var publicStoredProperty = 0

  public private(set) var publicGetOnlyStoredProperty = 0

  internal var internalComputedProperty: Int {
    get {
      return count
    }

    set {
      count += 1
    }
  }

  internal private(set) var internalGetOnlyComputedProperty: Int {
    get {
      return count
    }

    set {
      count += 1
    }
  }

  public subscript() -> Int {
    get {
      return count
    }

    set {
      count += 1
    }
  }

  public internal(set) subscript(_ a: Int) -> Int {
    get {
      return count
    }

    set {
      count += 1
    }
  }
}

var some = SomeType()

print(some.publicStoredProperty) // 0
some.publicStoredProperty = 100

print(some.publicGetOnlyStoredProperty) // 0
//some.publicGetOnlyStoredProperty = 100 // 오류

print(some.internalComputedProperty) // 0
some.internalComputedProperty = 100

print(some.internalGetOnlyComputedProperty) // 1
//some.internalGetOnlyComputedProperty = 100 // 오류

print(some[]) // 1
some[] = 100

print(some[0]) // 2
some[0] = 100
