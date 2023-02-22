//
//  RecommendedCellTableViewCell.swift
//  MovieApp
//
//  Created by BURAK AKAR on 28.10.2022.
//

import UIKit

class RecommendedCell: UITableViewCell {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var recommendedMoviesArray: [AllMovies]?
//    var onTapRecommendedMovie: ((Int) -> Void)? = nil
    var delegate: RecommendedCellDelegate? = nil
    
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

extension RecommendedCell: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendedMoviesArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "Cell",
            for: indexPath
        ) as? CastnMoviesCollectionViewCell,
              let item = recommendedMoviesArray?[indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.prepareRecommendedCell(item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieId = recommendedMoviesArray?[indexPath.row].id else { return }
//        onTapRecommendedMovie?(movieId)
        delegate?.onTapRecommended(id: movieId)
    }
}

protocol RecommendedCellDelegate {
    func onTapRecommended(id: Int)
}
