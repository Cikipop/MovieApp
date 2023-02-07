//
//  SearchTabViewController.swift
//  MovieApp
//
//  Created by BURAK AKAR on 14.09.2022.
//

import Foundation
import UIKit
import Kingfisher


class SearchTabViewController: UIViewController, UITabBarControllerDelegate {
    
    @IBOutlet weak var mySearchTableView: UITableView!
    
    var searchedApi = String()
//    var searching = false
    var isSearched: Bool = false
    var upcomingMovies = [AllMovies]()
    var searchedMovies = [AllMovies]()
    let searchController = UISearchController(searchResultsController: nil)
    let parser = SearchMovie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableViewData()
        configureSearchController()
        searchedMovieList()
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchController.searchBar.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        searchController.searchBar.isHidden = false
    }
    
    
    func searchedMovieList() {
        
        parser.ParseSearchedMovie(api: Constants.upcomingMoviesUrl) {
            data in self.upcomingMovies = data
            DispatchQueue.main.async {
                self.mySearchTableView.reloadData()
            }
        }
    }
    
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
//        self.tabBarController?.navigationItem.hidesSearchBarWhenScrolling = false
        mySearchTableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.placeholder = "Movie name"
    }
    
    func tableViewData() {
        mySearchTableView.dataSource = self
        mySearchTableView.delegate = self
        mySearchTableView.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: "MyTableViewCell")
        mySearchTableView.sectionHeaderTopPadding = 0
        mySearchTableView.tableHeaderView = searchController.searchBar
    }
    deinit {
        print("search tab screen released")
    }
    
    
}

//MARK: - TableView Delegates

extension SearchTabViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearched ? searchedMovies.count : upcomingMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
        
        
        let item = isSearched ? searchedMovies[indexPath.row] : upcomingMovies[indexPath.row]
        
        cell.prepareCell(item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = isSearched ? searchedMovies[indexPath.row] : upcomingMovies[indexPath.row]
        
        let vc = storyboard?.instantiateViewController(withIdentifier:
                                                        "MovieDetailViewController") as? MovieDetailViewController
        vc?.movieId = item.id
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
}


//MARK: Search Bar Delegates

extension SearchTabViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        if searchText == "" {
            isSearched = false
            self.mySearchTableView.reloadData()
        } else {
            if searchText != "" {
                isSearched = true
                let url = "\(Constants.baseSearchUrl)\(Constants.apiKey)&language=en-US&query=\(searchText)&page=1&include_adult=false"
                let formattedUrl = url.replacingOccurrences(of: " ", with: "%20")
                
                parser.ParseSearchedMovie(api: formattedUrl) {
                    data in self.searchedMovies = data
                    
                }
                DispatchQueue.main.async {
                    self.mySearchTableView.reloadData()
                }
            }
        }
    }
}



