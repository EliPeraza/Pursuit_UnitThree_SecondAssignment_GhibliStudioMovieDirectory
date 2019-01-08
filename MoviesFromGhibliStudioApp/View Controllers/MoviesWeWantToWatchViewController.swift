//
//  MoviesWeWantToWatchViewController.swift
//  MoviesFromGhibliStudioApp
//
//  Created by Elizabeth Peraza  on 1/6/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import UIKit

class MoviesWeWantToWatchViewController: UIViewController {
  
  
  

  @IBOutlet weak var moviesToWatchTableView: UITableView!
  
  
  
  var arrayOfFavorites = [FavoriteMovies]() {
    didSet{
      DispatchQueue.main.async {
        self.moviesToWatchTableView.reloadData()
      }
    }
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    moviesToWatchTableView.dataSource = self
    moviesToWatchTableView.delegate = self
    title = "Favorite Movies"
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    fetchFavorites()
  }
  
  private func fetchFavorites(){
    guard let encodeName = Constants.Name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
      return
    }
    
    GhibliMovieAPI.getFavorites(name: encodeName) { (appError, favorites) in
      if let appError = appError {
        print(appError.errorMessage())
      } else if let favorites = favorites {
        self.arrayOfFavorites = favorites
        dump("This is a favorite \(self.arrayOfFavorites)")
      }
    }
  }
  
}

extension MoviesWeWantToWatchViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return arrayOfFavorites.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = moviesToWatchTableView.dequeueReusableCell(withIdentifier: "moviesToWatch", for: indexPath) as? MoviesToWatchTableViewCell else {return UITableViewCell()}
    
    let favoriteMovie = arrayOfFavorites[indexPath.row]
    
    cell.favImage.image = ImageSetter.setPicture(str: favoriteMovie.title)
    
    
    return cell
  }
  
}

extension MoviesWeWantToWatchViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 250
    
  }
}

