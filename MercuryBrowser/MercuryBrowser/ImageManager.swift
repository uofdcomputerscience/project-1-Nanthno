//
//  ImageManager.swift
//  MercuryBrowser
//
//  Created by Anthony Hanson on 10/7/19.
//  Copyright © 2019 Anthony Hanson. All rights reserved.
//

import UIKit

class ImageManager {
    static let mercuries: [Mercury] = ImageTools.loadMercuries()!
    
    static var urlToImage: [String: UIImage] = [:]
    static let mercuryList = ImageTools.loadMercuries()!
    
    static func getImage(imageURL: String) -> UIImage {
        if let img = urlToImage[imageURL] {
            return img
        }
        
        let img = ImageTools.loadImageFromURL(imageURL: imageURL)
        urlToImage[imageURL] = img
        
        return img
    }
    
    
}
