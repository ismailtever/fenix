//
//  MovieCVCell.swift
//  fenix
//
//  Created by Ismail Tever on 2.12.2023.
//

import UIKit
import SnapKit
import CoreData

final class MovieCVCell: UICollectionViewCell {
    
    //MARK: - Properties
    var movies: [Movie] = []
    static let identifier = "MovieCVCell"
    
    //MARK: - UI Elements
    private var movieImageView = UIImageView()
    private var movieNameLabel = UILabel()
    private var movieRatingImageView = UIImageView()
    private var movieRating = UILabel()
    private var movieTypeImageView = UIImageView()
    private var movieTypeLabel = UILabel()
    private var movieYearImageView = UIImageView()
    private var movieYearLabel = UILabel()
    private var movieTimeImageView = UIImageView()
    private var movieTimeLabel = UILabel()
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    private func setupUI() {
        
        contentView.addSubview(movieImageView)
        
        contentView.backgroundColor = #colorLiteral(red: 0.1329745948, green: 0.1571635008, blue: 0.1828652918, alpha: 1)
        movieImageView.layer.cornerRadius = 15
        movieImageView.layer.masksToBounds = true
        movieImageView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(95)
            make.height.equalTo(120)
        }
        
        contentView.addSubview(movieNameLabel)
        movieNameLabel.textColor = .white
        movieNameLabel.numberOfLines = 0
        movieNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        movieNameLabel.font = UIFont(name: "Montserrat", size: 16)
        movieNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(movieImageView.snp.right).offset(12)
            make.right.equalToSuperview().inset(12)
        }
        
        contentView.addSubview(movieRatingImageView)
        movieRatingImageView.image = UIImage(named: "star")
        movieRatingImageView.snp.makeConstraints { make in
            make.top.equalTo(movieNameLabel.snp.bottom).offset(14)
            make.left.equalTo(movieImageView.snp.right).offset(12)
            make.width.height.equalTo(16)
        }
        
        contentView.addSubview(movieRating)
        movieRating.text = "9.5"
        movieRating.textColor = #colorLiteral(red: 1, green: 0.5283361673, blue: 0, alpha: 1)
        movieRating.font = UIFont(name: "Montserrat", size: 12)
        movieRating.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        movieRating.snp.makeConstraints { make in
            make.top.equalTo(movieNameLabel.snp.bottom).offset(14.5)
            make.left.equalTo(movieRatingImageView.snp.right).offset(4)
        }
        
        contentView.addSubview(movieTypeImageView)
        movieTypeImageView.image = UIImage(systemName: "ticket.fill")
        let tintedImage1 = movieTypeImageView.image?.withTintColor(.white, renderingMode: .alwaysOriginal)
        movieTypeImageView.image = tintedImage1
        movieTypeImageView.snp.makeConstraints { make in
            make.top.equalTo(movieRating.snp.bottom).offset(5)
            make.left.equalTo(movieImageView.snp.right).offset(12)
            make.width.height.equalTo(16)
        }
        contentView.addSubview(movieTypeLabel)
        movieTypeLabel.textColor = .white
        movieTypeLabel.text = "Action"
        movieTypeLabel.font = UIFont(name: "Poppins", size: 12)
        movieTypeLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        movieTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(movieRating.snp.bottom).offset(5)
            make.left.equalTo(movieTypeImageView.snp.right).offset(4)
        }
        
        contentView.addSubview(movieYearImageView)
        movieYearImageView.image = UIImage(systemName: "calendar")
        let tintedImage2 = movieYearImageView.image?.withTintColor(.white, renderingMode: .alwaysOriginal)
        movieYearImageView.image = tintedImage2
        movieYearImageView.snp.makeConstraints { make in
            make.top.equalTo(movieTypeLabel.snp.bottom).offset(5)
            make.left.equalTo(movieImageView.snp.right).offset(12)
            make.width.height.equalTo(16)
        }
        contentView.addSubview(movieYearLabel)
        movieYearLabel.textColor = .white
        movieYearLabel.font = UIFont(name: "Poppins", size: 12)
        movieYearLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        movieYearLabel.snp.makeConstraints { make in
            make.top.equalTo(movieTypeLabel.snp.bottom).offset(5)
            make.left.equalTo(movieYearImageView.snp.right).offset(4)
        }
    }
    func configure(with item: Movie) {
        movieNameLabel.text = item.title
        
        let formattedString = item.voteAverage?.formattedString()
        movieRating.text = formattedString
        
        movieTypeLabel.text = item.overview
        movieYearLabel.text = item.releaseDate
        
        guard let posterPath = item.posterPath else { return }
        MovieService.shared.getMovieImage(imgURL: posterPath, imgPath: .posterPathString) { movieImageData in
            if let imageData = movieImageData {
                self.movieImageView.image = UIImage(data: imageData)
            } else {
                self.movieImageView.image = UIImage(named: "defaultImage")
            }
        } failure: { err in
            print(err)
        }
    }
    
    func configureWithCoreData(with item: MovieItems) {
        movieNameLabel.text = item.title
        
        let formattedString = item.voteAverage.formattedString()
        movieRating.text = formattedString
        
        movieTypeLabel.text = "Action"
        movieYearLabel.text = item.releaseDate
        guard let posterPath = item.posterPath else { return }
        MovieService.shared.getMovieImage(imgURL: posterPath, imgPath: .posterPathString) { movieImageData in
            if let imageData = movieImageData {
                self.movieImageView.image = UIImage(data: imageData)
            } else {
                self.movieImageView.image = UIImage(named: "defaultImage")
            }
        } failure: { err in
            print(err)
        }
    }
    
}
