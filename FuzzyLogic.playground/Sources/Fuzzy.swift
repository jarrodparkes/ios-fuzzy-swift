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

public struct MembershipPolygon: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        return "\(name):"
    }
    
    public var debugDescription: String {
        var finalStr = "\(name): "
        for point in points {
            finalStr += "\(point)"
        }
        finalStr += " -- minX: \(minX), maxX: \(maxX) -- "
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
}

public struct FuzzyVariable {
    
    public var name = "Unnamed Membership Polygon"
    public var fuzzySets: [MembershipPolygon]
    
    public init(name: String, fuzzySets: MembershipPolygon...) {
        self.name = name
        self.fuzzySets = [MembershipPolygon]()
        for set in fuzzySets {
            self.fuzzySets.append(set)
        }
    }
}

public struct DegreesOfMembership: CustomStringConvertible {
    
    public var description: String {
        var finalStr = "degrees of membership for \(fuzzyVariable.name) with value \(value)\n"
        for dom in degreesOfMemberShip {
            finalStr += "\(dom.0.description) \(dom.1)%\n"
        }
        return finalStr
    }
    
    public var fuzzyVariable: FuzzyVariable
    public var value: Double
    public var degreesOfMemberShip: [(MembershipPolygon, Double)]
    
    public init(fuzzyVariable: FuzzyVariable, value: Double) {        
        self.fuzzyVariable = fuzzyVariable
        self.value = value
        degreesOfMemberShip = [(MembershipPolygon, Double)]()
        for set in fuzzyVariable.fuzzySets {
            degreesOfMemberShip.append(calculateFuzziness(fuzzySet: set, value: value))
        }
    }
    
    public func calculateFuzziness(fuzzySet fuzzySet: MembershipPolygon, value: Double) -> (MembershipPolygon, Double) {
        
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
}