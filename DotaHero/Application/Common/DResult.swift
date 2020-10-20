//
//  DResult.swift
//  DotaHero
//
//  Created by Ari Munandar on 20/10/20.
//  Copyright © 2020 Ari Munandar. All rights reserved.
//

import Foundation

enum DResult<Success, Failure>: Error {
    case success(Success)
    case failure(Failure)
}

enum DError: Error {
    case noInternet
    case generalError
}
