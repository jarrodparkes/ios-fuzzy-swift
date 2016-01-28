//: [Previous](@previous)

// food
let rancid = MembershipPolygon(name: "rancid", points: Point(x: 0, y: 0)!, Point(x: 0, y: 1)!, Point(x: 1, y: 1)!, Point(x: 3, y: 0)!)
let delicious = MembershipPolygon(name: "delicious", points: Point(x: 7, y: 0)!, Point(x: 9, y: 1)!, Point(x: 9, y: 0)!)
let food = FuzzyVariable(name: "food", fuzzySets: rancid, delicious)

// service
let poor = MembershipPolygon(name: "poor", points: Point(x: 0, y: 0)!, Point(x: 0, y: 1)!, Point(x: 4, y: 0)!)
let good = MembershipPolygon(name: "good", points: Point(x: 1, y: 0)!, Point(x: 4, y: 1)!, Point(x: 6, y: 1)!, Point(x: 9, y: 0)!)
let excellent = MembershipPolygon(name: "excellent", points: Point(x: 6, y: 0)!, Point(x: 9, y: 1)!, Point(x: 9, y: 0)!)
let service = FuzzyVariable(name: "service", fuzzySets: poor, good, excellent)

print(DegreesOfMembership(fuzzyVariable: food, value: 7))
print(DegreesOfMembership(fuzzyVariable: service, value: 3))

//: [Next](@next)