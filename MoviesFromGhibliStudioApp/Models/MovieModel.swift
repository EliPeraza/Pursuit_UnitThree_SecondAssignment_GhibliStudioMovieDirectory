//
//  MovieModel.swift
//  MoviesFromGhibliStudioApp
//
//  Created by Elizabeth Peraza  on 12/27/18.
//  Copyright © 2018 Elizabeth Peraza . All rights reserved.
//

import Foundation

//this data is an array of dictionaries
struct GhilbiStudioMovies: Codable {
  
  
  let title: String
  let description: String
  let director: String
  let release_date: String?
  let rt_score: String 
  
  
  static public func getFavorites(movie: GhilbiStudioMovies) -> [GhilbiStudioMovies] {
    var arrayOfFavorites = [GhilbiStudioMovies]()
    
    arrayOfFavorites.append(movie)
    
    return arrayOfFavorites
  }
}



