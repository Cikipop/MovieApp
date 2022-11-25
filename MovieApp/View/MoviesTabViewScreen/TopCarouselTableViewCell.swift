//
//  MyCarouselTableViewCell.swift
//  MovieApp
//
//  Created by BURAK AKAR on 1.10.2022.
//

import UIKit
import Kingfisher

class TopCarouselTableViewCell: UITableViewCell {
    
    let parser = Parser()
    var nowPlayingMovies = [AllMovies]()
    var delegate : CarouselTableViewCellDelegate?
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionViewData()
        parser.ParseMovies(api: Constants.nowplayingMoviesUrl) {
            data in self.nowPlayingMovies = data
            DispatchQueue.main.async {
                self.myCollectionView.reloadData()
            }
        }
    }
    
    func collectionViewData() {
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(UINib(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyCollectionViewCell")
    }
}

extension TopCarouselTableViewCell: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        nowPlayingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        let item = nowPlayingMovies[indexPath.row]
        cell.prepareCell(item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.CellDidSelect(id: nowPlayingMovies[indexPath.row].id)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cWidth = collectionView.frame.size.width
        let cHeight = collectionView.frame.size.height
        return CGSize(width: cWidth, height: cHeight)
    }
}

