//
//  GhilbiMovieAPI.swift
//  MoviesFromGhibliStudioApp
//
//  Created by Elizabeth Peraza  on 12/27/18.
//  Copyright © 2018 Elizabeth Peraza . All rights reserved.
//

import Foundation



final class GhibliMovieAPI {
  static func searchGhibliMovies(keyword: String,  completionHandler: @escaping (AppError?, [GhilbiStudioMovies]?) -> Void) {
   NetworkHelper.shared.performDataTask(endpointURLString: "https://ghibliapi.herokuapp.com/\(keyword)", httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
      if let appError = appError {
        completionHandler(appError, nil)
      }
      guard let response = httpResponse,
        (200...299).contains(response.statusCode) else {
          let statusCode = httpResponse?.statusCode ?? -999
          completionHandler(AppError.badStatusCode(String(statusCode)), nil)
          return
      }
      if let data = data {
        do {
          let ghibliData = try JSONDecoder().decode([GhilbiStudioMovies].self, from: data)
          completionHandler(nil, ghibliData)
        } catch {
          completionHandler(AppError.decodingError(error), nil)
        }
      }
    }
  }
  
  
  static func getGhibliMoviesFromMockAPI(keyword: String,  completionHandler: @escaping (AppError?, [GhilbiStudioMovies]?) -> Void) {
    NetworkHelper.shared.performDataTask(endpointURLString: "http://5c33c20ce0948000147a783d.mockapi.io/GhibliMovies", httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
      if let appError = appError {
        completionHandler(appError, nil)
      }
      guard let response = httpResponse,
        (200...299).contains(response.statusCode) else {
          let statusCode = httpResponse?.statusCode ?? -999
          completionHandler(AppError.badStatusCode(String(statusCode)), nil)
          return
      }
      if let data = data {
        do {
          let ghibliData = try JSONDecoder().decode([GhilbiStudioMovies].self, from: data)
          completionHandler(nil, ghibliData)
        } catch {
          completionHandler(AppError.decodingError(error), nil)
        }
      }
    }
  }
  
  
  
  
  
  static func favoriteMovies(data: Data, completionHandler: @escaping (AppError?, Bool) -> Void) {
    NetworkHelper.shared.performUploadTask(endpointURLString: "http://5c33c20ce0948000147a783d.mockapi.io/GhibliMovies", httpMethod: "POST", httpBody: data) { (appError, data, httpResponse) in
      if let appError = appError {
        completionHandler(appError, false)
      }
      guard let response = httpResponse,
        (200...299).contains(response.statusCode) else {
          let statusCode = httpResponse?.statusCode ?? -999
          completionHandler(AppError.badStatusCode(String(statusCode)), false)
          return
      }
      if let _ = data {
        completionHandler(nil, true)
      }
    }
  }
  
  static func getFavorites(name: String, completionHandler: @escaping (AppError?, [FavoriteMovies]?) -> Void) {
    let getFavoritesEndpoint = "http://5c33c20ce0948000147a783d.mockapi.io/GhibliMovies"
    NetworkHelper.shared.performDataTask(endpointURLString: getFavoritesEndpoint, httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
      if let appError = appError {
        completionHandler(appError, nil)
      }
      guard let response = httpResponse,
        (200...299).contains(response.statusCode) else {
          let statusCode = httpResponse?.statusCode ?? -999
          completionHandler(AppError.badStatusCode(String(statusCode)), nil)
          return
      }
      if let data = data {
        do {
          let favorites = try JSONDecoder().decode([FavoriteMovies].self, from: data)
          completionHandler(nil, favorites)
        } catch {
          completionHandler(AppError.decodingError(error), nil)
        }
      }
    }
  }
  
}
