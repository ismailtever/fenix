//
//  FavVC.swift
//  fenix
//
//  Created by Ismail Tever on 2.12.2023.
//

import UIKit
import CoreData

final class FavVC: UIViewController {
    
    //MARK: - Properties
    private var coreDataItems: [MovieItems] = []
    
    //MARK: - UI Elements
    private var collectionView: UICollectionView!
    
    //MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        coreDataItems = CoreDataManager.shared.fetchAllMovieItems()
        collectionView.reloadData()
        print("Core Data Items Count: \(coreDataItems.count)")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Functions
    
    private func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.1329745948, green: 0.1571635008, blue: 0.1828652918, alpha: 1)
        
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(named: "backButton"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.tintColor = .white
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalToSuperview().offset(32)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "Watch List"
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "Montserrat", size: 16)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backButton)
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = #colorLiteral(red: 0.1329745948, green: 0.1571635008, blue: 0.1828652918, alpha: 1)
        collectionView.register(MovieCVCell.self, forCellWithReuseIdentifier: MovieCVCell.identifier)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(44)
            make.width.equalToSuperview()
            make.height.equalTo(600)
        }
    }
    
    //MARK: - OBJC Functions
    @objc func backButtonTapped() {
        
    }
}

// MARK: - Extensions

extension FavVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coreDataItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCVCell.identifier, for: indexPath) as! MovieCVCell
        let movieDB = coreDataItems[indexPath.row]
        cell.configureWithCoreData(with: movieDB)
        return cell
    }
}
extension FavVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 25, height: 120 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension FavVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDBMovie = coreDataItems[indexPath.row]
        let detailVC = DetailVC()
        detailVC.selectedDB = selectedDBMovie
        detailVC.modalPresentationStyle = .fullScreen
        present(detailVC, animated: true, completion: nil)
    }
}
