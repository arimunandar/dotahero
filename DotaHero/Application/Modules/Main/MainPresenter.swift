//
//  MainPresenter.swift
//  DotaHero
//
//  Created by Ari Munandar on 19/10/20.
//  Copyright (c) 2020 ARI MUNANDAR. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit

protocol IMainPresenter: class {
    func presentSuccessGetHeroes()
}

class MainPresenter: IMainPresenter {	
	weak var viewController: IMainViewController!
	
	init(viewController: IMainViewController) {
		self.viewController = viewController
	}
    
    func presentSuccessGetHeroes() {
        viewController.displaySuccessGetHeroes()
    }
}
