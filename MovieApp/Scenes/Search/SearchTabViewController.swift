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
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewData()
        configureSearchController()
        
        viewModel.getMovies { errorMessage in
            if let errorMessage = errorMessage {
                
                print("\(errorMessage)")
            }
            DispatchQueue.main.async {
                self.mySearchTableView.reloadData()
            }
        
        
//        viewModel.fetchMovies { [weak self] _ in
//            self?.reloadTableView()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchController.searchBar.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        searchController.searchBar.isHidden = false
    }
    
    func configureSearchController() {
//        searchController.searchResultsUpdater = self
//        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        self.tabBarController?.navigationItem.hidesSearchBarWhenScrolling = false
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
    
    private func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.mySearchTableView.reloadData()
        }
    }
}

//MARK: - TableView Delegates

extension SearchTabViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.isSearched ?
        viewModel.searchedMovies.count
        : viewModel.upcomingMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as? MyTableViewCell else { return UITableViewCell() }
        
        let item = viewModel.isSearched ?
        viewModel.searchedMovies[indexPath.row]
        : viewModel.upcomingMovies[indexPath.row]
        
        cell.prepareCell(item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = viewModel.isSearched ?
        viewModel.searchedMovies[indexPath.row]
        : viewModel.upcomingMovies[indexPath.row]
        
        guard let vc = storyboard?.instantiateViewController(
            withIdentifier: "MovieDetailViewController"
        ) as? MovieDetailViewController else { return }
//        MovieDetailScreeManager.shared.movieId = item.id ?? 0
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}

//MARK: Search Bar Delegates

//extension SearchTabViewController: UISearchBarDelegate, UISearchResultsUpdating {
//
//    func updateSearchResults(for searchController: UISearchController) {
//        guard let searchText = searchController.searchBar.text else {
//            viewModel.fetchMovies { [weak self] _ in
//                self?.reloadTableView()
//            }
//            return
//        }
//        viewModel.fetchMovies(with: searchText) { [weak self] searchedMovies in
//            self?.reloadTableView()
//        }
//    }
//}



