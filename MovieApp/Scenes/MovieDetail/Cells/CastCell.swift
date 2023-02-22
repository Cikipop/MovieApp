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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CastnMoviesCollectionViewCell else { return UICollectionViewCell() }
        let item = credits[indexPath.row]
        cell.prepareCastCell(item)
        return cell
    }
}

