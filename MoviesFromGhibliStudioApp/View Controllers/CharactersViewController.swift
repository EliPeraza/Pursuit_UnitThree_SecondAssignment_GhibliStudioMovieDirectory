//
//  CharactersViewController.swift
//  MoviesFromGhibliStudioApp
//
//  Created by Elizabeth Peraza  on 12/27/18.
//  Copyright © 2018 Elizabeth Peraza . All rights reserved.
//

import UIKit

class CharactersViewController: UIViewController {

  
  @IBOutlet weak var characterSeachBar: UISearchBar!
  
  @IBOutlet weak var characterTableView: UITableView!
  
  private var ghibliCharacters = [GhilbiStudioCharacters]() {
    didSet{
      characterTableView.reloadData()
    }
  }
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      getCharacterInfo()
      dump(ghibliCharacters)
      characterTableView.dataSource = self
//      characterSeachBar.delegate = self
    }
    

  func getCharacterInfo(){
    GhibliCharacterAPI.getCharacterInfo(keyword: "people") { (error, data) in
      DispatchQueue.main.async{
        if let error = error {
          print(error)
        }
        if let data = data {
          self.ghibliCharacters = data
        }
      }
    }
  }
  

}

extension CharactersViewController: UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ghibliCharacters.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = characterTableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath)
    
    let currentCharacter = ghibliCharacters[indexPath.row]
    
    cell.textLabel?.text = currentCharacter.name
    cell.detailTextLabel?.text = currentCharacter.age
    
    return cell
    
    
  }
  
}

//
//extension CharactersViewController: UISearchBarDelegate {
//
//  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//    searchBar.resignFirstResponder()
//
//    guard let searchText = searchBar.text else {return}
//
//
//
//
//}

//}
