//
//  RewardViewController.swift
//  BingoYa
//
//  Created by Andimas Bagaswara on 29/05/20.
//  Copyright © 2020 Adrian Renaldi. All rights reserved.
//

import UIKit

class RewardViewController: UIViewController {
    
    var rewardRow: [RewardRow] = [
        RewardRow(image: #imageLiteral(resourceName: "color3-greenGrey"), title: "Grey/Green", description: "Earn 1 Bingo", progress: 1.0),
        RewardRow(image: #imageLiteral(resourceName: "color4-pinkMint"), title: "Pink/Green", description: "Earn 4 Bingo", progress: 0.25),
        RewardRow(image: #imageLiteral(resourceName: "category-movie"), title: "Movie", description: "Earn 10 Bingo", progress: 0.1),
        RewardRow(image: #imageLiteral(resourceName: "bingo"), title: "Social", description: "Share to Instagram", progress: 0.0)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backToMain(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
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

extension RewardViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return rewardRow.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reward = rewardRow[indexPath.section]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "rewardRowCell", for: indexPath) as? RewardTableViewCell {
            cell.rewardImage.image = reward.image
            cell.rewardTitle.text = reward.title
            cell.rewardDescription.text = reward.description
            cell.progressBar.progress = reward.progress
            if reward.progress == 1.0 {
                cell.markImage.image = #imageLiteral(resourceName: "logo-checklistReward")
            } else {
                cell.markImage.image = .none
            }
            cell.backgroundColor = .clear
            return cell
        }
        return RewardTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
