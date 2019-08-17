import Cocoa

func doCalc() {
    let x = 100
    let y = x * x
    
    _ = y / x
}

func performCalc(iterations: Int, tag: String) {
    let start =  CFAbsoluteTimeGetCurrent()
    for _ in 0 ..< iterations {
        doCalc()
    }
    let end = CFAbsoluteTimeGetCurrent()
    print("time for \(tag) : \(end - start)")
}

//let blockOperation: BlockOperation = BlockOperation.init {
//    performCalc(iterations: 10000, tag: "Operation 1")
//}
//blockOperation.addExecutionBlock {
//    performCalc(iterations: 10, tag: "Operation 2")
//}
//blockOperation.addExecutionBlock {
//    performCalc(iterations: 1000, tag: "Operation 3")
//}
//blockOperation.addExecutionBlock {
//    performCalc(iterations: 100, tag: "Operation 4")
//}


// do tihings the easy way
let operationQueue = OperationQueue()
// make serial?
//operationQueue.maxConcurrentOperationCount = 1

operationQueue.addOperation {
    performCalc(iterations: 10000, tag: "op 1")
}
operationQueue.addOperation {
    performCalc(iterations: 1000, tag: "op 2")
}
operationQueue.addOperation {
    performCalc(iterations: 100000, tag: "op 3")
}
