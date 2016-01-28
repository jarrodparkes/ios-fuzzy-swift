//: [Previous](@previous)

// fatigue
let wideAwake = FuzzySet(name: "wideAwake", points: Point(x: 0, y: 0)!, Point(x: 0, y: 1)!, Point(x: 1, y: 1)!, Point(x: 4, y: 0)!)
let weary = FuzzySet(name: "weary", points: Point(x: 3, y: 0)!, Point(x: 5, y: 1)!, Point(x: 7, y: 0)!)
let veryTired = FuzzySet(name: "veryTired", points: Point(x: 6, y: 0)!, Point(x: 9, y: 1)!, Point(x: 10, y: 1)!, Point(x: 10, y: 0)!)
let fatigue = FuzzyVariable(name: "fatigue", fuzzySets: wideAwake, weary, veryTired)

// hunger
let full = FuzzySet(name: "full", points: Point(x: 0, y: 0)!, Point(x: 0, y: 1)!, Point(x: 2, y: 0)!)
let craving = FuzzySet(name: "craving", points: Point(x: 1, y: 0)!, Point(x: 5, y: 1)!, Point(x: 9, y: 0)!)
let famished = FuzzySet(name: "famished", points: Point(x: 8, y: 0)!, Point(x: 10, y: 1)!, Point(x: 10, y: 0)!)
let hunger = FuzzyVariable(name: "hunger", fuzzySets: full, craving, famished)

// cleanliness
let gross = FuzzySet(name: "gross", points: Point(x: 0, y: 0)!, Point(x: 0, y: 1)!, Point(x: 2, y: 0)!)
let dirty = FuzzySet(name: "dirty", points: Point(x: 1, y: 0)!, Point(x: 6, y: 1)!, Point(x: 7, y: 0)!)
let clean = FuzzySet(name: "clean", points: Point(x: 4, y: 0)!, Point(x: 7, y: 1)!, Point(x: 10, y: 1)!, Point(x: 10, y: 0)!)
let cleanliness = FuzzyVariable(name: "cleanliness", fuzzySets: gross, dirty, clean)

// happiness
let sad = FuzzySet(name: "sad", points: Point(x: 0, y: 0)!, Point(x: 0, y: 1)!, Point(x: 2, y: 0)!)
let satisfied = FuzzySet(name: "satisfied", points: Point(x: 2, y: 0)!, Point(x: 5, y: 1)!, Point(x: 7, y: 0)!)
let overjoyed = FuzzySet(name: "overjoyed", points: Point(x: 7, y: 0)!, Point(x: 10, y: 1)!, Point(x: 10, y: 0)!)
let happiness = FuzzyVariable(name: "happiness", fuzzySets: sad, satisfied, overjoyed)

let membershipsForFatigue = DegreesOfMembership(fuzzyVariable: fatigue, value: 3.2)
let membershipsForHunger = DegreesOfMembership(fuzzyVariable: hunger, value: 3.2)
let membershipsForCleanliness = DegreesOfMembership(fuzzyVariable: cleanliness, value: 3.2)
let membershipsForHappiness = DegreesOfMembership(fuzzyVariable: happiness, value: 3.2)

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

let membershipsForVariables = [
    membershipsForFatigue, membershipsForHunger, membershipsForCleanliness, membershipsForHappiness
]

let finalOutput = CombsSystemOutput(membershipsForVariables: membershipsForVariables, outputRules: outputRules)

finalOutput.determineAnswer()