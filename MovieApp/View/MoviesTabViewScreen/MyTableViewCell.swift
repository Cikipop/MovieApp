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
        movieRate.text = "\(item.vote_average)"
        
        let baseUrl = URL(string: "https://image.tmdb.org/t/p/w500\(item.poster_path ?? "")")
        
        movieImage.kf.setImage(with: baseUrl)
        movieImage.layer.cornerRadius = 10
        
        clipsToBounds = true
        
    }
}






