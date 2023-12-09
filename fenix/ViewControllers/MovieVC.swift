//
//  MovieVC.swift
//  fenix
//
//  Created by Ismail Tever on 2.12.2023.
//

import UIKit
import SnapKit

final class MovieVC: UIViewController {
    
    //MARK: - Properties
    
    private let debouncer = Debouncer(delay: 1.5)
    private var currentPage = 1
    private var isFetching = false
    
    var movies: [Movie] = []
    
    //MARK: - UI Elements
    private var collectionView: UICollectionView!
    private var searchBar : UISearchBar!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Functions
    
    private func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.1329745948, green: 0.1571635008, blue: 0.1828652918, alpha: 1)
        let titleLabel = UILabel()
        titleLabel.text = "Movie List"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalToSuperview()
        }
        
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search Movies"
        searchBar.barStyle = .default
        searchBar.searchBarStyle = .minimal
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
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
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.height.equalTo(600)
        }
    }
    
    private func fetchScrollNextPage() {
        guard isFetching == false else { return }
        
        isFetching = true
        
        MovieService.shared.getMovies(query: searchBar.text ?? "", page: currentPage + 1) { moviesResponse in
            
            if let newMovies = moviesResponse.results {
                self.movies.append(contentsOf: newMovies)
                self.currentPage += 1
            }
            self.isFetching = false
            self.collectionView.reloadData()
        } failure: { error in
            print(error)
            self.isFetching = false
        }
    }
}

// MARK: - Extensions

extension MovieVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(movies.count)
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCVCell.identifier, for: indexPath) as! MovieCVCell
        let movie = movies[indexPath.item]
        cell.configure(with: movie)
        return cell
    }
}

extension MovieVC: UICollectionViewDelegateFlowLayout {
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

extension MovieVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = movies[indexPath.row]
        let detailVC = DetailVC()
        detailVC.selectedMovie = selectedMovie
        detailVC.modalPresentationStyle = .fullScreen
        present(detailVC, animated: true, completion: nil)
    }
}

extension MovieVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text, !query.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                MovieService.shared.getMovies(query: query, page: 1) { moviesResponse in
                    self.movies = moviesResponse.results ?? []
                    self.collectionView.reloadData()
                } failure: { error in
                    print(error)
                }
            }
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let startSearchIndex = 2
        debouncer.debounce {
            if searchText.count > startSearchIndex {
                MovieService.shared.getMovies(query: searchText, page: 1) { moviesResponse in
                    self.movies = moviesResponse.results ?? []
                    self.collectionView.reloadData()
                } failure: { error in
                    print(error)
                }
            } else {
                self.movies = []
                self.collectionView.reloadData()
            }
        }
    }
}

extension MovieVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height - scrollView.frame.size.height
        if offsetY > contentHeight && !isFetching {
            fetchScrollNextPage()
        }
    }
}
