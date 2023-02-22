//
//  CastnMoviesCollectionViewCell.swift
//  MovieApp
//
//  Created by BURAK AKAR on 26.10.2022.
//

import UIKit
import Kingfisher

class CastnMoviesCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterRoleName: UILabel!
    // aynı cell i hem cast hem recommended filmler için kullandığımdan yukarıdakiler daha düzgün isimlendirilebilirdi
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func prepareCastCell(_ item: AllCast) {
        
        characterName.text = item.name
        characterRoleName.text = item.character
        
        let baseUrl = URL(string: "https://image.tmdb.org/t/p/w500\(item.profile_path ?? "")")
        characterImage.kf.indicatorType = .activity
        characterImage.kf.setImage(
            with: baseUrl,
            options: [.cacheOriginalImage],
            completionHandler: nil
        )
        characterImage.layer.cornerRadius = 10
        characterImage.clipsToBounds = true
    }
    
    func prepareRecommendedCell(_ item: AllMovies) {
        
        characterName.text = item.original_title
        characterRoleName.text = ""
        
        if let posterPath = item.poster_path,
           let baseUrl = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")") {
            characterImage.kf.indicatorType = .activity
            characterImage.kf.setImage(
                with: baseUrl,
                options: [.cacheOriginalImage],
                completionHandler: nil
            )
        }
    }
}
