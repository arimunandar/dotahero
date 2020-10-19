//
//  RealmService.swift
//  DotaHero
//
//  Created by Ari Munandar on 18/10/20.
//  Copyright © 2020 Ari Munandar. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    static let share = RealmService()
    
    var realm = try? Realm()
    
    func add<T: Object>(object: T) {
        try! realm?.write {
            realm?.add(object)
        }
    }
    
    func get<T: Object>(object: T.Type) -> Results<T>? {
        return realm?.objects(object)
    }
}
