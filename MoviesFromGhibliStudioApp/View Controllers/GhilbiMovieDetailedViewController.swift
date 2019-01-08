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
  
  var favoriteMoviesVC = UIViewController()
  
  @IBOutlet weak var imageDetailed: UIImageView!
  
  @IBOutlet weak var director: UILabel!
  
  
  @IBOutlet weak var releaseDate: UILabel!
  
  @IBOutlet weak var movieDescription: UITextView!
  
  
  @IBOutlet weak var addButton: UIBarButtonItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = selectedMovieDetails.title
    setDataInDetailedMovieController()
    dump(selectedMovieDetails)
   
  }
  
  func setDataInDetailedMovieController(){
    if let movieDesc = selectedMovieDetails {
      movieDescription.text = movieDesc.description
    } else {
      movieDescription.text = "nothing nothing"
    }
    
    director.text = "Director: \(selectedMovieDetails.director) "
    
    imageDetailed.image = ImageSetter.setPicture(str: selectedMovieDetails.title)
    
    if let date = selectedMovieDetails.release_date{
    releaseDate.text = "Release year: \(date)"
      
    } else {
      releaseDate.text = "Release year: unknown"
    }
    
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let favVC = segue.destination as? MoviesWeWantToWatchViewController {
      favoriteMoviesVC = favVC
      
    } else {
     print("Can't segue")
    }
    
  }
  
  
  @IBAction func addMovieToFav(_ sender: UIBarButtonItem) {
   
    if sender.isEnabled {
     GhilbiStudioMovies.getFavorites(movie: selectedMovieDetails)
    }
  
  }

  
}
