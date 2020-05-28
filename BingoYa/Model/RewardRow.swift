//
//  RewardRow.swift
//  BingoYa
//
//  Created by Andimas Bagaswara on 29/05/20.
//  Copyright © 2020 Adrian Renaldi. All rights reserved.
//

import UIKit

class RewardRow {
    var image: UIImage?
    var title: String
    var description: String
    var progress: Float
    
    init(image: UIImage?, title: String, description: String, progress: Float) {
        self.image = image
        self.title = title
        self.description = description
        self.progress = progress
    }
}
