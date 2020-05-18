//
//  ViewController.swift
//  BingoYa
//
//  Created by Adrian Renaldi on 18/05/20.
//  Copyright © 2020 Adrian Renaldi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    
}

