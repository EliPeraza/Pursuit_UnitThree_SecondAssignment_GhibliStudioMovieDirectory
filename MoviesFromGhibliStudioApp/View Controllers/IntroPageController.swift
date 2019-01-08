//
//  IntroPageController.swift
//  MoviesFromGhibliStudioApp
//
//  Created by Elizabeth Peraza  on 1/7/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import UIKit

class IntroPageController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      perform(#selector(showNavigation), with: nil, afterDelay: 3)
    }
    
  @objc func showNavigation() {
    performSegue(withIdentifier: "showNavigation", sender: self)
  }

}
