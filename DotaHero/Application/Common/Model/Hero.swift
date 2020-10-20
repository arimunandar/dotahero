//
//  Hero.swift
//
//  Created by Ari Munandar on 18/10/20
//  Copyright (c) . All rights reserved.
//

import Foundation
import RealmSwift

class Hero: Object {
    let roles = List<String>()
    @objc dynamic var heroId: Int = 0
    @objc dynamic var baseArmor: Int = 0
    @objc dynamic var primaryAttr: String?
    @objc dynamic var localizedName: String?
    @objc dynamic var baseHealth: Int = 0
    @objc dynamic var img: String?
    @objc dynamic var baseStr: Int = 0
    @objc dynamic var baseMana: Int = 0
    @objc dynamic var icon: String?
    @objc dynamic var name: String?
    @objc dynamic var attackRange: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var baseAgi: Int = 0
    @objc dynamic var baseInt: Int = 0
    @objc dynamic var baseMr: Int = 0
    @objc dynamic var baseAttackMin: Int = 0
    @objc dynamic var baseAttackMax: Int = 0
    @objc dynamic var attackType: String?
    @objc dynamic var moveSpeed: Int = 0

    convenience init(dictionary: [String: Any]) {
        self.init()
        if let value = dictionary["roles"] as? [String] {
            value.forEach({ roles.append($0) })
        }

        if let value = dictionary["hero_id"] as? Int {
            heroId = value
        }

        if let value = dictionary["base_armor"] as? Int {
            baseArmor = value
        }

        if let value = dictionary["primary_attr"] as? String {
            primaryAttr = value
        }

        if let value = dictionary["localized_name"] as? String {
            localizedName = value
        }

        if let value = dictionary["base_health"] as? Int {
            baseHealth = value
        }

        if let value = dictionary["img"] as? String {
            img = value
        }

        if let value = dictionary["base_str"] as? Int {
            baseStr = value
        }

        if let value = dictionary["base_mana"] as? Int {
            baseMana = value
        }

        if let value = dictionary["icon"] as? String {
            icon = value
        }

        if let value = dictionary["name"] as? String {
            name = value
        }

        if let value = dictionary["attack_range"] as? Int {
            attackRange = value
        }

        if let value = dictionary["id"] as? Int {
            id = value
        }

        if let value = dictionary["base_agi"] as? Int {
            baseAgi = value
        }

        if let value = dictionary["base_int"] as? Int {
            baseInt = value
        }

        if let value = dictionary["base_mr"] as? Int {
            baseMr = value
        }

        if let value = dictionary["attack_type"] as? String {
            attackType = value
        }
        
        if let value = dictionary["move_speed"] as? Int {
            moveSpeed = value
        }
        
        if let value = dictionary["base_attack_min"] as? Int {
            baseAttackMin = value
        }
        
        if let value = dictionary["base_attack_max"] as? Int {
            baseAttackMax = value
        }
    }
    
    func saveToRealm() {
        RealmService.share.add(object: self)
    }
}
