//
//  ImageManager.swift
//  MercuryBrowser
//
//  Created by Anthony Hanson on 10/7/19.
//  Copyright © 2019 Anthony Hanson. All rights reserved.
//

import UIKit

class ImageTools {
    
    struct MercuryList: Codable {
        let mercury: [Mercury]
    }
    
    static let mercuryURL = "https://raw.githubusercontent.com/rmirabelli/mercuryserver/master/mercury.json"
    
    
    static func loadMercuries() -> [Mercury]? {
        
        print("loading URLs")
        
        var mercuries: [Mercury]? = nil
        
        let session = URLSession(configuration: .ephemeral)
        let semaphore = DispatchSemaphore(value: 0)
        let task = session.dataTask(with: URL(string: mercuryURL)!) {
            (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                let mercuryList = try! decoder.decode(MercuryList.self, from: data)
                mercuries = mercuryList.mercury
            }
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait() // wait until task is complete
        
        return mercuries
        
    }
    
    static func loadImageFromURL(imageURL: String) -> UIImage {
        var img: UIImage? = nil
        let session = URLSession(configuration: .ephemeral)
        let semaphore = DispatchSemaphore(value: 0)
        let task = session.dataTask(with: URL(string: imageURL)!) {
            (data, response, error) in
            if let data = data {
                img = UIImage(data: data)
            }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
        
        return img!
    }
}

