//
//  HomeInteractor.swift
//  DotaHero
//
//  Created by Ari Munandar on 18/10/20.
//  Copyright (c) 2020 ARI MUNANDAR. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar
//              * https://www.youtube.com/channel/UC7jr8DR06tcVR0QKKl6cSNA?view_as=subscriber

import UIKit

protocol IHomeInteractor: class {
    func handleFetchHeros()
    func handleFilterHerosBy(role: String)
}

class HomeInteractor: IHomeInteractor {
    var presenter: IHomePresenter!

    private var manager: IHomeWorker {
        return HomeWorker()
    }

    private var heros: [Hero] = []

    init(presenter: IHomePresenter) {
        self.presenter = presenter
    }

    func handleFetchHeros() {
        manager.fetchFromLocal { [weak self] heros in
            if heros.isEmpty {
                self?.manager.fetchHeros { result in
                    switch result {
                    case .success(let heros):
                        heros.forEach { $0.saveToRealm() }
                        self?.presenter.presentSuccessGetHeros(heros: heros)
                    case .failure(let error):
                        print(error)
                    }
                }
            } else {
                let _heros = heros.sorted {
                    var isSorted = false
                    if let first = $0.localizedName, let second = $1.localizedName {
                        isSorted = first < second
                    }
                    return isSorted
                }
                self?.presenter.presentSuccessGetHeros(heros: _heros)
            }
        }
    }

    func handleFilterHerosBy(role: String) {
        manager.fetchFromLocal { [weak self] heros in
            let allHeros = heros.sorted {
                var isSorted = false
                if let first = $0.localizedName, let second = $1.localizedName {
                    isSorted = first < second
                }
                return isSorted
            }
            let herosFiltered = allHeros.filter({ $0.roles.contains(where: { $0.lowercased() == role.lowercased() }) })
            self?.presenter.presentSuccessGetHeros(heros: role.lowercased() == "all" ? allHeros : herosFiltered)
        }
    }
}
