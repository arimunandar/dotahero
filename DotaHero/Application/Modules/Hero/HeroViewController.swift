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
import SDWebImage

enum HeroAttribute: String {
    case agi = "agi"
    case int = "int"
    case str = "str"
    
    var heros: [Hero] {
        switch self {
        case .agi:
            let _heroes = heroes.sorted(by: { $0.moveSpeed > $1.moveSpeed })
            return Array(_heroes[0..<3])
        case .int:
            let _heroes = heroes.sorted(by: { $0.baseMana > $1.baseMana })
            return Array(_heroes[0..<3])
        case .str:
            let _heroes = heroes.sorted(by: { $0.baseAttackMax > $1.baseAttackMax })
            return Array(_heroes[0..<3])
        }
    }
    
    private var heroes: [Hero] {
        var heroes: [Hero] = []
        let results = RealmService.share.get(object: Hero.self)
        results?.forEach { heroes.append($0) }
        return heroes
    }
}

protocol IHeroViewController: class {
	// do someting...
}

class HeroViewController: UIViewController {
	var interactor: IHeroInteractor!
	var router: IHeroRouter!
    var hero: Hero!
    
    @IBOutlet weak var heroImageView: UIImageView! {
        didSet {
            heroImageView.layer.cornerRadius = 10
            if let urlString = hero.img {
                heroImageView.sd_setImage(with: URL(string: "https://api.opendota.com" + urlString))
            }
        }
    }
    
    @IBOutlet weak var rolesStackView: UIStackView! {
        didSet {
            hero.roles.forEach { (role) in
                let roleLabel = UILabel()
                roleLabel.text = "- \(role)"
                roleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
                roleLabel.textAlignment = .left
                rolesStackView.addArrangedSubview(roleLabel)
            }
        }
    }
    
    @IBOutlet weak var similarHeroes: UIStackView! {
        didSet {
            setupSimilarHeroes()
        }
    }
    
    @IBOutlet weak var strLabel: UILabel! {
        didSet {
            strLabel.text = hero.primaryAttr?.uppercased()
        }
    }
    
    @IBOutlet weak var poisonLabel: UILabel! {
        didSet {
            poisonLabel.text = "\(hero.baseMana)"
        }
    }
    
    @IBOutlet weak var shieldLabel: UILabel! {
        didSet {
            shieldLabel.text = "\(hero.baseArmor)"
        }
    }
    
    @IBOutlet weak var attackLabel: UILabel! {
        didSet {
            attackLabel.text = "\(hero.baseAttackMin) - \(hero.baseAttackMax)"
        }
    }
    
    @IBOutlet weak var speedLabel: UILabel! {
        didSet {
            speedLabel.text = "\(hero.moveSpeed)"
        }
    }
    
    @IBOutlet weak var healthLabel: UILabel! {
        didSet {
            healthLabel.text = "\(hero.baseHealth)"
        }
    }
    
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
    
    func setupSimilarHeroes() {
        if let attribute = hero.primaryAttr, let heroes = HeroAttribute(rawValue: attribute)?.heros {
            heroes.forEach { (hero) in
                if let urlString = hero.img {
                    let heroImage = UIImageView()
                    heroImage.contentMode = .scaleAspectFill
                    heroImage.layer.cornerRadius = 10
                    heroImage.sd_setImage(with: URL(string: "https://api.opendota.com" + urlString))
                    heroImage.clipsToBounds = true
                    heroImage.translatesAutoresizingMaskIntoConstraints = false
                    
                    NSLayoutConstraint.activate([
                        heroImage.heightAnchor.constraint(equalToConstant: 80)
                    ])
                    similarHeroes.addArrangedSubview(heroImage)
                }
            }
        }
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
