//
//  DetailViewController.swift
//  Project1
//
//  Created by Tamas Fodor on 2019. 03. 10..
//  Copyright © 2019. tfodor. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  @IBOutlet var imageView: UIImageView!
  
  var selectedImage: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.largeTitleDisplayMode = .never
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .action,
      target: self,
      action: #selector(shareTapped)
    )
    
    if let imageToLoad = selectedImage {
      imageView.image = UIImage(named: imageToLoad)
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.hidesBarsOnTap = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.hidesBarsOnTap = false
  }
  
  @objc func shareTapped() {
    
    guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
      return
    }
    
    let vc = UIActivityViewController(
      activityItems: [image, selectedImage as Any],
      applicationActivities: []
    )
    vc.popoverPresentationController?.barButtonItem =
      navigationItem.rightBarButtonItem
    present(vc, animated: true)
  }
}
