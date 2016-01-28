// Fuzzy Logic Studies

// ourHealth
let nearDeath = MembershipPolygon(name: "nearDeath", p1: Point(x: 0, y: 0)!, p2: Point(x: 0, y: 1)!, p3: Point(x: 50, y: 0)!)
let good = MembershipPolygon(name: "good", p1: Point(x: 14, y: 0)!, p2: Point(x: 50, y: 1)!, p3: Point(x: 83, y: 0)!)
let excellent = MembershipPolygon(name: "excellent", p1: Point(x: 50, y: 0)!, p2: Point(x: 100, y: 1)!, p3: Point(x: 100, y: 0)!)
let ourHealth = FuzzyVariable(fuzzySets: nearDeath, good, excellent)

// enemyHealth
let enemyNearDeath = MembershipPolygon(name: "enemyNearDeath", p1: Point(x: 0, y: 0)!, p2: Point(x: 0, y: 1)!, p3: Point(x: 50, y: 0)!)
let enemyGood = MembershipPolygon(name: "enemyGood", p1: Point(x: 14, y: 0)!, p2: Point(x: 50, y: 1)!, p3: Point(x: 83, y: 0)!)
let enemyExcellent = MembershipPolygon(name: "enemyExcellent", p1: Point(x: 50, y: 0)!, p2: Point(x: 100, y: 1)!, p3: Point(x: 100, y: 0)!)
let enemyHealth = FuzzyVariable(fuzzySets: enemyNearDeath, enemyGood, enemyExcellent)

// distance
let close = MembershipPolygon(name: "close", p1: Point(x: 0, y: 0)!, p2: Point(x: 0, y: 1)!, p3: Point(x: 50, y: 0)!)
let medium = MembershipPolygon(name: "medium", p1: Point(x: 14, y: 0)!, p2: Point(x: 50, y: 1)!, p3: Point(x: 83, y: 0)!)
let far = MembershipPolygon(name: "far", p1: Point(x: 50, y: 0)!, p2: Point(x: 100, y: 1)!, p3: Point(x: 100, y: 0)!)
let distance = FuzzyVariable(fuzzySets: close, medium, far)

print(calcValue(ourHealth, value: 76.88))
