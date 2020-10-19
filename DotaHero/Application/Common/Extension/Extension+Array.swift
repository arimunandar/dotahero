//
//  Extension+Array.swift
//  DotaHero
//
//  Created by Ari Munandar on 18/10/20.
//  Copyright © 2020 Ari Munandar. All rights reserved.
//

import UIKit

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
