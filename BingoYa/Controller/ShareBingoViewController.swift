//
//  ShareBingoViewController.swift
//  BingoYa
//
//  Created by Adrian Renaldi on 27/05/20.
//  Copyright © 2020 Adrian Renaldi. All rights reserved.
//

import UIKit

class ShareBingoViewController: UIViewController {

    @IBOutlet weak var screenshotImageView: UIImageView!
    @IBOutlet weak var shareToInstagramButton: UIButton!
    @IBOutlet weak var saveToGalleryButton: UIButton!
    
    var screenshotImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initButton()
        
        if let image = screenshotImage {
            screenshotImageView.image = image
        }
    }
    
    func initButton() {
        shareToInstagramButton.layer.cornerRadius = 15
        saveToGalleryButton.layer.cornerRadius = 15
    }
    
    @objc func imageWasSaved(_ image: UIImage, error: Error?, context: UnsafeMutableRawPointer) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        UIApplication.shared.open(URL(string:"photos-redirect://")!)
    }
    
    @IBAction func closeModal(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveScreenshot(_ sender: UIButton) {
        if let image = screenshotImage {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageWasSaved), nil)
        }
    }
    
}
