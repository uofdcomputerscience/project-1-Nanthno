//
//  ViewController.swift
//  MercuryBrowser
//
//  Created by Anthony Hanson on 10/7/19.
//  Copyright © 2019 Anthony Hanson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        ImageTools.loadMercuries(completion: mercuriesLoaded(merc:))
        
    }
    
    
    func mercuriesLoaded(merc: [Mercury]) {
        ImageTools.mercuries = merc
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ImageTools.mercuries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mercury = ImageTools.mercuries[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell")!
        if let imgCell = cell as? ImageCell {
            ImageTools.fetchImage(url: mercury.url, completion: imgCell.setImage(img:))
            imgCell.nameLabel.text = mercury.name
            imgCell.typeLabel.text = mercury.type
        }
        
        return cell
        
        
    }
}

