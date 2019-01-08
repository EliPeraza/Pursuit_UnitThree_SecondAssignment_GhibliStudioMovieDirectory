//
//  MoviesWeWantToWatchViewController.swift
//  MoviesFromGhibliStudioApp
//
//  Created by Elizabeth Peraza  on 1/6/19.
//  Copyright © 2019 Elizabeth Peraza . All rights reserved.
//

import UIKit

class MoviesWeWantToWatchViewController: UIViewController {

  var arrayOfFavorites = [GhilbiStudioMovies]()
  
  @IBOutlet weak var moviesToWatchTableView: UITableView!
  
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

      moviesToWatchTableView.dataSource = self
    }
  
  

}

extension MoviesWeWantToWatchViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return arrayOfFavorites.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     guard let cell = moviesToWatchTableView.dequeueReusableCell(withIdentifier: "moviesToWatch", for: indexPath) as? MoviesToWatchTableViewCell else {return UITableViewCell()}
    
    let currentMovie = arrayOfFavorites[indexPath.row]
    
    cell.favMovieName.text = currentMovie.title

    return cell
  }
  
}
