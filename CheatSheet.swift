// Return Tuple

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