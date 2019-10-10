//
//  ViewController.swift
//  MercuryBrowser
//
//  Created by Anthony Hanson on 10/7/19.
//  Copyright © 2019 Anthony Hanson. All rights reserved.
//

/* things needing to be done:
 * make images not scale randomly and weirdly
 * add the other info (probably by adding labels to the table cell)
*/
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ImageManager.mercuryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mercury = ImageManager.mercuryList[indexPath.item]
        let image = ImageManager.getImage(imageURL: mercury.url)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell")!
        if let imgCell = cell as? ImageCell {
            imgCell.imageView!.image = image
            imgCell.nameLabel.text = mercury.name
            imgCell.typeLabel.text = mercury.type
        }
        
        return cell
        
        
    }
}

