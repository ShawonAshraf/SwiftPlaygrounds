import Cocoa

// file io in swift

let fileManager = FileManager.default
let path = "/Applications/"

do {
    let dirContents = try fileManager.contentsOfDirectory(atPath: path)
    print("\(path) contains \(dirContents.count) things.")
} catch let error {
    print(error)
}
