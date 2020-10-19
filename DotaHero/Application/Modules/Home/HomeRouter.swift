//
//  HomeRouter.swift
//  DotaHero
//
//  Created by Ari Munandar on 18/10/20.
//  Copyright (c) 2020 ARI MUNANDAR. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar
//              * https://www.youtube.com/channel/UC7jr8DR06tcVR0QKKl6cSNA?view_as=subscriber

import UIKit

protocol IHomeRouter {
    func navigateToHero(hero: Hero)
}

class HomeRouter: IHomeRouter {
    weak var viewController: HomeViewController?
    
    init(viewController: HomeViewController) {
        self.viewController = viewController
    }
    
    func navigateToHero(hero: Hero) {
        viewController?.navigationController?.pushViewController(HeroViewController(hero: hero), animated: true)
    }
}
