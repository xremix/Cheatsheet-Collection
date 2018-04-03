# Swift Cheat Sheet

Cheat Sheet for iOS Development using Swift, containing a couple of code samples that are interesting to know and remember when needed. Mostly interesting are longer code samples at the bottom.

## Debug in Live Console
```
(lldb) po [myItem.myProperty]
```

## Single Line If let
```Swift
if let count = getCount(){
  return count
}
return 0
``` 
## Multiline String
```Swift
    let multilineString = """
      Line No 1
      Line No 2
    """
```


## Typecast in For Loop
```Swift
for case let item as MyVar in myArray{
 // ...
}
```

## Return Multiple Value Tuple
```Swift
func getTime() -> (Int, Int, Int) {
  // ...
  return ( hour, minute, second)
}


func getTime() -> (hour: Int, minute: Int,second: Int) {
  let hour = 1
  let minute = 2
  let second = 3
  return ( hour, minute, second)
}
```

## Extended Getter and Setter
```Swift
class family {
  var _members:Int = 2
  var members:Int {
   get {
     return _members
   }
   set (newVal) {
     if newVal >= 2 {
       _members = newVal
       } else {
         println('error: cannot have family with less than 2 members')
       }
     }
   }
}
```

## Animate View
```Swift
UIView.animate(withDuration: 0.2, animations: {myView.backgroundColor = UIColor.red})
// or
UIView.animate(withDuration: 0.2, animations: {myView.backgroundColor = UIColor.red}, completion: { success in
})
```

## Human Readable Time Interval
```Swift
class HumanTimeInterval{
    // inspired by https://gist.github.com/skreutzberger/9122ac3683f3354a7e24
    static func relativeDateInterval(date: Date) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.includesApproximationPhrase = false
        formatter.includesTimeRemainingPhrase = false
        formatter.allowedUnits = [.year, .month, .weekOfMonth, .day, .hour, .minute, .second]
        formatter.maximumUnitCount = 2
        
        return formatter.string(from: date, to: Date())
    }
}


//////////////
// Example
let str = HumanTimeInterval.relativeDateInterval(date: Date(timeIntervalSince1970: 1522754818))
```

## Measure Time
```Swift
let startTime = CFAbsoluteTimeGetCurrent()

print("Time: \(CFAbsoluteTimeGetCurrent() - startTime)")
```

## Run Code in Background Thread
```Swift
DispatchQueue.global(qos: .background).async {
  print("This is run on the background queue")

  DispatchQueue.main.async {
    print("This is run on the main queue, after the previous code in outer block")
  }
}
```

## Run Code with Delay
```Swift
DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
})
```

## Measure Performance (extended Version of Measure Time)
```Swift
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
```

## Array Map
Map an Array of objects

```Swift
users = users.map { (user: User) -> User in
    var mutableUser = user
    mutableUser.loggedIn = false
    return mutableUser
}
// Or as an alternative
users = self.users.map{return $0}
```
