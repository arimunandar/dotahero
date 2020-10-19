//
//  HomePresenter.swift
//  DotaHero
//
//  Created by Ari Munandar on 18/10/20.
//  Copyright (c) 2020 ARI MUNANDAR. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit

protocol IHomePresenter: class {
    func presentSuccessGetHeros(heros: [Hero])
}

class HomePresenter: IHomePresenter {	
	weak var viewController: IHomeViewController!
	
	init(viewController: IHomeViewController) {
		self.viewController = viewController
	}
    
    func presentSuccessGetHeros(heros: [Hero]) {
        viewController.displaySuccessGetHeros(heros: heros)
    }
}
