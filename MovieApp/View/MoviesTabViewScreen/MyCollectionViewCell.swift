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
        
        movieName.text = item.original_title.capitalized
        starlabel.text = "\(item.vote_average)"
        
        let baseUrl = URL(string: "https://image.tmdb.org/t/p/w500\(item.poster_path ?? "")")
        
        movieImage.kf.setImage(with: baseUrl)
        movieImage.layer.cornerRadius = 10
        
        clipsToBounds = true
    }
}

