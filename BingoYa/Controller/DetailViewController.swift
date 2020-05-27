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
    
    var bingoTile: [BingoTile] = [
        BingoTile(name: "Make a cup of coffee", image: nil),
        BingoTile(name: "Feed your pet", image: nil),
        BingoTile(name: "Sort all clothers", image: nil),
        BingoTile(name: "Pick your chores", image: nil),
        BingoTile(name: "Do 30x push-ups", image: nil),
        BingoTile(name: "Watch all Harry Potter series", image: nil),
        BingoTile(name: "Clean the dishes", image: nil),
        BingoTile(name: "Plank for 1 minute", image: nil),
        BingoTile(name: "Do the laundry", image: nil)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        saveBingoButton.layer.cornerRadius = 15
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UINavigationController {
            if let target = destination.topViewController as? TakeImageViewController {
                target.task = sender as? BingoTile
            }
            if let target = destination.topViewController as? ShareBingoViewController {
                target.screenshotImage = sender as? UIImage
            }
        }
    }
    
    @IBAction func saveBingo(_ sender: UIButton) {
        takeScreenShot(of: bingoBoardCollectionView)
    }
    
    @IBAction func taskDone(_ unwindSegue: UIStoryboardSegue) {
        guard let takeImageCtrl = unwindSegue.source as? TakeImageViewController else { return }
        if let data = takeImageCtrl.task {
            bingoTile.filter { (tile) -> Bool in
                tile.name == data.name
            }.first?.image = data.image
            bingoBoardCollectionView.reloadData()
        }
    }
    
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bingoTile.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bingoCell", for: indexPath) as? BingoCollectionViewCell {
            let task = bingoTile[indexPath.row]
            cell.taskLabel.text = task.name
            if task.image != nil {
                cell.taskImageView.image = task.image
            } else {
                cell.taskImageView.image = UIImage()
            }
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
        let task = bingoTile[indexPath.row]
        performSegue(withIdentifier: "takePictureSegue", sender: task)
    }
    
}

// MARK: Trigger screenshot and save it to library
extension DetailViewController {
    func takeScreenShot(of view: UIView) {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: view.bounds.width, height: view.bounds.height), false, 2)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        performSegue(withIdentifier: "shareScreenshotSegue", sender: screenshot)
    }
}
