//
//  Database.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 14/02/21.
//

import UIKit
import RealmSwift
class Database {
    
    func save(favoriteCharacter: FavoriteCharacter, completion: @escaping (_ success: Bool) -> Void) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(favoriteCharacter)
                completion(true)
            }
        } catch {
            completion(false)
        }
    }
    
    func getAllElements(completion: @escaping (_ success: Bool, _ favorites: [FavoriteCharacter]?) -> Void) {
        DispatchQueue(label: "background").async {
            autoreleasepool {
                do {
                    let realm = try Realm()
                    let favorites = Array(realm.objects(FavoriteCharacter.self))
                    completion(true, favorites)
                } catch {
                    completion(false, nil)
                }
            }
        }
    }
    
    func delete(favoriteId: Int, completion: @escaping (_ success: Bool) -> Void) {
        do {
            let realm = try Realm()
            guard let favoriteCharacter = realm.objects(FavoriteCharacter.self).filter("id==\(favoriteId)").first else {
                completion(false)
                return
            }
            realm.delete(favoriteCharacter)
            completion(true)
        } catch {
            completion(false)
        }
    }

}
