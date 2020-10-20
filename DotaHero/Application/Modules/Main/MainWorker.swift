//
//  MainWorker.swift
//  DotaHero
//
//  Created by Ari Munandar on 19/10/20.
//  Copyright (c) 2020 ARI MUNANDAR. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar
//              * https://www.youtube.com/channel/UC7jr8DR06tcVR0QKKl6cSNA?view_as=subscriber

import Alamofire

protocol IMainWorker {
    var roles: [String] { get }
    var heroes: [Hero] { get }
    func processFilterHeroes(by role: String) -> [Hero]
    func processFetchHeroes(completion: ((_ heroes: Result<[Hero], DError>) -> Void)?)
}

class MainWorker: IMainWorker {
    var roles: [String] {
        var roles: [String] = []
        self.heroes.forEach { $0.roles.forEach { roles.append($0) } }
        roles.sort()
        return roles.removingDuplicates()
    }
    
    var heroes: [Hero] {
        var heroes: [Hero] = []
        let results = RealmService.share.get(object: Hero.self)
        results?.forEach({ heroes.append($0) })
        return heroes.sorted(by: { ($0.localizedName ?? "") < ($1.localizedName ?? "") })
    }
    
    func processFilterHeroes(by role: String) -> [Hero] {
        let _heroes = heroes.filter({ $0.roles.contains(where: { $0.lowercased() == role.lowercased() }) })
        return _heroes.sorted(by: { ($0.localizedName ?? "") < ($1.localizedName ?? "") })
    }
    
    func processFetchHeroes(completion: ((_ heroes: Result<[Hero], DError>) -> Void)?) {
        DispatchQueue.global(qos: .background).async {
            AF.request("https://api.opendota.com/api/heroestats").responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
                            completion?(.success(json.map { Hero(dictionary: $0) }))
                        }
                    } catch {
                        print(error)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
