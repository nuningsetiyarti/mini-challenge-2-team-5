//
//  DetailViewController.swift
//  BingoYa
//
//  Created by Adrian Renaldi on 26/05/20.
//  Copyright © 2020 Adrian Renaldi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var saveBingoButton: UIButton!
    @IBOutlet weak var bingoBoardCollectionView: UICollectionView!
    
    var dataTest = [
        "Make a cup of coffee",
        "Feed your pet",
        "Sort all clothes",
        "Pick your chores",
        "",
        "",
        "",
        "",
        ""
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        saveBingoButton.layer.cornerRadius = 15
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UINavigationController {
            if let target = destination.topViewController as? TakeImageViewController {
                target.taskTitle = sender as? String
            }
        }
    }
    
    @IBAction func saveBingo(_ sender: UIButton) {
        takeScreenShot(of: self.view)
    }
    
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataTest.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bingoCell", for: indexPath) as? BingoCollectionViewCell {
            let task = dataTest[indexPath.row]
            cell.taskLabel.text = task
            
            cell.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 10
            return cell
        }
        
        return BingoCollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: floor(self.bingoBoardCollectionView.bounds.width/3), height: floor(self.bingoBoardCollectionView.bounds.height/3))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let task = dataTest[indexPath.row]
        performSegue(withIdentifier: "takePictureSegue", sender: task)
    }
    
}

// MARK: Trigger screenshot and save it to library
extension DetailViewController {
    @objc func imageWasSaved(_ image: UIImage, error: Error?, context: UnsafeMutableRawPointer) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        UIApplication.shared.open(URL(string:"photos-redirect://")!)
    }
    
    func takeScreenShot(of view: UIView) {
        UIGraphicsBeginImageContext(CGSize(width: view.bounds.width, height: view.bounds.height))
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(screenshot, self, #selector(imageWasSaved), nil)
    }
}

