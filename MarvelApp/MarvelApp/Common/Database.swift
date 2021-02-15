//
//  Database.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 14/02/21.
//

import UIKit
import RealmSwift

class Database {

    typealias CompletionHandler = (_ success: Bool, _ errorMessage: String?) -> Void

    func save(favoriteCharacter: FavoriteCharacter, completion: CompletionHandler) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(favoriteCharacter)
                completion(true, nil)
            }
        } catch let error {
            completion(false, error.localizedDescription)
        }
    }
    
    func getAllElements() -> [FavoriteCharacter] {
        autoreleasepool {
            do {
                let realm = try Realm()
                let favorites = Array(realm.objects(FavoriteCharacter.self))
                return favorites
            } catch {
                return []
            }
        }
    }
    
    func remove(favoriteId: Int, completion: CompletionHandler) {
        do {
            let realm = try Realm()
            guard let favoriteCharacter = realm.objects(FavoriteCharacter.self).filter("id==\(favoriteId)").first else {
                completion(false, "Não existe o objeto salvo")
                return
            }
            try realm.write {
                realm.delete(favoriteCharacter)
            }
            completion(true, nil)
        } catch let error {
            completion(false, error.localizedDescription)
        }
    }
    
    func contains(withId id: Int) -> Bool {
        do {
            let realm = try Realm()
            guard realm.objects(FavoriteCharacter.self).filter("id==\(id)").first != nil else {
                return false
            }
            return true
        } catch {
            return false
        }
    }
    
    func clear() {
        do {
            let realm = try Realm()
            let items = realm.objects(FavoriteCharacter.self)
            try realm.write {
                for item in items {
                    realm.delete(item)
                }
            }
        } catch let error {
            print(error)
        }
    }

}
