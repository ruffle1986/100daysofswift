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
    
    title = "Storm Viewer"
    
    navigationController?.navigationBar.prefersLargeTitles = true
    
    let fm = FileManager.default
    let path = Bundle.main.resourcePath!
    
    if let items = try? fm.contentsOfDirectory(atPath: path) {
      for item in items {
        if item.hasPrefix("nssl") {
          pictures.append(item)
        }
      }
      pictures = pictures.sorted(by: <)
    }
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .action,
      target: self,
      action: #selector(doRecommend)
    )
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pictures.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
    cell.textLabel?.text = pictures[indexPath.row]
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let vc = storyboard?
        .instantiateViewController(withIdentifier: "Detail")
        as? DetailViewController {
      vc.selectedImage = pictures[indexPath.row]
      vc.title = "Picture of \(indexPath.row + 1) / \(pictures.count)"
      navigationController?.pushViewController(vc, animated: true)
    }
  }
  
  @objc func doRecommend() {
    let activityController = UIActivityViewController(
      activityItems: ["Check out Ruff`s awesome storm viewer app."],
      applicationActivities: []
    )
    present(activityController, animated: true)
  }
}

