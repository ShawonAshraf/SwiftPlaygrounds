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

let concurrentQueue = DispatchQueue(label: "cqueue.shawon", attributes: .concurrent)
let serialQueue = DispatchQueue(label: "squeue.shawon")

concurrentQueue.async(execute: {
    performCalc(iterations: 10000, tag: "async1")
})

concurrentQueue.async(execute: {
    performCalc(iterations: 100, tag: "async2")
})

concurrentQueue.async(execute: {
    performCalc(iterations: 1000, tag: "async3")
})
