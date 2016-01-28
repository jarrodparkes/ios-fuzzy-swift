// ourHealth
let nearDeath = MembershipPolygon(name: "nearDeath", points: Point(x: 0, y: 0)!, Point(x: 0, y: 1)!, Point(x: 50, y: 0)!)
let good = MembershipPolygon(name: "good", points: Point(x: 14, y: 0)!, Point(x: 50, y: 1)!, Point(x: 83, y: 0)!)
let excellent = MembershipPolygon(name: "excellent", points: Point(x: 50, y: 0)!, Point(x: 100, y: 1)!, Point(x: 100, y: 0)!)
let ourHealth = FuzzyVariable(name: "ourHealth", fuzzySets: nearDeath, good, excellent)

// enemyHealth
let enemyNearDeath = MembershipPolygon(name: "enemyNearDeath", points: Point(x: 0, y: 0)!,  Point(x: 0, y: 1)!, Point(x: 50, y: 0)!)
let enemyGood = MembershipPolygon(name: "enemyGood", points: Point(x: 14, y: 0)!, Point(x: 50, y: 1)!, Point(x: 83, y: 0)!)
let enemyExcellent = MembershipPolygon(name: "enemyExcellent", points: Point(x: 50, y: 0)!, Point(x: 100, y: 1)!, Point(x: 100, y: 0)!)
let enemyHealth = FuzzyVariable(name: "enemyHealth", fuzzySets: enemyNearDeath, enemyGood, enemyExcellent)

// distance
let close = MembershipPolygon(name: "close", points: Point(x: 0, y: 0)!, Point(x: 0, y: 1)!, Point(x: 50, y: 0)!)
let medium = MembershipPolygon(name: "medium", points: Point(x: 14, y: 0)!, Point(x: 50, y: 1)!, Point(x: 83, y: 0)!)
let far = MembershipPolygon(name: "far", points: Point(x: 50, y: 0)!, Point(x: 100, y: 1)!, Point(x: 100, y: 0)!)
let distance = FuzzyVariable(name: "distance", fuzzySets: close, medium, far)

print(DegreesOfMembership(fuzzyVariable: ourHealth, value: 76.88))
print(DegreesOfMembership(fuzzyVariable: enemyHealth, value: 20.1))
print(DegreesOfMembership(fuzzyVariable: distance, value: 8.54))

//: [Next](@next)
