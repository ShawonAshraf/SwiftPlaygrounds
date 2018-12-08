import Cocoa

// JSON Structure
struct Game: Codable {
    var name: String
    var platform: String
    var publisher: String
}

struct Games: Codable {
    var games: [Games]
}

let encoder = JSONEncoder()
let decoder = JSONDecoder()

let rdr2 = Game(name: "Red Dead Redemption 2", platform: "PS4", publisher: "Rockstar")
let rdr2JSON = try? encoder.encode(rdr2)

//if let data = rdr2JSON, let dataString = String(data: data, encoding: .utf8) {
//    print(dataString)
//}

func encodeToJSON(from data: Game) -> Data? {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    return try? encoder.encode(data)
}

func decodeJSON(json: Data) -> String? {
    let dataString = String(data: json, encoding: .utf8)
    return dataString
}

//if let json = encodeToJSON(from: rdr2) {
//    let str = decodeJSON(json: json) ?? ""
//    print(str)
//}

// check from API request
class GetClient {
    var apiURL: String
    var apiEndpoint: String
    
    let urlSessionConfig = URLSessionConfiguration.default
    
    var urlComponents: URLComponents
    
    typealias postCallBackClosure = (URLResponse?, Data?) -> Void
    let printResponse: postCallBackClosure = {
        if let data = $1 {
            let dataString = String(data: data, encoding: String.Encoding.init(rawValue: String.Encoding.utf8.rawValue)) ?? ""
            print(dataString)
        }
    }
    
    init(apiURL: String, apiEndpoint: String) {
        self.apiURL = apiURL
        self.apiEndpoint = apiEndpoint
        self.urlComponents = URLComponents()
        
        initURLComponents()
    }
    
    func initURLComponents() {
        urlComponents.host = apiURL
        urlComponents.path = apiEndpoint
        urlComponents.scheme = "http"
    }
    
    func get(handler: @escaping postCallBackClosure) -> String? {
        if let url = urlComponents.url {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let urlSession = URLSession(configuration: urlSessionConfig)
            let task = urlSession.dataTask(with: request) { (data, response, error) in
                handler(response, data)
            }
            task.resume()
        } else {
            print("Invalid URL.")
        }
        
        return nil
    }
}


let client = GetClient(apiURL: "localhost:3000", apiEndpoint: "/games/PS4")
let responseData = client.get(handler: client.printResponse)

