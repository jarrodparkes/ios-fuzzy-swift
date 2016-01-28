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

// a slope bounded in the x-axis by [minX, maxX]
public struct PointsAndSlope: CustomStringConvertible {
    
    public var description: String {
        return "\(m), minX: \(minX), maxX: \(maxX))"
    }
    
    public let m: Double
    public var minX: Double
    public var maxX: Double
    
    init?(p1: Point, p2: Point) {
        if p2.x - p1.x <= 0 {
            return nil
        } else if p2.y - p1.y == 0 {
            m = 0
        } else {
            m = (p2.y - p1.y) / (p2.x - p1.x)
        }
        minX = p1.x < p2.x ? p1.x : p2.x
        maxX = p1.x > p2.x ? p1.x : p2.x
    }
}

// a set of points/slopes bounded in the x-axis by [minX, maxX] that create a polygonal shape
public struct FuzzySet: CustomStringConvertible, CustomDebugStringConvertible, Hashable, Equatable {
    
    public var description: String {
        return "\(name):"
    }
    
    public var debugDescription: String {
        let finalStr = "\(name): "
        /*
        for point in points {
            finalStr += "\(point)"
        }
        finalStr += " -- minX: \(minX), maxX: \(maxX) -- "
        */
        return finalStr
    }
    
    public var points = [Point]()
    public var name = "Unnamed Membership Polygon"
    public var minX: Double = 0
    public var maxX: Double = 0
    
    public init(name: String, points: Point...) {
        self.name = name
        self.points = [Point]()
        for point in points {
            self.points.append(point)
        }
        getMinMaxX()
    }
    
    public mutating func getMinMaxX() {
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
    
    public var hashValue: Int {
        return "\(description)".hashValue
    }
}

public func ==(lhs: FuzzySet, rhs: FuzzySet) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

// a collection of fuzzy sets for a fuzzy variable
public struct FuzzyVariable {
    
    public var name = "Unnamed Membership Polygon"
    public var fuzzySets: [FuzzySet]
    
    public init(name: String, fuzzySets: FuzzySet...) {
        self.name = name
        self.fuzzySets = [FuzzySet]()
        for set in fuzzySets {
            self.fuzzySets.append(set)
        }
    }
}

public struct DegreesOfMembership: CustomStringConvertible {
    
    public var description: String {
        var finalStr = "degrees of membership for \(fuzzyVariable.name) with value \(value)\n"
        for dom in degreesOfMemberShipForSets {
            finalStr += "\(dom.0.description) \(dom.1)%\n"
        }
        return finalStr
    }
    
    public var fuzzyVariable: FuzzyVariable
    public var value: Double
    public var degreesOfMemberShipForSets: [(FuzzySet, Double)]
    
    public init(fuzzyVariable: FuzzyVariable, value: Double) {        
        self.fuzzyVariable = fuzzyVariable
        self.value = value
        degreesOfMemberShipForSets = [(FuzzySet, Double)]()
        for set in fuzzyVariable.fuzzySets {
            degreesOfMemberShipForSets.append(calculateFuzziness(fuzzySet: set, value: value))
        }
    }
}

public protocol CombsOutput {}

public struct CombsSystemOutput {
    
    public let membershipsForVariables: [DegreesOfMembership]
    public let outputRules: [FuzzySet: CombsOutput]
    
    public init(membershipsForVariables: [DegreesOfMembership], outputRules: [FuzzySet: CombsOutput]) {
        self.membershipsForVariables = membershipsForVariables
        self.outputRules = outputRules
    }
    
    public func determineAnswer() {
        
        var outputs = [FuzzySet: Double]()
        
        for membershipsForVariable in membershipsForVariables {
            for degreesOfMembershipInSet in membershipsForVariable.degreesOfMemberShipForSets {
                outputs[degreesOfMembershipInSet.0] = degreesOfMembershipInSet.1
            }
        }
        
        print(outputs)
        
        var bestScore = 0.0
        var bestOutput: CombsOutput? = nil
        
        for output in outputs {
            if output.1 > bestScore {
                bestScore = output.1
                bestOutput = outputRules[output.0]!
            }
            print("\(outputRules[output.0]!): \(output.1)")
        }
        
        if let bestOutput = bestOutput {
            print("the cat should ==> \(bestOutput)")
        }        
    }
}

public func calculateFuzziness(fuzzySet fuzzySet: FuzzySet, value: Double) -> (FuzzySet, Double) {
    
    if fuzzySet.points.count < 2 {
        return (fuzzySet, 0)
    }
    
    func slope(p1 p1: Point, p2: Point) -> Double? {
        if p2.x - p1.x <= 0 {
            return nil
        } else if p2.y - p1.y == 0 {
            return 0
        } else {
            return (p2.y - p1.y) / (p2.x - p1.x)
        }
    }
    
    func pointSlope(p1 p1: Point, pointsAndSlope: PointsAndSlope) -> (Double -> Double) {
        if pointsAndSlope.m == 0 {
            return { (x) in p1.y }
        } else {
            return { (x) in return (pointsAndSlope.m * x) - (pointsAndSlope.m * p1.x) + p1.y }
        }
    }
    
    var minDegreeOfMembership = 0.0
    
    if value <= fuzzySet.maxX && value >= fuzzySet.minX {
        for index in 0...fuzzySet.points.count - 2 {
            let p1 = fuzzySet.points[index]
            let p2 = fuzzySet.points[index+1]
            if let pointsAndSlope = PointsAndSlope(p1: p1, p2: p2) {
                if value <= pointsAndSlope.maxX && value >= pointsAndSlope.minX {
                    let lineFunction = pointSlope(p1: p2, pointsAndSlope: pointsAndSlope)
                    let finalY = lineFunction(value)
                    if finalY >= 0 && finalY <= 1 {
                        let percentY = finalY * 100
                        if percentY > minDegreeOfMembership {
                            minDegreeOfMembership = percentY
                        }
                    }
                }
            }
        }
    }
    
    return (fuzzySet, minDegreeOfMembership)
}