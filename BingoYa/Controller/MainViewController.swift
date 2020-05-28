//
//  MainViewController.swift
//  BingoYa
//
//  Created by Andimas Bagaswara on 28/05/20.
//  Copyright © 2020 Adrian Renaldi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var triviaCardView: UIView!
    @IBOutlet weak var boardCollectionView: UICollectionView!
    
    var boardTile: [BoardTile] = [
        BoardTile(add: true, image: #imageLiteral(resourceName: "board-cell-add")),
        BoardTile(add: false, image: #imageLiteral(resourceName: "board-cell-1"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        triviaCardView.layer.cornerRadius = 15.0
    }
    
    // MARK: Setup Onboarding Page
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "hasLaunched")
        if !launchedBefore {
            UserDefaults.standard.set(true, forKey: "hasLaunched")
            let launchStoryboard = UIStoryboard(name: "Onboarding", bundle: nil)
            let vc = launchStoryboard.instantiateViewController(identifier: "onboardingStoryboard")
            present(vc, animated: true)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boardTile.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let board = boardTile[indexPath.row]
        if board.add {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addBoardCell", for: indexPath) as? AddBoardCollectionViewCell {
                cell.addBoardImageView.image = board.image
                return cell
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "boardCell", for: indexPath) as? BoardCollectionViewCell {
                cell.boardImageView.image = board.image
                return cell
            }
        }
        
        return BoardCollectionViewCell()
    }
}
