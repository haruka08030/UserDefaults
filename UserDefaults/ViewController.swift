//
//  ViewController.swift
//  UserDefaults
//
//  Created by 杉山遥 on 2020/03/15.
//  Copyright © 2020 杉山遥. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    let defaults = UserDefaults.standard
    var saveArray: Array! = [NSData]()
    var image: UIImage!
    
    
    func sendSaveImage() {
        let data = image.pngData() as NSData?
        if let imageData = data {
            saveArray.append(imageData)
            
            defaults.set(saveArray, forKey: "saveImage")
            defaults.synchronize()
        }
    }
    
    
    func defaultsArray() {
        if defaults.object(forKey: "saveImage") != nil {
            let objects = defaults.object(forKey: "saveImage") as? NSArray
            saveArray.removeAll()
            for data in objects! {
                saveArray.append(data as! NSData)
            }
        }
        tableView.reloadData()
    }

    
    func tableView(_ tableView: UITableView, collForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
    
        cell.cellImageView.image = UIImage(data: saveArray[indexPath.row] as Data)
        cell.cellImageView.frame = CGRect(x: 0, Y: 1, width: cell.bounds.size.height - 2, height: cell.bounds.size.height - 2)
        cell.cellImageView.contentMode = .scaleAspectFill
        cell.cellImageView.clipsToBounds = true
    
        return cell
        
    }
}
