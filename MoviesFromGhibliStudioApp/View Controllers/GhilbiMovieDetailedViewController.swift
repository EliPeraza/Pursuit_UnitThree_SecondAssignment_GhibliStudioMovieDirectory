//
//  GhilbiMovieDetailedViewController.swift
//  MoviesFromGhibliStudioApp
//
//  Created by Elizabeth Peraza  on 12/28/18.
//  Copyright © 2018 Elizabeth Peraza . All rights reserved.
//

import UIKit

class GhilbiMovieDetailedViewController: UIViewController {
  
  var selectedMovieDetails: GhilbiStudioMovies!
  
  @IBOutlet weak var backgroundButton: UIButton!
  
  @IBOutlet weak var imageDetailed: UIImageView!
  
  @IBOutlet weak var directorAndDate: UILabel!
  
  @IBOutlet weak var movieDescription: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setDetailedInfo()
    
  }
  
  func setDetailedInfo(){
 
  }
  
  
  @IBAction func dismissButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  
  
}
