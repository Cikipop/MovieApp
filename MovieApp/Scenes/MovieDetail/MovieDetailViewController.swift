//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by BURAK AKAR on 21.10.2022.
//

import UIKit
import Kingfisher
import Cosmos
import SwiftUI

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var detailTableView: UITableView!
    
    var detailedMovie: MovieDetails?

  
    var viewModel = MovieDetailViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableViewData()
        fetchMovieDetail()
       
      
    }
    
    deinit {
        debugPrint("xxx DetailVC deinit successfully")
        ImageCache.default.memoryStorage.removeAll()
    }
    
    func fetchMovieDetail() {
        
        viewModel.getMovieDetails { errorMessage in
            if let errorMessage = errorMessage {
                
                print("\(errorMessage)")
            }
        }
        
        viewModel.getSimilarMovies { errorMessage in
            if let errorMessage = errorMessage {
                
                print("\(errorMessage)")
            }
        }
        
        viewModel.getMovieCast { errorMessage in
            if let errorMessage = errorMessage {
                
                print("\(errorMessage)")
            }
        }
        
    }
    
    
    
//    func fetchMovieDetail() {
//        let group = DispatchGroup()
//        
//        guard let viewModel = viewModel else {
//            return
//        }
//        group.enter()
//        viewModel.getMovieDetail { [weak self] data in
//            guard let self = self else { return }
//            self.detailedMovieInfo = data
//            group.leave()
//        }
//        group.enter()
//        viewModel.getCredits { [weak self] credits in
//            guard let self = self else { return }
//            self.credits = credits
//            group.leave()
//        }
//        group.enter()
//        viewModel.getSimilarMovies { [weak self] similarMovies in
//            guard let self = self else { return }
//            self.similarMovies = similarMovies
//            group.leave()
//        }
//        
//        group.notify(queue: .main) { [weak self] in
//            guard let self = self else { return }
//            self.detailTableView.reloadData()
//        }
//    }
    
    func tableViewData() {
        detailTableView.dataSource = self
        detailTableView.delegate = self
        detailTableView.register(UINib(nibName: "InfoTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoTableViewCell")
        detailTableView.register(UINib(nibName: "MovieDescriptionCell", bundle: nil), forCellReuseIdentifier: "MovieDescriptionCell")
        detailTableView.register(UINib(nibName: "CastCell", bundle: nil), forCellReuseIdentifier: "CastCell")
        detailTableView.register(UINib(nibName: "RecommendedCell", bundle: nil), forCellReuseIdentifier: "RecommendedCell")
        detailTableView.sectionHeaderTopPadding = 0
    }
    
    private func reloadDetail(with movieId: Int) {
        
        
       guard let vc = storyboard?.instantiateViewController(
               withIdentifier:"MovieDetailViewController"
           ) as? MovieDetailViewController else { return }
//        MovieDetailScreeManager.shared.movieId = movieId
        
        
       self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - TableView Delegates
extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = viewModel.detailedMovieInfo
       
        
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "InfoTableViewCell",
                for: indexPath
            ) as? InfoTableViewCell else { return UITableViewCell() }
            cell.prepareDetailCell(item)
            
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "MovieDescriptionCell",
                for: indexPath
            ) as? MovieDescriptionCell else { return UITableViewCell() }
            cell.prepareDetailCell(item)
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "CastCell",
                for: indexPath
            ) as? CastCell else { return UITableViewCell() }
            cell.credits = viewModel.credits
            
            cell.myCollectionView.reloadData()
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "RecommendedCell",
                for: indexPath
            ) as? RecommendedCell else { return UITableViewCell() }
//            cell.onTapRecommendedMovie = { [weak self] movieId in
//                self?.navigateToDetail(with: movieId)
//            }
            cell.delegate = self
            cell.recommendedMoviesArray = viewModel.similarMovies
            cell.myCollectionView.reloadData()
            return cell
        default: return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = UIScreen.main.bounds.height
        if indexPath.section == 0 {
            
            return height * 0.2
        } else { return height * 0.2 }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section
        {
        case 1:
            return "Overview"
        case 2:
            return "Characters"
        case 3:
            return "Similar Movies"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.systemFont(ofSize: 18 , weight: .bold)
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.sizeToFit()
        
    }
}
extension MovieDetailViewController: RecommendedCellDelegate {
    func onTapRecommended(id: Int) {
        reloadDetail(with: viewModel.detailedMovieInfo.id ?? 0)
        
    }
    
    
}
