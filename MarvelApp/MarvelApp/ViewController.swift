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
    }

    @IBAction func nextAction(_ sender: Any) {
        
//        let router = ListCharactersRouter.createModule()
//        self.navigationController?.pushViewController(router, animated: true)
        let router = FavoriteRouter.createModule()
        self.navigationController?.pushViewController(router, animated: true)
    }
    func getAllCharacters() {
        
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}

