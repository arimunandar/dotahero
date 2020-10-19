//
//  HeroPresenter.swift
//  DotaHero
//
//  Created by Ari Munandar on 18/10/20.
//  Copyright (c) 2020 ARI MUNANDAR. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit

protocol IHeroPresenter: class {
	// do someting...
}

class HeroPresenter: IHeroPresenter {	
	weak var viewController: IHeroViewController!
	
	init(viewController: IHeroViewController) {
		self.viewController = viewController
	}
}
