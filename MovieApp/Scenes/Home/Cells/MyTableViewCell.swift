//
//  MyTableViewCell.swift
//  MovieApp
//
//  Created by BURAK AKAR on 1.10.2022.
//

import UIKit
import Kingfisher

class MyTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet weak var movieName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func prepareCell(_ item: AllMovies) {
        
        movieDate.text = item.release_date
        movieName.text = item.original_title
        movieRate.text = "\(item.vote_average ?? 0.0)"
        
        if let posterPath = item.poster_path,
           let baseUrl = URL(string: "https://image.tmdb.org/t/p/w185\(posterPath ?? "")") {
            movieImage.kf.indicatorType = .activity
            movieImage.kf.setImage(with: baseUrl)
        }
        movieImage.layer.cornerRadius = 10
        
        clipsToBounds = true
        
    }
}






