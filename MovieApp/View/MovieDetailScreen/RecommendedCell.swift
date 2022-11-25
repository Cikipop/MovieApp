//
//  RecommendedCellTableViewCell.swift
//  MovieApp
//
//  Created by BURAK AKAR on 28.10.2022.
//

import UIKit

class RecommendedCell: UITableViewCell {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    let parser = Parser()
    var delegate : CarouselTableViewCellDelegate?
    var recommended = [AllMovies]()
    var IdNumber = 0 {
        didSet {  let url = "\(Constants.baseUrl)\(IdNumber)/similar\(Constants.apiKey)"
            parser.ParseMovies(api: url) {
                data in self.recommended = data
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

extension RecommendedCell: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommended.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CastnMoviesCollectionViewCell
        let item = recommended[indexPath.row]
        cell.prepareRecommendedCell(item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.CellDidSelect(id: recommended[indexPath.row].id)
    }
}
