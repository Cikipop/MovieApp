//
//  MySecondCarouselTableViewCell.swift
//  MovieApp
//
//  Created by BURAK AKAR on 3.10.2022.
//

import UIKit

class MidCarouselTableViewCell: UITableViewCell {
    
    var delegate : CarouselTableViewCellDelegate?
    let parser = Parser()
    var topRatedMovies = [AllMovies]()
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionViewData()
        
        parser.ParseMovies(api: Constants.topRatedMoviesUrl) {
            data in self.topRatedMovies = data
            DispatchQueue.main.async {
                self.myCollectionView.reloadData()
            }
        }
        
        func collectionViewData() {
            myCollectionView.dataSource = self
            myCollectionView.delegate = self
            myCollectionView.register(UINib(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyCollectionViewCell")
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
        
        delegate?.CellDidSelect(id: topRatedMovies[indexPath.row].id)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cWidth = collectionView.frame.size.width / 2
        let cHeight = collectionView.frame.size.height
        return CGSize(width: cWidth, height: cHeight)
    }
}
