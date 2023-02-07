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
    
    let parser = MoviesViewModel()
  
    
    var upcomingMovies = [AllMovies]()
    var topRatedMovies = [AllMovies]()
    var nowPlayingMovies = [AllMovies]()
    //    var movieDetails: MovieDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.tabBarController?.delegate = self
        tableViewData()
        self.tabBarController?.navigationItem.hidesBackButton = true
        getMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {

        myTableView.setContentOffset(.zero, animated: true)
// bu tab e tekrar gelindiğinde ekran sıfırlansın diye bu şekilde ekledim
    }
    
    func getMovies() {
        
        parser.ParseMovies(api: Constants.upcomingMoviesUrl) {
            data in self.upcomingMovies = data
            DispatchQueue.main.async {
                           self.myTableView.reloadData()
                       }
        }
        
        parser.ParseMovies(api: Constants.nowplayingMoviesUrl) {
            data in self.nowPlayingMovies = data
        }
        
        parser.ParseMovies(api: Constants.topRatedMoviesUrl) {
            data in self.topRatedMovies = data
        }
    }
    
   func tableViewData() {
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(UINib(nibName: "TopCarouselTableViewCell", bundle: nil), forCellReuseIdentifier: "TopCarouselTableViewCell")
        myTableView.register(UINib(nibName: "MidCarouselTableViewCell", bundle: nil), forCellReuseIdentifier: "MidCarouselTableViewCell")
        myTableView.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: "MyTableViewCell")
        myTableView.sectionHeaderTopPadding = 0
    }
    
    deinit {
        print("movies tab screen released")
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
        } else { return 1 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 { let cell = tableView.dequeueReusableCell(withIdentifier: "TopCarouselTableViewCell", for: indexPath) as! TopCarouselTableViewCell
            
            cell.delegate = self // protocol delegate
            cell.nowPlaying = nowPlayingMovies
            cell.myCollectionView.reloadData()
            return cell
        
        } else if indexPath.section == 1 { let cell = tableView.dequeueReusableCell(withIdentifier: "MidCarouselTableViewCell", for: indexPath) as! MidCarouselTableViewCell
            
            cell.delegate = self // protocol için delegate
            cell.topRated = topRatedMovies
            cell.myCollectionView.reloadData()
            return cell
            
        } else { let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
            
            let item = upcomingMovies[indexPath.row]
            cell.prepareCell(item)
            return cell}
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = upcomingMovies[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier:
                                                        "MovieDetailViewController") as? MovieDetailViewController
        vc?.movieId = item.id
        self.navigationController?.pushViewController(vc!, animated: true)
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

//MARK: - DetailViewController Protocol
extension MoviesTabViewController: CarouselTableViewCellDelegate {
    
    func CellDidSelect(id: Int) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController
        vc?.movieId = id
        self.navigationController?.pushViewController(vc ?? MovieDetailViewController(), animated: true)
        
    }
}






