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

import UIKit

protocol IMainInteractor: class {
    func handleGetRoles()
}

class MainInteractor: IMainInteractor {
    var presenter: IMainPresenter!

    private var manager: IMainWorker {
        return MainWorker()
    }

    init(presenter: IMainPresenter) {
    	self.presenter = presenter
    }
    
    func handleGetRoles() {
        var roles: [String] = []
        let heros = RealmService.share.get(object: Hero.self)
        heros?.forEach { $0.roles.forEach { roles.append($0) } }
        roles.sort()
        presenter.presentSuccessGetRoles(roles: roles.removingDuplicates())
    }
}
