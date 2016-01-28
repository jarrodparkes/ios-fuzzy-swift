//: [Previous](@previous)

// fatigue
let wideAwake = MembershipPolygon(name: "wideAwake", points: Point(x: 0, y: 0)!, Point(x: 0, y: 1)!, Point(x: 1, y: 1)!, Point(x: 4, y: 0)!)
let weary = MembershipPolygon(name: "weary", points: Point(x: 3, y: 0)!, Point(x: 5, y: 1)!, Point(x: 7, y: 0)!)
let veryTired = MembershipPolygon(name: "veryTired", points: Point(x: 6, y: 0)!, Point(x: 9, y: 1)!, Point(x: 10, y: 1)!, Point(x: 10, y: 0)!)
let fatigue = FuzzyVariable(name: "fatigue", fuzzySets: wideAwake, weary, veryTired)

// hunger
let full = MembershipPolygon(name: "full", points: Point(x: 0, y: 0)!, Point(x: 0, y: 1)!, Point(x: 2, y: 0)!)
let craving = MembershipPolygon(name: "craving", points: Point(x: 1, y: 0)!, Point(x: 5, y: 1)!, Point(x: 9, y: 0)!)
let famished = MembershipPolygon(name: "famished", points: Point(x: 8, y: 0)!, Point(x: 10, y: 1)!, Point(x: 10, y: 0)!)
let hunger = FuzzyVariable(name: "hunger", fuzzySets: full, craving, famished)

// cleanliness
let gross = MembershipPolygon(name: "gross", points: Point(x: 0, y: 0)!, Point(x: 0, y: 1)!, Point(x: 2, y: 0)!)
let dirty = MembershipPolygon(name: "dirty", points: Point(x: 1, y: 0)!, Point(x: 6, y: 1)!, Point(x: 7, y: 0)!)
let clean = MembershipPolygon(name: "clean", points: Point(x: 4, y: 0)!, Point(x: 7, y: 1)!, Point(x: 10, y: 1)!, Point(x: 10, y: 0)!)
let cleanliness = FuzzyVariable(name: "cleanliness", fuzzySets: gross, dirty, clean)

// happiness
let sad = MembershipPolygon(name: "sad", points: Point(x: 0, y: 0)!, Point(x: 0, y: 1)!, Point(x: 2, y: 0)!)
let satisfied = MembershipPolygon(name: "satisfied", points: Point(x: 2, y: 0)!, Point(x: 5, y: 1)!, Point(x: 7, y: 0)!)
let overjoyed = MembershipPolygon(name: "overjoyed", points: Point(x: 7, y: 0)!, Point(x: 10, y: 1)!, Point(x: 10, y: 0)!)
let happiness = FuzzyVariable(name: "happiness", fuzzySets: sad, satisfied, overjoyed)

print(DegreesOfMembership(fuzzyVariable: fatigue, value: 3.2))
print(DegreesOfMembership(fuzzyVariable: hunger, value: 3.2))
print(DegreesOfMembership(fuzzyVariable: cleanliness, value: 3.2))
print(DegreesOfMembership(fuzzyVariable: happiness, value: 3.2))