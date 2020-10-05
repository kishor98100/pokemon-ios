//
//  Pokemons.swift
//  Pokemon
//
//  Created by Kishor Mainali on 10/5/20.
//

import UIKit

class Pokemons {
    var latitude:Double
    var longitude:Double
    var image:String
    var name:String
    var description:String
    var power:Double
    var isCached:Bool
    
    init(latitude:Double,longitude:Double,
     image:String,
     name:String,
     description:String,
     power:Double,
     isCached:Bool) {
        self.latitude = latitude
        self.longitude = longitude
        self.image = image
        self.name = name
        self.description = description
        self.power = power
        self.isCached = isCached
    }

}
