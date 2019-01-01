//
//  GhilbiCharacterAPI.swift
//  MoviesFromGhibliStudioApp
//
//  Created by Elizabeth Peraza  on 12/27/18.
//  Copyright © 2018 Elizabeth Peraza . All rights reserved.
//

import Foundation

final class GhibliCharacterAPI {
  
  static func getCharacterInfo(keyword: String, completionHandler: @escaping (AppError?, [GhilbiStudioCharacters]?) -> Void) {
    let urlString = "https://ghibliapi.herokuapp.com/\(keyword)"
    
    guard let url = URL(string: urlString) else {
      completionHandler(AppError.badURL("URL is not well formatted"), nil)
      return
    }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let error = error {
        completionHandler(AppError.networkError(error), nil)
      } else if let data = data {
        do {
          let searchData = try JSONDecoder().decode([GhilbiStudioCharacters].self, from: data)
          completionHandler(nil, searchData)
        } catch {
          completionHandler(AppError.decodingError(error), nil)
        }
      }
      
      } .resume()
    
    
  }
  
}
