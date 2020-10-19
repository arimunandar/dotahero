//
//  HomeWorker.swift
//  DotaHero
//
//  Created by Ari Munandar on 18/10/20.
//  Copyright (c) 2020 ARI MUNANDAR. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar
//              * https://www.youtube.com/channel/UC7jr8DR06tcVR0QKKl6cSNA?view_as=subscriber

import Alamofire
import Foundation
import RealmSwift

protocol IHomeWorker {
    func fetchHeros(completion: ((Swift.Result<[Hero], Error>) -> Void)?)
    func fetchFromLocal(completion: (([Hero]) -> Void)?)
}

class HomeWorker: IHomeWorker {
    func fetchHeros(completion: ((Result<[Hero], Error>) -> Void)?) {
        AF.request("https://api.opendota.com/api/herostats").responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
                        completion?(.success(json.map { Hero(dictionary: $0) }))
                    }
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchFromLocal(completion: (([Hero]) -> Void)?) {
        guard let results = RealmService.share.get(object: Hero.self) else {
            completion?([])
            return
        }
        var heros: [Hero] = []
        results.forEach({ heros.append($0) })
        completion?(heros)
    }
}
