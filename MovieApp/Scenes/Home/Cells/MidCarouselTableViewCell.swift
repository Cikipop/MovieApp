//
//  MySecondCarouselTableViewCell.swift
//  MovieApp
//
//  Created by BURAK AKAR on 3.10.2022.
//

import UIKit

class MidCarouselTableViewCell: UITableViewCell {
    
    var onTapTopRatedMovie: ((Int) -> Void)? = nil
    var topRatedMovies = [AllMovies]()
    
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionViewData()
        
        func collectionViewData() {
            myCollectionView.dataSource = self
            myCollectionView.delegate = self
            myCollectionView.register(UINib(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyCollectionViewCell")
            myCollectionView.isPagingEnabled = true
        }
    }
}

extension MidCarouselTableViewCell: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         topRatedMovies.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        let item = topRatedMovies[indexPath.row]
        cell.prepareCell(item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        onTapTopRatedMovie?(topRatedMovies[indexPath.row].id ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
       
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameSize = collectionView.frame.size
        return CGSize(width: frameSize.width / 2, height: frameSize.height)
    }
}
