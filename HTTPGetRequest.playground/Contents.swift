import Cocoa

let apiRoot = "localhost:3000"
let apiPath = "/games/XBOXONE"

// alias for completion handler
typealias dataFromAPICompletionClosure = (URLResponse?, Data?) -> Void

func sendGETRequest(handler: @escaping dataFromAPICompletionClosure) {
    let urlSessionConfig = URLSessionConfiguration.default
    
    var url = URLComponents()
    url.scheme = "http"
    url.host = apiRoot
    url.path = apiPath
    
    if let queryURL = url.url {
        var req = URLRequest(url: queryURL)
        req.httpMethod = "GET"
        
        let urlSession = URLSession(configuration: urlSessionConfig)
        let sessionTask = urlSession.dataTask(with: req) {
            (data, response, error) in
            handler(response, data)
        }
        
        sessionTask.resume()
    }
}

let printQueryResults: dataFromAPICompletionClosure = {
    if let data = $1 {
        let dataString = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        print(dataString)
    } else {
        print("API returned nothing.")
    }
}

// call the function
sendGETRequest(handler: printQueryResults)
