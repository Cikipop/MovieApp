//
//  DetailViewController.swift
//  MovieApp
//
//  Created by BURAK AKAR on 5.09.2022.
//

import UIKit
import Kingfisher

class MoviesTabViewController: UIViewController, UITabBarDelegate, UITabBarControllerDelegate {
    
   @IBOutlet weak var myTableView: UITableView!
    var upcomingMovies = [AllMovies]()
    var topRatedMovies = [AllMovies]()
    var nowPlayingMovies = [AllMovies]()
    
    private let viewModel = MoviesTabViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.delegate = self
        self.tabBarController?.navigationItem.hidesBackButton = true
        
        tableViewData()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {

        myTableView.setContentOffset(.zero, animated: true)
// bu tab e tekrar gelindiğinde ekran sıfırlansın diye bu şekilde ekledim
    }
    
    func tableViewData() {
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(UINib(nibName: "TopCarouselTableViewCell", bundle: nil), forCellReuseIdentifier: "TopCarouselTableViewCell")
        myTableView.register(UINib(nibName: "MidCarouselTableViewCell", bundle: nil), forCellReuseIdentifier: "MidCarouselTableViewCell")
        myTableView.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: "MyTableViewCell")
        myTableView.sectionHeaderTopPadding = 0
    }
    
    private func fetchData() {
        let group = DispatchGroup()
        
        group.enter()
        
        viewModel.fetchMovies(with: Constants.upcomingMoviesUrl) { [unowned self] upcomingMovies in
            self.upcomingMovies = upcomingMovies ?? []
        }
        
        viewModel.fetchMovies(with: Constants.nowplayingMoviesUrl) { [weak self] movies in
            guard let movies = movies else { return }
            self?.nowPlayingMovies = movies
            debugPrint("xxx now playing count: ", movies.count)
            group.leave()
        }
        group.enter()
        viewModel.fetchMovies(with: Constants.topRatedMoviesUrl) { [weak self] movies in
            guard let movies = movies else { return }
            self?.topRatedMovies = movies
            group.leave()
        }
        group.enter()
        viewModel.fetchMovies(with: Constants.upcomingMoviesUrl) { [weak self] movies in
            guard let movies = movies else { return }
            self?.upcomingMovies = movies
            group.leave()
        }
        group.notify(queue: .main) { [weak self] in
            self?.myTableView.reloadData()
        }
    }
    
    private func navigateToDetail(with movieId: Int) {
        guard let vc = storyboard?.instantiateViewController(
                withIdentifier:"MovieDetailViewController"
            ) as? MovieDetailViewController else { return }
        vc.viewModel = MovieDetailViewModel(movieId: movieId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//MARK: - TableView Delegates
extension MoviesTabViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 2 {
            return upcomingMovies.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TopCarouselTableViewCell", for: indexPath) as? TopCarouselTableViewCell else { return UITableViewCell() }
            cell.nowPlayingMovies = nowPlayingMovies
            cell.onTapNowPlayingMovie = { [weak self] movieId in
                self?.navigateToDetail(with: movieId)
            }
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MidCarouselTableViewCell", for: indexPath) as? MidCarouselTableViewCell else { return UITableViewCell() }
            cell.topRatedMovies = topRatedMovies
            cell.onTapTopRatedMovie = { [weak self] movieId in
                self?.navigateToDetail(with: movieId)
            }
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as? MyTableViewCell else { return UITableViewCell() }
            let item = upcomingMovies[indexPath.row]
            cell.prepareCell(item)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = upcomingMovies[indexPath.row]
        navigateToDetail(with: item.id ?? 0)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 350 } else { return 250 }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 { return "Now Playing"}
        else if section == 1 {
            return "Top Rated"
        } else { return "Upcoming"}
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        header.textLabel?.textColor = UIColor.black
    }
}






