//
//  CastAndRecommendedCell.swift
//  MovieApp
//
//  Created by BURAK AKAR on 26.10.2022.
//

import UIKit

class CastCell: UITableViewCell {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    let parser = Parser()
    var credits = [AllCast]()
    var IdNumber = 0 {
        didSet {  let url = "\(Constants.baseUrl)\(IdNumber)/credits\(Constants.apiKey)"
            parser.ParseCreditsDetail(api: url) {
                data in self.credits = data
                DispatchQueue.main.async {
                    self.myCollectionView.reloadData()
                }
            }
        }
    }
    
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

