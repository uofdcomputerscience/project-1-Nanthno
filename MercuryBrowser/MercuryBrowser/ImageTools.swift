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
    
    private static var _mercuries: [Mercury] = []
    
    static var mercuries: [Mercury] {
        get {
            return _mercuries
        }
        set {
            _mercuries = newValue
        }
    }
    
    static var urlToImage: [String: UIImage] = [:]
    
    static let mercuryURL = "https://raw.githubusercontent.com/rmirabelli/mercuryserver/master/mercury.json"
    
    
    static func loadMercuries(completion: @escaping (([Mercury]) -> Void)) {
        
        print("loading URLs")
        
        let session = URLSession(configuration: .ephemeral)
        let task = session.dataTask(with: URL(string: mercuryURL)!) {
            (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                let mercuryList = try! decoder.decode(MercuryList.self, from: data)
                completion(mercuryList.mercury)
            }
        }
        
        task.resume()
    }
    
    static func fetchImage(url: String, completion: @escaping ((UIImage) -> Void)) {
        if let img = urlToImage[url] {
            completion(img)
            return
        }
        
        let session = URLSession(configuration: .ephemeral)
        let task = session.dataTask(with: URL(string: url)!) {
            (data, response, error) in
            if let data = data {
                if let img = UIImage(data: data) {
                    print("loading image from web at \(url)")
                    completion(img)
                    urlToImage[url] = img
                }
            }
        }
        task.resume()
    }
}
