//
//  Wage.swift
//  windowshopperapp
//
//  Created by Dwi Randy Herdinanto on 31/01/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import Foundation

class Wage {
    
    class func getHours(forWage wage:Double, andPrice price: Double) -> Int{
        return Int(ceil(price/wage))
    }
}
