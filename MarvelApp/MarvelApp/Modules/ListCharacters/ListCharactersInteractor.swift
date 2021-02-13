//
//  ListCharactersInteractor.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 12/02/21.
//

import UIKit
import Alamofire

class ListCharactersInteractor {

    func getCharacters(completion: @escaping (_ characters: [Character]?, _ errorMessage: String?) -> Void) {
        guard let url = RequestEndpoint.characters.url else {
            //TO DO: tratamento de erro
            return
        }
        Alamofire.request(url).response { response in
            if let data = response.data {
                do {
                    let decoder = try JSONDecoder().decode(Result.self, from: data)
                    completion(decoder.data.results, nil)
                } catch let error {
                    // Tratamento de erro
                    print(error)
                }
            } else {
                // Tratamento de erro
            }
        }
    }
    

}



 /*
fileprivate struct MarvelAPIConfig {
    fileprivate static let keys = MarvelKeys()
    static let privatekey = keys.marvelPrivateKey()!
    static let apikey = keys.marvelApiKey()!
    static let ts = Date().timeIntervalSince1970.description
    static let hash = "\(ts)\(privatekey)\(apikey)".md5()
}
 
enum MarvelAPI {
    case characters(String?)
    case character(String)
}
 
extension MarvelAPI: TargetType {
    var baseURL: URL { return URL(string: "https://gateway.marvel.com:443")! }
    
    
    var path: String {
        switch self {
        case .characters:
            return "/v1/public/characters"
        case .character(let characterId):
            return "/v1/public/characters/\(characterId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .characters, .character:
            return .get
        }
    }
    
    func authParameters() -> [String: String] {
        return ["apikey": MarvelAPIConfig.apikey,
                "ts": MarvelAPIConfig.ts,
                "hash": MarvelAPIConfig.hash]
    }
    
    var parameters: [String: Any]? {
        
        switch self {
        
        case .characters(let query):
            if let query = query {
                return $.merge(authParameters(),
                               ["nameStartsWith": query])
            }
            return authParameters()
            
        case .character(let characterId):
            return $.merge(authParameters(),
                           ["characterId": characterId])
        }
    }
    
    var task: Task {
        return .request
    }
    
    var sampleData: Data {
        switch self {
        default:
            return Data()
        }
    }
}
*/
