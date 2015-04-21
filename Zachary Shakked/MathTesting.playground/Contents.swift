//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let numberOfBalls = 5
var frameDivision : CGFloat = CGFloat(500 / numberOfBalls)
var paintBallCentersX : [CGFloat] = []
for index in 0...(numberOfBalls - 1){
    println(index)
    let unadjustedCenter = CGFloat(index) * frameDivision
    let adjustedCenter = unadjustedCenter + frameDivision / 2
    paintBallCentersX.append(adjustedCenter)
}
println(paintBallCentersX)