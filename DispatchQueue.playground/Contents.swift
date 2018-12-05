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
    performCalc(iterations: 10000, tag: "concurrent async1")
})

concurrentQueue.async(execute: {
    performCalc(iterations: 100, tag: "concurrent async2")
})

concurrentQueue.async(execute: {
    performCalc(iterations: 1000, tag: "concurrent async3")
})

// check for serial queue

serialQueue.async(execute: { performCalc(iterations: 10000, tag: "serial async1") })
serialQueue.async(execute: { performCalc(iterations: 1000, tag: "serial async2") })
serialQueue.async(execute: { performCalc(iterations: 100, tag: "serial async3") })

// asyncAfter

let waitingQueue = DispatchQueue(label: "wqueue.shawon")

let delayInSeconds = 2.0
let pTime = DispatchTime.now() + Double(Int64(delayInSeconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)

waitingQueue.asyncAfter(deadline: pTime) {
    print("Time's up!")
}
