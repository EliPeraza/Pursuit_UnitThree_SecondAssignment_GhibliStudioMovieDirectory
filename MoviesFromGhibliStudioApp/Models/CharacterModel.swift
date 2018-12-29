//
//  CharacterModel.swift
//  MoviesFromGhibliStudioApp
//
//  Created by Elizabeth Peraza  on 12/27/18.
//  Copyright © 2018 Elizabeth Peraza . All rights reserved.
//

import Foundation

//this is an array of dictionaries
struct GhilbiStudioCharacters: Codable {

  struct CharacterInfo: Codable {
    let arrayOfCharacters: [GhilbiStudioCharacters]
  }
  
  let name: String
  let gender: String
  let age: String
  let species: String
  
}
