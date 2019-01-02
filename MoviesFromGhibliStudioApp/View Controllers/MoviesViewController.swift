//
//  MoviesViewController.swift
//  MoviesFromGhibliStudioApp
//
//  Created by Elizabeth Peraza  on 12/27/18.
//  Copyright © 2018 Elizabeth Peraza . All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
  
  
  @IBOutlet weak var searchBar: UISearchBar!
  
  @IBOutlet weak var movieTableView: UITableView!
  
  
  private var ghibliMovies = [GhilbiStudioMovies]() {
    didSet{
      self.movieTableView.reloadData()
    }
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    movieTableView.dataSource = self
    movieTableView.delegate = self 
    searchBar.delegate = self
    getMovieData()
    dump(ghibliMovies)
    
  }
  
  func getMovieData() {
    GhilbiMovieAPI.getMovieInfo(keyword: "films") { (error, data) in
      DispatchQueue.main.async {
        if let error = error {
          print(error)
        }
        if let data = data {
          self.ghibliMovies = data
        }
      }
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let indexPath = movieTableView.indexPathForSelectedRow,
      let detailedVC = segue.destination as? GhilbiMovieDetailedViewController else {fatalError("There is a problem with the segue indexPath or segue")}
    
    let currentMovie = ghibliMovies[indexPath.row]
    detailedVC.selectedMovieDetails = currentMovie
  }
  
  
}

extension MoviesViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ghibliMovies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = movieTableView.dequeueReusableCell(withIdentifier: "moviesCustomCell", for: indexPath) as? MoviesCustomCell else {return UITableViewCell()}
    
    let currentMovie = ghibliMovies[indexPath.row]
    cell.movieTitle.text = currentMovie.title
    
    cell.movieImage.image = ImageSetter.setPicture(str: currentMovie.title)
    
    return cell
  }
  
}

extension MoviesViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 150
  }
  
}

extension MoviesViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    
    guard let searchText = searchBar.text else {return}
    
//    var backupGhibliMovie = ghibliMovies
    
    if searchText == "" {
      _ = getMovieData()
      movieTableView.reloadData()
    } else {
     ghibliMovies = ghibliMovies.filter{$0.title.lowercased().contains(searchText.lowercased())}
    }
      
   
  }
  
  
  
}

