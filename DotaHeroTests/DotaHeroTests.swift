//
//  DotaHeroTests.swift
//  DotaHeroTests
//
//  Created by Ari Munandar on 17/10/20.
//  Copyright © 2020 Ari Munandar. All rights reserved.
//

@testable import DotaHero
import XCTest

class DotaHeroTests: XCTestCase {
    var mainVC: MainViewController = {
        let vc = MainViewController(nibName: "MainViewController", bundle: nil)
        vc.loadView()
        vc.homeViewController.loadView()
        return vc
    }()

    func testFetchHeros() {
        if mainVC.interactor.heroes.isEmpty {
            let e = expectation(description: "Heros")
            mainVC.interactor.processFetchHeroes { (heros) in
                XCTAssertNotNil(heros)
                e.fulfill()
            }
            
            waitForExpectations(timeout: 5.0, handler: nil)
        } else {
            XCTAssertTrue(!mainVC.interactor.heroes.isEmpty)
        }
        
    }

    func testLocalFetchHeros() {
        XCTAssertNotNil(mainVC.interactor.heroes)
    }

    func testLocalFetchRoles() {
        XCTAssertNotNil(mainVC.interactor.roles)
    }
    
    func testFilterHeroes() {
        let roleName = "Carry"
        let heros = mainVC.interactor.processFilterHeroes(by: roleName)
        XCTAssertEqual(!heros.isEmpty, true)
    }
    
    func testGetSimilarHeroes() {
        let attribute = "agi"
        let heros = HeroAttribute(rawValue: attribute)?.heros
        XCTAssertNotNil(heros)
    }
}
