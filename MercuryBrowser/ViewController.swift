//
//  ViewController.swift
//  MercuryBrowser
//
//  Created by Russell Mirabelli on 9/29/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    struct imageData: Codable{
        let name: String
        let type: String
        let url: String
    }
    
    struct imageArray: Codable {
        let mercury: [imageData]
    }
    
    @IBOutlet weak var imageTable: UITableView!
    
    let inputURL = "https://raw.githubusercontent.com/rmirabelli/mercuryserver/master/mercury.json"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let images = loadImages()!
        
        
    }
    
    func loadImages() -> imageArray? {
        var images: imageArray? = nil
        let session = URLSession(configuration: .ephemeral)
        let task = session.dataTask(with: URL(string: inputURL)!) {
            (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                images = try! decoder.decode(imageArray.self, from: data)
            }
        }
        return images
        
    }


}

