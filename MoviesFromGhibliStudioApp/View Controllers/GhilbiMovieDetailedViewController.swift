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


  private func showAlert(title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
    alertController.addAction(okAction)
    present(alertController, animated: true, completion: nil)
  }
  
  @IBAction func addMovieToFav(_ sender: UIBarButtonItem) {
   
   let favorite = FavoriteMovies.init(title: selectedMovieDetails.title, description: selectedMovieDetails.description, director: selectedMovieDetails.director, release_date: selectedMovieDetails.release_date ?? "Unknow", rt_score: selectedMovieDetails.rt_score)
    
    do {
      let data = try JSONEncoder().encode(favorite)
      GhibliMovieAPI.favoriteMovies(data: data) { (appError, success) in
        if let appError = appError {
          DispatchQueue.main.async {
            self.showAlert(title: "Error. Couldn't add movie to favorites", message: appError.errorMessage())
          }
        } else if success {
          DispatchQueue.main.async {
            self.showAlert(title: "Succesfully favorited movie", message: "")
          }
        } else {
          self.showAlert(title: "Was not able to favorite movie", message: "")
        }
      }
    } catch {
      print("encoding error: \(error)")
      
    }
  
  }

  
}
