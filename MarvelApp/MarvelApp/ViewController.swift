//
//  ViewController.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 12/02/21.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let list = ListCharactersInteractor()
        list.getCharacters { (characters, errorMessage) in
            print(characters)
            print(errorMessage)
        }
        //getAllCharacters()
        //getListCharacters()
        // Do any additional setup after loading the view.
    }

    @IBAction func nextAction(_ sender: Any) {
        
        let router = ListCharactersRouter.createModule()
        self.navigationController?.pushViewController(router, animated: true)
    }
    func getAllCharacters() {
//        let privateKey = "b75e0a59ccf4b18570394d1f659a74afafe00638"
//        let publicKey = "82a9d56fcf00f2202aec2d7798b8b000"
//        let timestamp = Date().timeIntervalSince1970.description
//        let hash = "\(timestamp)\(privateKey)\(publicKey)".md5 //MD5(string: "\(timestamp)\(privateKey)\(publicKey)").base64EncodedData()
//
//        let urlString = "https://gateway.marvel.com/v1/public/characters?ts=\(timestamp)&apikey=82a9d56fcf00f2202aec2d7798b8b000&hash=\(hash)&limit=2"
//        let url = URL(string: urlString)!
        
        let url = RequestEndpoint.characters(customQuery: nil).url!
        
        Alamofire.request(url).response { response in
            if response.response?.statusCode == 200 {
                guard let data = response.data else { return }
                print(data)
                do {
                    let decoder = JSONDecoder()
                    let newsResponse = try decoder.decode(Result.self, from: data)
                    print(newsResponse)
                } catch let error {
                    print(error)
                }
            } else {
                print(response.error ?? "error")
            }
        }
    }
    func getListCharacters() {
        let privateKey = "b75e0a59ccf4b18570394d1f659a74afafe00638"
        let publicKey = "82a9d56fcf00f2202aec2d7798b8b000"
        let timestamp = Date().timeIntervalSince1970.description
        let hash = "\(timestamp)\(privateKey)\(publicKey)".md5 //MD5(string: "\(timestamp)\(privateKey)\(publicKey)").base64EncodedData()
        
        let urlString = "https://gateway.marvel.com/v1/public/characters?ts=\(timestamp)&apikey=82a9d56fcf00f2202aec2d7798b8b000&hash=\(hash)&limit=2"
        
        
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let unwrappedData = data else { return }
            do {
                let str = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as? [String: Any]
//                let value = str?["data"] as? [String: Any]
//                let results = value?["results"] as? [[String: Any]]
                print(str)
            } catch {
                print("json error: \(error)")
            }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}

