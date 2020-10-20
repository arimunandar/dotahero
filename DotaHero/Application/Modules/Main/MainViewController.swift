//
//  MainViewController.swift
//  DotaHero
//
//  Created by Ari Munandar on 19/10/20.
//  Copyright © 2020 Ari Munandar. All rights reserved.
//

import UIKit

protocol IMainViewController: class {
    func displaySuccessGetHeroes()
}

class MainViewController: UIViewController {
    var interactor: IMainInteractor!
    var router: IMainRouter!
    private let allConstant = "All"
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: "RoleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cellId")
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        }
    }
    
    @IBOutlet weak var filterButton: UIButton! {
        didSet {
            filterButton.layer.cornerRadius = filterButton.frame.height / 2
        }
    }
    
    @IBOutlet weak var bottomContentView: NSLayoutConstraint!
    
    lazy var homeViewController: HomeViewController = {
        let vc = HomeViewController()
        vc.didAppear = { [weak self] in
            self?.filterButton.isHidden = false
        }
        
        vc.didDisappear = { [weak self] in
            self?.filterButton.isHidden = true
        }
        return vc
    }()
    
    lazy var nav: UINavigationController = {
        let nav = UINavigationController(rootViewController: homeViewController)
        nav.view.translatesAutoresizingMaskIntoConstraints = false
        return nav
    }()
    
    var overlayView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.clipsToBounds = true
        return view
    }()
    
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
        let presenter = MainPresenter(viewController: viewController)
        let interactor = MainInteractor(presenter: presenter)
        let router = MainRouter(viewController: viewController)
        viewController.interactor = interactor
        viewController.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHomeView()
        setupOverlayView()
        interactor.processFetchHeroes()
    }
    
    @IBAction func handleShowRole(_ sender: UIButton) {
        sender.isSelected.toggle()
        showHideRole(isShow: sender.isSelected)
    }
}

extension MainViewController {
    private func setupHomeView() {
        addChild(nav)
        contentView.addSubview(nav.view)
        setupConstrain(subview: nav.view)
        nav.didMove(toParent: self)
    }
    
    private func setupOverlayView() {
        view.insertSubview(overlayView, belowSubview: filterButton)
        setupConstrain(subview: overlayView)
    }
    
    private func setupConstrain(subview: UIView) {
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: contentView.topAnchor),
            subview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            subview.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            subview.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
}

extension MainViewController {
    private func showHideRole(isShow: Bool) {
        DispatchQueue.main.async {
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 1,
                options: .curveEaseInOut,
                animations: {
                    self.roundCorners(radius: isShow ? 30 : 0, views: [self.contentView, self.overlayView])
                    self.bottomContentView.constant = isShow ? 120 : 0
                    self.overlayView.bounds.origin.y = isShow ? 120 : 0
                    self.overlayView.alpha = isShow ? 1 : 0
                    self.view.layoutIfNeeded()
                },
                completion: nil
            )
        }
    }
    
    private func roundCorners(radius: CGFloat, views: [UIView]) {
        views.forEach { subview in
            subview.layer.cornerRadius = radius
            subview.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        filterButton.isSelected.toggle()
        showHideRole(isShow: filterButton.isSelected)
        let heroesFiltered = interactor.processFilterHeroes(
            by: indexPath.item == 0 ? allConstant :  interactor.roles[indexPath.item - 1]
        )
        homeViewController.heroes = heroesFiltered
        homeViewController.collectionView.reloadData()
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor.roles.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? RoleCollectionViewCell else { fatalError() }
        cell.binding(roleName: indexPath.item == 0 ? allConstant : interactor.roles[indexPath.item - 1])
        return cell
    }
}

extension MainViewController: IMainViewController {
    func displaySuccessGetHeroes() {
        collectionView.reloadData()
        collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .top)
        homeViewController.heroes = interactor.heroes
        DispatchQueue.main.async {
            self.homeViewController.collectionView.reloadData()
        }
    }
}
