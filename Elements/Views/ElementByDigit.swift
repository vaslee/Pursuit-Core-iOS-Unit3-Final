//
//  ElementByDigit.swift
//  Elements
//
//  Created by TingxinLi on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

func newNumber(number:Int) -> String{
    var empty = ""

        switch number {
        case 0..<10:
            empty = "00\(number)"
        case 10..<100 :
            empty = "0\(number)"
        default :
            empty = "\(number)"
        }
    return empty
}






