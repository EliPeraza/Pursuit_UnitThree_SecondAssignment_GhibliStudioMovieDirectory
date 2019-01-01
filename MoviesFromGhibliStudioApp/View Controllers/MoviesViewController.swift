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
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    guard let detailedViewController = storyboard.instantiateViewController(withIdentifier: "selectedMovieDetails") as? GhilbiMovieDetailedViewController else {return}
    
    detailedViewController.modalPresentationStyle = .overCurrentContext
    detailedViewController.selectedMovieDetails = ghibliMovies[indexPath.row]
    
    present(detailedViewController, animated: true, completion: nil)
    
    print("this is the index path \(indexPath)")
    print("this is the index path \(indexPath.row)")
    
    
  }
}

extension MoviesViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    
    guard let searchText = searchBar.text else {return}
    
    ghibliMovies = ghibliMovies.filter{$0.title.lowercased().contains(searchText.lowercased())}
    
  }
  
  
}

