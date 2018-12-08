import Cocoa

// JSON Structure
struct Game: Codable {
    let  _id: String
    let name: String
    let platform: String
    let publisher: String?
}

struct Games: Codable {
    let games: [Game]
}

let jsonString = """
{"games":[{"_id":"5b8e4e77ece19b04ae342842","name":"Forza Horizon 3","platform":"XBOXONE","publisher":"Microsoft Studios"},{"_id":"5bc0c4effb6fc060274322d3","name":"Forza Horizon 4","publisher":"Microsoft Studios","platform":"XBOXONE"},{"_id":"5b8e4e76ece19b04ae342822","name":"Halo Wars 2","platform":"XBOXONE","publisher":"Microsoft Studios"},{"_id":"5b8e4e76ece19b04ae342824","name":"Rise of The Tomb Raider","platform":"XBOXONE","publisher":"Square Enix"},{"_id":"5bfee02be7179a10a042afdc","name":"Super Lucky's Tale","platform":"XBOXONE","publisher":"Microsoft Studios"}]}
"""
// decode
let data = jsonString.data(using: .utf8)
if let jsonData = data {
    do {
        let response = try JSONDecoder().decode(Games.self, from: jsonData)
        for game in response.games {
            print(game)
        }
    } catch let error {
        print(error)
    }
}

let encoder = JSONEncoder()
let decoder = JSONDecoder()

let rdr2 = Game(_id: "909", name: "Red Dead Redemption 2", platform: "PS4", publisher: "Rockstar")
let rdr2JSON = try? encoder.encode(rdr2)

if let data = rdr2JSON, let dataString = String(data: data, encoding: .utf8) {
    print(dataString)
}


// check from API request
class GetClient {
    var apiURL: String
    var apiEndpoint: String
    
    let urlSessionConfig = URLSessionConfiguration.default
    
    var urlComponents: URLComponents
    
    typealias postCallBackClosure = (URLResponse?, Data?) -> Void
    let printResponse: postCallBackClosure = {
        if let data = $1 {
            // decode as object
            do {
                let response = try JSONDecoder().decode(Games.self, from: data)
                print("Got \(data) from API with \(response.games.count) games")
                for game in response.games {
                    print(game)
                }
            } catch let error {
                print(error)
            }
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
