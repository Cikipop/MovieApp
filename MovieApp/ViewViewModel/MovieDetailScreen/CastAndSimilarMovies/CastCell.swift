//
//  CastAndRecommendedCell.swift
//  MovieApp
//
//  Created by BURAK AKAR on 26.10.2022.
//

import UIKit

class CastCell: UITableViewCell {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
   
    var credits = [AllCast]()
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionViewData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func collectionViewData() {
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(UINib(nibName: "CastnMoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
    }
}

extension CastCell: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return credits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CastnMoviesCollectionViewCell
        let item = credits[indexPath.row]
        cell.prepareCastCell(item)
        return cell
    }
}

