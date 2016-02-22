//: [Previous](@previous)

// fatigue
let wideAwake = FuzzySet(name: "wideAwake", points: Point(x: 0, y: 0)!, Point(x: 0, y: 1)!, Point(x: 1, y: 1)!, Point(x: 4, y: 0)!)
let weary = FuzzySet(name: "weary", points: Point(x: 3, y: 0)!, Point(x: 5, y: 1)!, Point(x: 7, y: 0)!)
let veryTired = FuzzySet(name: "exhausted", points: Point(x: 6, y: 0)!, Point(x: 9, y: 1)!, Point(x: 10, y: 1)!, Point(x: 10, y: 0)!)
var fatigue = FuzzyVariable(name: "fatigue", fuzzySets: wideAwake, weary, veryTired)

// hunger
let full = FuzzySet(name: "full", points: Point(x: 0, y: 0)!, Point(x: 0, y: 1)!, Point(x: 2, y: 0)!)
let craving = FuzzySet(name: "craving", points: Point(x: 1, y: 0)!, Point(x: 5, y: 1)!, Point(x: 9, y: 0)!)
let famished = FuzzySet(name: "famished", points: Point(x: 8, y: 0)!, Point(x: 10, y: 1)!, Point(x: 10, y: 0)!)
var hunger = FuzzyVariable(name: "hunger", fuzzySets: full, craving, famished)

// cleanliness
let gross = FuzzySet(name: "gross", points: Point(x: 0, y: 0)!, Point(x: 0, y: 1)!, Point(x: 2, y: 0)!)
let dirty = FuzzySet(name: "dirty", points: Point(x: 1, y: 0)!, Point(x: 6, y: 1)!, Point(x: 7, y: 0)!)
let clean = FuzzySet(name: "pristine", points: Point(x: 4, y: 0)!, Point(x: 7, y: 1)!, Point(x: 10, y: 1)!, Point(x: 10, y: 0)!)
var cleanliness = FuzzyVariable(name: "cleanliness", fuzzySets: gross, dirty, clean)

// happiness
let sad = FuzzySet(name: "sad", points: Point(x: 0, y: 0)!, Point(x: 0, y: 1)!, Point(x: 2, y: 0)!)
let satisfied = FuzzySet(name: "satisfied", points: Point(x: 2, y: 0)!, Point(x: 5, y: 1)!, Point(x: 7, y: 0)!)
let overjoyed = FuzzySet(name: "overjoyed", points: Point(x: 7, y: 0)!, Point(x: 10, y: 1)!, Point(x: 10, y: 0)!)
var happiness = FuzzyVariable(name: "happiness", fuzzySets: sad, satisfied, overjoyed)

public protocol CombsOutput {}

public struct CombsSystemOutput {
    
    public var fuzzyVariables: [FuzzyVariable]
    public let outputRules: [FuzzySet: CombsOutput]
    
    public init(fuzzyVariables: [FuzzyVariable], outputRules: [FuzzySet: CombsOutput]) {
        self.fuzzyVariables = fuzzyVariables
        self.outputRules = outputRules
    }
    
    public mutating func determineAnswer(value: Double) {
        
        var outputs = [FuzzySet: Double]()
        
        for idx in 0...fuzzyVariables.count - 1 {
            fuzzyVariables[idx].updateDegreesOfMembership(value)
            for fuzzySet in fuzzyVariables[idx].fuzzySets {
                outputs[fuzzySet] = fuzzySet.degreeOfMembership
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

// define outputs
enum CatStateOutputs: CombsOutput {
    case Play
    case Sleep
    case Poop
    case Meow
    case Eat
    case Groom
    case Purr
}

// define output rules
let outputRules: [FuzzySet: CombsOutput] = [
    wideAwake: CatStateOutputs.Play,
    weary: CatStateOutputs.Sleep,
    veryTired: CatStateOutputs.Sleep,
    full: CatStateOutputs.Poop,
    craving: CatStateOutputs.Meow,
    famished: CatStateOutputs.Eat,
    gross: CatStateOutputs.Groom,
    dirty: CatStateOutputs.Groom,
    clean: CatStateOutputs.Purr,
    sad: CatStateOutputs.Meow,
    satisfied: CatStateOutputs.Sleep,
    overjoyed: CatStateOutputs.Purr
]

let fuzzyVariables = [
    fatigue, hunger, cleanliness, happiness
]

var finalOutput = CombsSystemOutput(fuzzyVariables: fuzzyVariables, outputRules: outputRules)

finalOutput.determineAnswer(3.2)
