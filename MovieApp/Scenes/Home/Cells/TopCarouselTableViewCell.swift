//
//  MyCarouselTableViewCell.swift
//  MovieApp
//
//  Created by BURAK AKAR on 1.10.2022.
//

import UIKit
import Kingfisher

class TopCarouselTableViewCell: UITableViewCell {
    
    var nowPlayingMovies = [AllMovies]()
    var onTapNowPlayingMovie : ((Int) -> Void)? = nil
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionViewData()
    }
    
    func collectionViewData() {
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(UINib(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyCollectionViewCell")
        myCollectionView.isPagingEnabled = true
    }
}

extension TopCarouselTableViewCell: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        nowPlayingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as? MyCollectionViewCell else { return UICollectionViewCell() }
        let item = nowPlayingMovies[indexPath.row]
        cell.prepareCell(item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        onTapNowPlayingMovie?(nowPlayingMovies[indexPath.row].id ?? 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameSize = collectionView.frame.size
        return CGSize(width: frameSize.width, height: frameSize.height)
    }
}

