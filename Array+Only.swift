//
//  Array+Only.swift
//  Memorize
//
//  Created by Rohan Erasala on 6/6/20.
//  Copyright © 2020 Rohan Erasala. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
