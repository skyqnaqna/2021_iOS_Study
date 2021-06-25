/*
 4주차
 21.06.25
 https://github.com/skyqnaqna/2021_iOS_Study
 */

//===타입 캐스팅===//
class Coffee {
  let name: String
  let shot: Int

  var description: String {
    return "\(shot) shot(s) \(name)"
  }

  init(shot: Int) {
    self.shot = shot
    self.name = "coffee"
  }
}

class Latte: Coffee {
  var flavor: String
  override var description: String {
    return "\(shot) shot(s) \(flavor) latte"
  }

  init(flavor: String, shot: Int) {
    self.flavor = flavor
    super.init(shot: shot)
  }
}

class Americano: Coffee {
  let iced: Bool
  override var description: String {
    return "\(shot) shot(s) \(iced ? "iced" : "hot") americano"
  }

  init(shot: Int, iced: Bool) {
    self.iced = iced
    super.init(shot: shot)
  }
}


//===데이터 타입 확인===//
let coffee = Coffee(shot: 1)
print(coffee.description) // 1 shot(s) coffee

let myCoffee = Americano(shot: 3, iced: true)
print(myCoffee.description) // 3 shot(s) iced americano

let yourCoffee = Latte(flavor: "Vanila", shot: 2)
print(yourCoffee.description) // 2 shot(s) Vanila latte

print(coffee is Coffee) // true
print(coffee is Americano) // false
print(coffee is Latte) // false

print(myCoffee is Coffee) // true
print(myCoffee is Americano) // true
print(myCoffee is Latte) // false


//===메타 타입===//
protocol SomeProtocol { }
class SomeClass: SomeProtocol { }

let int: Int.Type = Int.self
let string: String.Type = String.self
let classType: SomeClass.Type = SomeClass.self
let protocolType: SomeProtocol.Protocol = SomeProtocol.self

var someType: Any.Type

someType = int
print(someType) // Int

someType = string
print(someType) // String

someType = classType
print(someType) // SomeClass

someType = protocolType
print(someType) // SomeProtocol


//===다운캐스팅===//
if let foo: Americano = coffee as? Americano {
  print("This is Americano")
} else {
  print(coffee.description)
} // 1 shot(s) coffee


if let foo: Latte = coffee as? Latte {
  print("This is Latte")
} else {
  print(coffee.description)
} // 1 shot(s) coffee


if let foo: Coffee = coffee as? Coffee {
  print("This is Just Coffee")
} else {
  print(coffee.description)
} // This is Just Coffee


if let foo: Americano = myCoffee as? Americano {
  print("This is Americano")
} else {
  print(coffee.description)
} // This is Americano


if let foo: Latte = myCoffee as? Latte {
  print("This is Latte")
} else {
  print(coffee.description)
} // 1 shot(s) coffee


if let foo: Coffee = myCoffee as? Coffee {
  print("This is Just Coffee")
} else {
  print(coffee.description)
} // This is Just Coffee


let castedCoffee: Coffee = yourCoffee as! Coffee // Success

//let castedAmericano: Americano = coffee as! Americano // Runtime Error
// Could not cast value of type 'swiftTest.Coffee' (0x1007d43f0) to 'swiftTest.Americano' (0x1007d4568).


//===AnyObject의 타입 확인===//
func checkType(of item: AnyObject) {
  if item is Latte {
    print("item is latte")
  } else if item is Americano {
    print("item is americano")
  } else if item is Coffee {
    print("item is Coffee")
  } else {
    print("Unknown type")
  }
}

checkType(of: coffee) // item is Coffee
checkType(of: myCoffee) // item is americano
checkType(of: yourCoffee) // item is latte


//===AnyObject의 타입캐스팅===//
func castTypeToAppropriate(item: AnyObject) {
  if let castedItem: Latte = item as? Latte {
    print(castedItem.description)
  } else if let castedItem: Americano = item as? Americano {
    print(castedItem.description)
  } else if let castedItem: Coffee = item as? Coffee {
    print(castedItem.description)
  } else {
    print("Unknown type")
  }
}

castTypeToAppropriate(item: coffee) // 1 shot(s) coffee
castTypeToAppropriate(item: myCoffee) // 3 shot(s) iced americano
castTypeToAppropriate(item: yourCoffee) // 2 shot(s) Vanila latte


//===Any의 타입캐스팅===//
func checkAnyType(of item: Any) {
  switch item {
  case 0 as Int:
    print("zero as an Int")
  case 0 as Double:
    print("zero as a Double")
  case let someInt as Int:
    print("an integer value of \(someInt)")
  case let someDouble as Double where someDouble > 0:
    print("a positive double value of \(someDouble)")
  case is Double:
    print("some other double value that I don't want to print")
  case let someString as String:
    print("a string value of \"\(someString)\"")
  case let (x, y) as (Double, Double):
    print("an (x, y) point at \(x), \(y)")
  case let latte as Latte:
    print(latte.description)
  case let stringConverter as (String) -> String:
    print(stringConverter("susu"))
  default:
    print("something else : \(type(of: item))")
  }
}

let arr: [Any] = [0, 0.0, 52, 3.141592, -0.15, "bye", (3.0, 5.1), yourCoffee, coffee, {(name: String) -> String in "Hello, \(name)"}]

for i in 0 ..< arr.count {
  print("\(i) :", terminator: " ")
  checkAnyType(of: arr[i])
}

/*
0 : zero as an Int
1 : zero as a Double
2 : an integer value of 52
3 : a positive double value of 3.141592
4 : some other double value that I don't want to print
5 : a string value of "bye"
6 : an (x, y) point at 3.0, 5.1
7 : 2 shot(s) Vanila latte
8 : something else : Coffee
9 : Hello, susu
 */


//===옵셔널과 Any===//
let optionalValue: Int? = 100
print(optionalValue) // 컴파일러 경고 발생 : Expression implicitly coerced from 'Int?' to 'Any'
print(optionalValue as Any) // 경고 없음
// Optional(100)

