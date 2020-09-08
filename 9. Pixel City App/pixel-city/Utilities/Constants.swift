//
//  Constants.swift
//  pixel-city
//
//  Created by Dwi Randy Herdinanto on 08/09/20.
//  Copyright © 2020 dwirandyh. All rights reserved.
//

import Foundation

let apiKey = "b589ca8326e5a205c258b53dd433e21c"
let secretKey = "089ae2770dec041d"

func flickrUrl(forApiKey key: String, withAnnotation annotation: DroppablePin, andNumberOfPhotos number: Int) -> String {
    return "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(key)&lat=\(annotation.coordinate.latitude)&lon=\(annotation.coordinate.longitude)&radius=1&radius_units=mi&per_page=\(number)&format=json&nojsoncallback=1"
}
