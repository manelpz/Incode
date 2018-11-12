//
//  ViewController.swift
//  incodeTest
//
//  Created by Emmanuel Lopez Guerrero on 7/11/18.
//  Copyright © 2018 Emmanuel Lopez Guerrero. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
import AlamofireImage

class Movie {
    var Poster: String?
    var imageUrl: String?
    var imdbID: String?
    
    init(Poster: String?, imageUrl: String?, imdbID: String?) {
        self.Poster = Poster
        self.imageUrl = imageUrl
        self.imdbID = imdbID
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var Movies = [Movie]()
    var CurrentMovies = [Movie]()
    var listData: [String] = []
    let requestUrl = "https://www.omdbapi.com/?apikey=1e700da7&s=avengers&type=movie"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpImageView()
    }
    
    private func setUpSearchBar(){
      searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        guard !searchText.isEmpty else {
            CurrentMovies = Movies
            tableView.reloadData()
            return
        }
            CurrentMovies = Movies.filter({ Movie -> Bool in
            (Movie.Poster?.contains(searchText))!
        })
        self.tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexdidChange selectedScope: Int){
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        vc?.name = CurrentMovies[indexPath.row].imdbID!
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return CurrentMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell
        
        let movie: Movie
        movie = Movies[indexPath.row]
        
        cell?.titleLabel.text = movie.Poster
        
        Alamofire.request(movie.imageUrl!).responseImage { response in
            if let image = response.result.value {
                cell?.imgView.image = image
                self.tableView.reloadData()
            }
        }
        return cell!
    }
    
    func setUpImageView() {
        
        Alamofire.request(requestUrl).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                let json = dict["Search"]
                let MoviesArray : NSArray  = json as! NSArray
                
                for i in 0..<MoviesArray.count{
                    self.Movies.append(Movie(
                        Poster: (MoviesArray[i] as AnyObject).value(forKey: "Title") as? String,
                        imageUrl: (MoviesArray[i] as AnyObject).value(forKey: "Poster") as? String,
                        imdbID: (MoviesArray[i] as AnyObject).value(forKey: "imdbID") as? String
                    ))
                }
                self.CurrentMovies = self.Movies
                self.tableView.reloadData()
            }
        }//alamo
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}



















