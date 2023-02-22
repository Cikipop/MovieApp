//
//  MyCollectionViewCell.swift
//  MovieApp
//
//  Created by BURAK AKAR on 1.10.2022.
//

import UIKit
import Kingfisher

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    
    @IBOutlet weak var starlabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    func prepareCell(_ item: AllMovies) {
        
        movieName.text = item.original_title?.capitalized
        starlabel.text = "\(item.vote_average ?? 0.0)"
        
        if let posterPath = item.poster_path,
           let baseUrl = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")") {
            movieImage.kf.indicatorType = .activity
            movieImage.kf.setImage(with: baseUrl, options: [.cacheOriginalImage])
        }
        
        movieImage.layer.cornerRadius = 10
        
        clipsToBounds = true
    }
}

