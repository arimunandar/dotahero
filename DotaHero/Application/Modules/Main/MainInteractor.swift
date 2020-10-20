//
//  MainInteractor.swift
//  DotaHero
//
//  Created by Ari Munandar on 19/10/20.
//  Copyright (c) 2020 ARI MUNANDAR. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar
//              * https://www.youtube.com/channel/UC7jr8DR06tcVR0QKKl6cSNA?view_as=subscriber

import Alamofire

protocol IMainInteractor: class {
    var roles: [String] { get }
    var heroes: [Hero] { get }
    func processFilterHeroes(by role: String) -> [Hero]
    func processFetchHeroes()
}

class MainInteractor: IMainInteractor {
    var presenter: IMainPresenter!

    private var manager: IMainWorker {
        return MainWorker()
    }

    var heroes: [Hero] {
        var heroes: [Hero] = []
        let results = RealmService.share.get(object: Hero.self)
        results?.forEach { heroes.append($0) }
        return heroes.sorted(by: { ($0.localizedName ?? "") < ($1.localizedName ?? "") })
    }

    var roles: [String] {
        var roles: [String] = []
        heroes.forEach { $0.roles.forEach { roles.append($0) } }
        roles.sort()
        return roles.removingDuplicates()
    }

    init(presenter: IMainPresenter) {
        self.presenter = presenter
    }

    func processFilterHeroes(by role: String) -> [Hero] {
        if role.lowercased() == "all" {
            return heroes
        }
        let _heroes = heroes.filter { $0.roles.contains(where: { $0.lowercased() == role.lowercased() }) }
        return _heroes.sorted(by: { ($0.localizedName ?? "") < ($1.localizedName ?? "") })
    }

    func processFetchHeroes() {
        if heroes.isEmpty {
            DispatchQueue.global(qos: .background).async {
                AF.request("https://api.opendota.com/api/herostats").responseData { [weak self] response in
                    switch response.result {
                    case .success(let data):
                        do {
                            if let json = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
                                let group = DispatchGroup()
                                json.forEach { hero in
                                    group.enter()
                                    let hero = Hero(dictionary: hero)
                                    hero.saveToRealm()
                                    group.leave()
                                }
                                
                                group.notify(queue: .main) {
                                    self?.presenter.presentSuccessGetHeroes()
                                }
                            }
                        } catch {
                            print(error)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        } else {
            self.presenter.presentSuccessGetHeroes()
        }
    }
}
