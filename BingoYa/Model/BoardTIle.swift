//
//  BoardTIle.swift
//  BingoYa
//
//  Created by Andimas Bagaswara on 28/05/20.
//  Copyright © 2020 Adrian Renaldi. All rights reserved.
//

import UIKit

class BoardTile {
    var add: Bool
    var image: UIImage?
    
    init(add: Bool, image: UIImage?) {
        self.add = add
        self.image = image
    }
}
