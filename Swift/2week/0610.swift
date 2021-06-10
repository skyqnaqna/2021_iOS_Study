/*
 2주차
 21.06.10
 https://github.com/skyqnaqna/2021_iOS_Study
 */

// 저장 프로퍼티
struct structPoint {
  var x: Int
  var y: Int
}

class classPoint {
  var x: Int
  var y: Int

  // 프로퍼티 기본값을 지정하지 않으면 이니셜라이저를 정의해야함
  init(x: Int, y: Int) {
    self.x = x
    self.y = y
  }
}

let a = structPoint(x: 4, y: 1)
let b = classPoint(x: 8, y: 0)

// 옵셔널 저장 프로퍼티
class Position {
  var point: structPoint?
  let name: String = "Unknown"
}

let yourPosition = Position() // 옵셔널은 초기값을 넣어주지 않아도 됨

// 지연 저장 프로퍼티
class Position2 {
  lazy var point: structPoint = structPoint(x: 0, y: 0)
  let name: String

  init(name: String) {
    self.name = name
  }
}

let myPosition = Position2(name: "Eee")

// point 프로퍼티로 처음 접근할 때 structPoint가 생성됨
print(myPosition.point) // structPoint(x: 0, y: 0)

// 연산 프로퍼티
struct structPoint2 {
  var x: Int
  var y: Int

  var oppositePoint: structPoint2 {
    get {
      return structPoint2(x: -x, y: -y)
    }

    set(opposite) {
      x = -opposite.x
      y = -opposite.y
    }
  }
}

var tempPosition = structPoint2(x: 11, y: -22)
print(tempPosition) // structPoint2(x: 11, y: -22)
print(tempPosition.oppositePoint) // structPoint2(x: -11, y: 22)

tempPosition.oppositePoint = structPoint2(x:7, y: 21)
print(tempPosition) // structPoint2(x: -7, y: -21)

// 프로퍼티 감시자
class Account {
  var credit: Int = 0 {
    willSet {
      print("잔액이 \(credit)원에서 \(newValue)원으로 변경될 예정")
    }

    didSet {
      print("잔액이 \(oldValue)원에서 \(credit)원으로 변경됨")
    }
  }

  var dollar: Double {
    get {
      return Double(credit) / 1000.0
    }

    set {
      credit = Int(newValue * 1000)
      print("잔액을 \(newValue)달러로 변경 중")
    }
  }
}

var account = Account()

// 잔액이 0원에서 10000원으로 변경될 예정
account.credit = 10000
// 잔액이 0원에서 10000원으로 변경됨

// 상속받은 연산 프로퍼티의 프로퍼티 감시자 구현
class ForeignAccount: Account {
  override var dollar: Double {
    willSet {
      print("잔액이 \(dollar)달러에서 \(newValue)달러로 변경될 예정")
    }

    didSet {
      print("잔액이 \(oldValue)달러에서 \(dollar)달러로 변경됨")
    }
  }
}

account = ForeignAccount()

// 잔액이 0원에서 22000원으로 변경될 예정
account.credit = 22000
// 잔액이 0원에서 22000원으로 변경됨

// 잔액이 22.0달러에서 4.0달러로 변경될 예정
// 잔액이 22000원에서 4000원으로 변경될 예정
// 잔액이 22000원에서 4000원으로 변경됨
account.dollar = 4 // 잔액을 4.0달러로 변경 중
// 잔액이 22.0달러에서 4.0달러로 변경됨

// 전역변수 감시자와 연산 프로퍼티
var name: String = "Unknown" {
  willSet {
    print("Will change : \(name) -> \(newValue)")
  }

  didSet {
    print("Changed : \(oldValue) -> \(name)")
  }
}

var upperName: String {
  get {
    return name.uppercased()
  }

  set {
    name = newValue.uppercased()
    print("Changing to \(newValue)")
  }
}
// Will change : Unknown -> MAC
// Changed : Unknown -> MAC
upperName = "mac" // Changing to mac
print(upperName) // MAC

// Will change : MAC -> windows
// Changed : MAC -> windows
name = "windows"
print(name) //windows

























