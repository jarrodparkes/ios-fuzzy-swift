// a point in 2D bounded in the x-axis by [0, +inf], and y-axis by [0, 1]
public struct Point: CustomStringConvertible {
    
    public var description: String {
        return "(\(x), \(y))"
    }
    
    public let x: Double
    public let y: Double
    
    public init?(x: Double, y: Double) {
        if (x < 0 || y < 0 || y > 1) { return nil }
        self.x = x
        self.y = y
    }
}

// a line bounded in the x-axis by [minX, maxX]
public struct Line: CustomStringConvertible {
    
    public var description: String {
        return "\(m), minX: \(minX), maxX: \(maxX))"
    }
    
    public let m: Double
    public let minX: Double
    public let maxX: Double
    private var f: (Double -> Double)
    
    init?(p1: Point, p2: Point) {
        minX = p1.x < p2.x ? p1.x : p2.x
        maxX = p1.x > p2.x ? p1.x : p2.x
        f = { (x) in x }
        if p2.x - p1.x <= 0 {
            return nil
        } else if p2.y - p1.y == 0 {
            m = 0
            f = { (x) in p1.y }
        } else {
            let slope = (p2.y - p1.y) / (p2.x - p1.x)
            m = slope
            f = { (x) in return (slope * x) - (slope * p1.x) + p1.y }
        }
    }
    
    public func yOutput(x: Double) -> Double {
        return f(x)
    }
}

// a set of lines bounded in the x-axis by [minX, maxX] that create a shape (triangle/trapizoid)
public struct FuzzySet: CustomStringConvertible, CustomDebugStringConvertible, Hashable, Equatable {
    
    public var description: String {
        return "\(name)"
    }
    
    public var debugDescription: String {
        let finalStr = "\(name)"
        /*
        for point in points {
        finalStr += "\(point)"
        }
        finalStr += " -- minX: \(minX), maxX: \(maxX) -- "
        */
        return finalStr
    }
    
    public var lines = [Line]()
    public var name = "Unnamed Fuzzy Set"
    public var minX: Double = 0
    public var maxX: Double = 0
    public var degreeOfMembership: Double = 0
    
    public init(name: String, points: Point...) {
        self.name = name
        getMinMaxX(points)
        self.lines = [Line]()
        if points.count > 2 {
            for index in 0...points.count - 2 {
                let p1 = points[index]
                let p2 = points[index+1]
                if let line = Line(p1: p1, p2: p2) {
                    lines.append(line)
                }
            }
        }
    }
    
    public mutating func getMinMaxX(points: [Point]) {
        if points.count > 0 {
            var smallestX = points[0].x
            var biggestX = points[0].x
            for point in points {
                if point.x < smallestX {
                    smallestX = point.x
                }
                if point.x > biggestX {
                    biggestX = point.x
                }
            }
            minX = smallestX
            maxX = biggestX
        }
    }
    
    public mutating func updateDegreeOfMembership(value: Double) {
        
        var minDegreeOfMembership = 0.0
        
        if value <= maxX && value >= minX {
            for line in lines {
                if value <= line.maxX && value >= line.minX {
                    let y = line.yOutput(value)
                    if y >= 0 && y <= 1 {
                        if y > minDegreeOfMembership {
                            minDegreeOfMembership = y
                        }
                    }
                }
            }
        }
        
        degreeOfMembership = minDegreeOfMembership
    }
    
    public var hashValue: Int {
        return "\(description)".hashValue
    }
}

public func ==(lhs: FuzzySet, rhs: FuzzySet) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

// a collection of fuzzy sets for a fuzzy variable
public struct FuzzyVariable {
    
    public var name = "Unnamed Fuzzy Variable"
    public var fuzzySets: [FuzzySet]
    
    public init(name: String, fuzzySets: FuzzySet...) {
        self.name = name
        self.fuzzySets = [FuzzySet]()
        for fuzzySet in fuzzySets {
            self.fuzzySets.append(fuzzySet)
        }
    }
    
    public mutating func updateDegreesOfMembership(value: Double) {
        for idx in 0...fuzzySets.count - 1 {
            fuzzySets[idx].updateDegreeOfMembership(value)
            print("\(fuzzySets[idx].name): \(fuzzySets[idx].degreeOfMembership)")
        }
    }
}

//public struct DegreesOfMembership: CustomStringConvertible {
//
//    public var description: String {
//        var finalStr = "degrees of membership for \(fuzzyVariable.name) with value \(value)\n"
//        for dom in degreesOfMemberShipForSets {
//            finalStr += "\(dom.0.description) \(dom.1)%\n"
//        }
//        return finalStr
//    }
//
//    public var fuzzyVariable: FuzzyVariable
//    public var value: Double
//    public var degreesOfMemberShipForSets: [(FuzzySet, Double)]
//
//    public init(fuzzyVariable: FuzzyVariable, value: Double) {
//        self.fuzzyVariable = fuzzyVariable
//        self.value = value
//        degreesOfMemberShipForSets = [(FuzzySet, Double)]()
//        for set in fuzzyVariable.fuzzySets {
//            degreesOfMemberShipForSets.append(calculateFuzziness(fuzzySet: set, value: value))
//        }
//    }
//}