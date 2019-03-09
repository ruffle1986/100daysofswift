//
//  ViewController.swift
//  Project1
//
//  Created by Tamas Fodor on 2019. 03. 09..
//  Copyright © 2019. tfodor. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

  var pictures = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let fm = FileManager.default
    let path = Bundle.main.resourcePath!
    
    if let items = try? fm.contentsOfDirectory(atPath: path) {
      for item in items {
        if item.hasPrefix("nssl") {
          pictures.append(item)
        }
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pictures.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
    cell.textLabel?.text = pictures[indexPath.row]
    return cell
  }
}
