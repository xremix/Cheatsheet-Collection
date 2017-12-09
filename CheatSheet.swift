// Debug in Live Console
// (lldb) po [myItem.myProperty]

// Single Line If let
if let count = getCount(){
  return count
}
return 0


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



// Measure Performance (extended Version of Measure Time)

func measure(_ title: String, block: (() -> ()) -> ()) {

  let startTime = CFAbsoluteTimeGetCurrent()

  block {
    let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
    print("\(title):: Time: \(timeElapsed)")
  }
}



func demo(){
  // For asynchronous code:
  measure("async test") {finish in
    myAsyncCall {
      finish()
    }
    // Code to Test here
  }
  // For synchronous code:
  measure("sync test") {finish in
   // code to benchmark
   finish()
   // Code to Teste here
 }
}