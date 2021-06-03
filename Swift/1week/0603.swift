/*
 1주차
 21.06.03
 https://github.com/skyqnaqna/2021_iOS_Study
 */

import Foundation

// Constants and Variables
var country: String = "Korea"
let age: Int = 10

var x = 1, y = 2, z = 3

var a, b, c: Int
a = 0
b = 1
c = 2

// Type
print(Int.max, Int.min) // 9223372036854775807 -9223372036854775808

var isTrue = true
isTrue.toggle()
print(isTrue) // false

var char: Character = "C"

var str: String = "ABC"

// 여러 줄 문자열
var grid = """
           A B C
           D E F
           G H I
           """

// Type aliases
typealias int = Int
var num: int = 16

// Tuple
let info: (String, Int, Double) = ("Coke", 500, 1.99)
// let info = ("Coke", 500, 1.99)
print(info.0) // Coke

let info2: (name: String, ml: Int, price: Double) = ("Coke", 1000, 2.50)
print(info2.price) // 2.5

var (name, ml, price) = info
print(name, ml, price) // Coke 500 1.9

// 튜플 별칭 지정
typealias Edge = (from: Int, to: Int, weight: Int)

let edge1 = Edge(1, 2, 10)
let edge2: Edge = (2, 3, 8)
print(edge1) // (from: 1, to: 2, weight: 10)
print(edge2) // (from: 2, to: 3, weight: 8)
