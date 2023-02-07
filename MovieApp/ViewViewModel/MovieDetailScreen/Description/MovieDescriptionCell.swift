//
//  MovieDescriptionCell.swift
//  MovieApp
//
//  Created by BURAK AKAR on 22.10.2022.
//

import UIKit

class MovieDescriptionCell: UITableViewCell {
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func prepareDetailCell(_ item: MovieDetails) {
        
        overviewLabel.text = item.overview
    }
}
