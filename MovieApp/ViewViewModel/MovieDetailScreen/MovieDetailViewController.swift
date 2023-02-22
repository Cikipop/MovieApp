//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by BURAK AKAR on 21.10.2022.
//

import UIKit
import Kingfisher
import Cosmos

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var detailTableView: UITableView!
    
    let parser = MovieDetailScreen()
    var cosmosView: CosmosView!
    var detailedMovieInfo: MovieDetails?
    var movieId = Int()
    var recommendedMovies = [AllMovies]()
    var cast = [AllCast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewData()
        parseMovieDetail()
        parseCast()
        parseRecommendedMovies()
    }
    
    deinit {
        print("detail screen released")
    }
    
    func parseMovieDetail() {
        
        let url = "\(Constants.baseUrl)\(movieId)\(Constants.apiKey)"
        
        parser.ParseMovieDetail(api: url) {
            data in self.detailedMovieInfo = data
            DispatchQueue.main.async {
                self.detailTableView.reloadData()
            }
        }
    }
    
    func parseRecommendedMovies() {
        
        let url = "\(Constants.baseUrl)\(movieId)/similar\(Constants.apiKey)"
        
        parser.ParseMovies(api: url) {
                       data in self.recommendedMovies = data
            DispatchQueue.main.async {
                self.detailTableView.reloadData()
            }
        }
    }
    
    func parseCast() {
        
        let url = "\(Constants.baseUrl)\(movieId)/credits\(Constants.apiKey)"
            parser.ParseCreditsDetail(api: url) {
                data in self.cast = data
                DispatchQueue.main.async {
                    self.detailTableView.reloadData()
                }
            }
    }
    
    func tableViewData() {
        detailTableView.dataSource = self
        detailTableView.delegate = self
        detailTableView.register(UINib(nibName: "InfoTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoTableViewCell")
        detailTableView.register(UINib(nibName: "MovieDescriptionCell", bundle: nil), forCellReuseIdentifier: "MovieDescriptionCell")
        detailTableView.register(UINib(nibName: "CastCell", bundle: nil), forCellReuseIdentifier: "CastCell")
        detailTableView.register(UINib(nibName: "RecommendedCell", bundle: nil), forCellReuseIdentifier: "RecommendedCell")
        detailTableView.sectionHeaderTopPadding = 0
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
        
        if indexPath.section == 0 { let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as! InfoTableViewCell
            
            guard let item = detailedMovieInfo else { return cell }
            cell.prepareDetailCell(item)
            return cell } else if indexPath.section == 1 { let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDescriptionCell", for: indexPath) as! MovieDescriptionCell
                guard let item = detailedMovieInfo else { return cell }
                cell.prepareDetailCell(item)
                
                return cell
                
            } else if indexPath.section == 2 { let cell = tableView.dequeueReusableCell(withIdentifier: "CastCell", for: indexPath) as! CastCell
                
                cell.credits = cast
                cell.myCollectionView.reloadData()
                
                return cell
                
            } else { let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendedCell", for: indexPath) as! RecommendedCell
                
                cell.delegate = self
                cell.recommended = recommendedMovies
                cell.myCollectionView.reloadData()
                
                return cell
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

// MARK: - Protocol extension
extension MovieDetailViewController: CarouselTableViewCellDelegate {

    func CellDidSelect(id: Int) {

        self.navigationController?.popViewController(animated: true)
        
        let vc = storyboard?.instantiateViewController(withIdentifier:
                                                        "MovieDetailViewController") as? MovieDetailViewController
        vc?.movieId = id
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}



