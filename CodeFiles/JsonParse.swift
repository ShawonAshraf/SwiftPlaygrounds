import Cocoa
import Foundation

// JSON Structure
struct Games: Decodable {
    struct Game: Decodable {
        var _id: String
        var name: String
        var platform: String
        var publisher: String
    }

    var games: [Games]
}

let encoder = JSONEncoder()
let decoder = JSONDecoder()

var jsonString = """
{
  "games":[
    {"_id":"5b8e4e77ece19b04ae342842","name":"Forza Horizon 3","platform":"XBOXONE","publisher":"Microsoft Studios"},{"_id":"5bc0c4effb6fc060274322d3","name":"Forza Horizon 4","publisher":"Microsoft Studios","platform":"XBOXONE"},{"_id":"5b8e4e76ece19b04ae342822","name":"Halo Wars 2","platform":"XBOXONE","publisher":"Microsoft Studios"},{"_id":"5b8e4e76ece19b04ae342824","name":"Rise of The Tomb Raider","platform":"XBOXONE","publisher":"Square Enix"},{"_id":"5bfee02be7179a10a042afdc","name":"Super Lucky's Tale","platform":"XBOXONE","publisher":"Microsoft Studios"}]}
"""

do {
    let data = Data(jsonString.utf8)
    let games = try decoder.decode(Games.self, from: data)
    print(games.games)
} catch let error {
    print(error)
}




