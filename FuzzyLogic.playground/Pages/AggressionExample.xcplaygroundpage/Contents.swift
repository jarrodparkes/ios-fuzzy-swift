// ourHealth
let nearDeath = FuzzySet(name: "nearDeath", points: Point(x: 0, y: 0)!, Point(x: 0, y: 1)!, Point(x: 50, y: 0)!)
let good = FuzzySet(name: "good", points: Point(x: 14, y: 0)!, Point(x: 50, y: 1)!, Point(x: 83, y: 0)!)
let excellent = FuzzySet(name: "excellent", points: Point(x: 50, y: 0)!, Point(x: 100, y: 1)!, Point(x: 100, y: 0)!)
var ourHealth = FuzzyVariable(name: "ourHealth", fuzzySets: nearDeath, good, excellent)

// enemyHealth
let enemyNearDeath = FuzzySet(name: "enemyNearDeath", points: Point(x: 0, y: 0)!,  Point(x: 0, y: 1)!, Point(x: 50, y: 0)!)
let enemyGood = FuzzySet(name: "enemyGood", points: Point(x: 14, y: 0)!, Point(x: 50, y: 1)!, Point(x: 83, y: 0)!)
let enemyExcellent = FuzzySet(name: "enemyExcellent", points: Point(x: 50, y: 0)!, Point(x: 100, y: 1)!, Point(x: 100, y: 0)!)
var enemyHealth = FuzzyVariable(name: "enemyHealth", fuzzySets: enemyNearDeath, enemyGood, enemyExcellent)

// distance
let close = FuzzySet(name: "close", points: Point(x: 0, y: 0)!, Point(x: 0, y: 1)!, Point(x: 50, y: 0)!)
let medium = FuzzySet(name: "medium", points: Point(x: 14, y: 0)!, Point(x: 50, y: 1)!, Point(x: 83, y: 0)!)
let far = FuzzySet(name: "far", points: Point(x: 50, y: 0)!, Point(x: 100, y: 1)!, Point(x: 100, y: 0)!)
var distance = FuzzyVariable(name: "distance", fuzzySets: close, medium, far)

ourHealth.updateDegreesOfMembership(76.88)
print("")
enemyHealth.updateDegreesOfMembership(20.1)
print("")
distance.updateDegreesOfMembership(8.54)

//: [Next](@next)
