//
//  TableViewCell.swift
//  MovieApp
//
//  Created by BURAK AKAR on 21.10.2022.
//

import UIKit
import Cosmos
import Kingfisher

class InfoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var runTime: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var genre1: UILabel!
    @IBOutlet weak var genre2: UILabel!
    @IBOutlet weak var genre3: UILabel!
    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var ratingValue: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func prepareDetailCell(_ item: MovieDetails) {
        
        title.text = item.original_title?.capitalized
        releaseDate.text = String((item.release_date ?? "").prefix(4))
        runTime.text = "\(item.runtime ?? 0) min"
        status.text = item.status
    
        
        if item.genres?.count == 3 {
            
            genre1.text = item.genres?[0].name
            genre2.text = item.genres?[1].name
            genre3.text = item.genres?[2].name
            
        } else if item.genres?.count == 2 {
            
            genre1.text = item.genres?[0].name
            genre2.text = item.genres?[1].name
            genre3.backgroundColor = .white
            
        } else {
            
            genre1.text = item.genres?[0].name
            genre2.backgroundColor = .white
            genre3.backgroundColor = .white
        }
        

        rating.text = .none
        ratingValue.text = String(format: "%.1f", item.vote_average ?? 0.0)
        rating.rating = Double(item.vote_average ?? 0.0 / 2)
        rating.settings.updateOnTouch = false
        rating.settings.fillMode = .precise
        
        if let posterPath = item.poster_path,
           let baseUrl = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
            poster.kf.indicatorType = .activity
            poster.kf.setImage(with: baseUrl)
        }
        poster.layer.cornerRadius = 10
        poster.clipsToBounds = true
    }
}
