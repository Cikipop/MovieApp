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
//    public var movieId: Int?

//   var delegate: MovieIdDelegate?
    private let viewModel = MoviesTabViewModel()
    
    
//    let detailViewModel = MovieDetailViewModel(movieIdaa: MovieDetailViewModel.shared.movieIdaa)
    override func viewDidLoad() {
        super.viewDidLoad()
//        MoviesTabViewController.delegate = self
        self.tabBarController?.delegate = self
        self.tabBarController?.navigationItem.hidesBackButton = true
        
        tableViewData()
        fetchData()
    }
    
    deinit {
        debugPrint("xxx MoviesTabVc deinit successfully")
        ImageCache.default.memoryStorage.removeAll()
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
        
        viewModel.getNowPlayingMovies { errorMessage in
            if let errorMessage = errorMessage {
                
                print("\(errorMessage)")
            }
        }
        
        viewModel.getTopRatedMovies { errorMessage in
            if let errorMessage = errorMessage {
                
                print("\(errorMessage)")
            }
        }
        
        viewModel.getUpcomingMovies { errorMessage in
            if let errorMessage = errorMessage {
                
                print("\(errorMessage)")
            }
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (segue.identifier == "detailSegue") {
//            let vc = segue.destination as? MovieDetailViewController
//            vc?.delegate = self
//
//
//        }
//    }
    
    
    private func navigateToDetail(with movieId: Int) {

        guard let vc = self.storyboard?.instantiateViewController(
            withIdentifier:"MovieDetailViewController"
        ) as? MovieDetailViewController else { return }
//
//        delegate?.passMovieId(id: movieId)
        vc.viewModel.movieId = movieId
       print("yoyo \(movieId)")






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
            return viewModel.upcomingMovies.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TopCarouselTableViewCell", for: indexPath) as? TopCarouselTableViewCell else { return UITableViewCell() }
            cell.nowPlayingMovies = viewModel.nowPlayingMovies
            cell.onTapNowPlayingMovie = { [weak self] movieId in
                self?.navigateToDetail(with: movieId)
            }
            cell.myCollectionView.reloadData()
            
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MidCarouselTableViewCell", for: indexPath) as? MidCarouselTableViewCell else { return UITableViewCell() }
            cell.topRatedMovies = viewModel.topRatedMovies
            cell.onTapTopRatedMovie = { [weak self] movieId in
                self?.navigateToDetail(with: movieId)
            }
            cell.myCollectionView.reloadData()
            
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as? MyTableViewCell else { return UITableViewCell() }
            let item = viewModel.upcomingMovies[indexPath.row]
            cell.prepareCell(item)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.upcomingMovies[indexPath.row]
        
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



    


    



