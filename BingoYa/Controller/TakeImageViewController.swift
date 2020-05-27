//
//  TakeImageViewController.swift
//  BingoYa
//
//  Created by Adrian Renaldi on 26/05/20.
//  Copyright © 2020 Adrian Renaldi. All rights reserved.
//

import UIKit

class TakeImageViewController: UIViewController {

    @IBOutlet weak var uploadedImageView: UIImageView!
    @IBOutlet weak var noDoneButton: UIButton!
    @IBOutlet weak var yesDoneButton: UIButton!
    @IBOutlet weak var taskTitleLabel: UILabel!
    
    var task: BingoTile?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initButton()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(openLibrary))
        uploadedImageView.addGestureRecognizer(gesture)
        
        if let task = task {
            taskTitleLabel.text = "\"\(task.name)\""
            if task.image != nil {
                uploadedImageView.image = task.image
            }
        } else {
            yesDoneButton.isEnabled = false
            yesDoneButton.alpha = 0.5
        }
    }
    
    func initButton() {
        noDoneButton.layer.cornerRadius = 15
        yesDoneButton.layer.cornerRadius = 15
        if uploadedImageView.image == nil {
            yesDoneButton.isEnabled = false
            yesDoneButton.alpha = 0.5
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let image = uploadedImageView.image {
            task?.image = image
        }
    }

    @IBAction func closeModal(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unfinishedTask(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: Open Camera (if available) or Photo Library
extension TakeImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func openLibrary() {
        let imagePickerCtrl = UIImagePickerController()
        imagePickerCtrl.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerCtrl.sourceType = .camera
            self.present(imagePickerCtrl, animated: true, completion: nil)
        } else {
            imagePickerCtrl.sourceType = .photoLibrary
            self.present(imagePickerCtrl, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageTaken = info[.originalImage] as? UIImage {
            picker.dismiss(animated: true) {
                self.yesDoneButton.isEnabled = true
                self.yesDoneButton.alpha = 1.0
                self.uploadedImageView.image = imageTaken
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
