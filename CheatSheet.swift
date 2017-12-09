// Typecast in For Loop
for case let item as MyVar in myArray{
    
}

// Return Multiple Value Tuple

func getTime() -> (Int, Int, Int) {
    ...
    return ( hour, minute, second)
}


func getTime() -> (hour: Int, minute: Int,second: Int) {
    let hour = 1
    let minute = 2
    let second = 3
    return ( hour, minute, second)
}


// Measure Time
let startTime = CFAbsoluteTimeGetCurrent()

print("Time: \(CFAbsoluteTimeGetCurrent() - startTime)")