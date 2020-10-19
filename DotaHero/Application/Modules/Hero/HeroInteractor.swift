//
//  HeroInteractor.swift
//  DotaHero
//
//  Created by Ari Munandar on 18/10/20.
//  Copyright (c) 2020 ARI MUNANDAR. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar
//              * https://www.youtube.com/channel/UC7jr8DR06tcVR0QKKl6cSNA?view_as=subscriber

import UIKit

protocol IHeroInteractor: class {
	// do someting...
}

class HeroInteractor: IHeroInteractor {
    var presenter: IHeroPresenter!

    private var manager: IHeroWorker {
        return HeroWorker()
    }

    init(presenter: IHeroPresenter) {
    	self.presenter = presenter
    }
}
