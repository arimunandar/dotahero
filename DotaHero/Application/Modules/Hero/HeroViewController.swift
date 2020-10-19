//
//  HeroViewController.swift
//  DotaHero
//
//  Created by Ari Munandar on 18/10/20.
//  Copyright (c) 2020 ARI MUNANDAR. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar
//              * https://www.youtube.com/channel/UC7jr8DR06tcVR0QKKl6cSNA?view_as=subscriber

import UIKit

protocol IHeroViewController: class {
	// do someting...
}

class HeroViewController: UIViewController {
	var interactor: IHeroInteractor!
	var router: IHeroRouter!
    var hero: Hero!
    
    convenience init(hero: Hero) {
        self.init()
        self.hero = hero
    }

	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let presenter = HeroPresenter(viewController: viewController)
        let interactor = HeroInteractor(presenter: presenter)
        let router = HeroRouter(viewController: viewController)
        viewController.interactor = interactor
        viewController.router = router
    }

	override func viewDidLoad() {
        super.viewDidLoad()
        title = hero.localizedName
    }
}

extension HeroViewController: IHeroViewController {
	// do someting...
}

extension HeroViewController {
	// do someting...
}

extension HeroViewController {
	// do someting...
}
