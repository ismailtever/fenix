//
//  MovieCVCell.swift
//  fenix
//
//  Created by Ismail Tever on 2.12.2023.
//

import UIKit
import SnapKit

class MovieCVCell: UICollectionViewCell {
    
//MARK: - Properties
    
    static let identifier = "MovieCVCell"
    static let shared = MovieCVCell()
    
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
    
    var movies: [Movie] = []


//MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - Functions

    func setupUI() {

        contentView.addSubview(movieImageView)
        
        contentView.backgroundColor = #colorLiteral(red: 0.1329745948, green: 0.1571635008, blue: 0.1828652918, alpha: 1)
//        movieImageView.image = UIImage(named: "spiderman")
        movieImageView.layer.cornerRadius = 15
        movieImageView.layer.masksToBounds = true
        movieImageView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(95)
            make.height.equalTo(120)
        }
        
        contentView.addSubview(movieNameLabel)
        movieNameLabel.text = "Spiderman"
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
        movieYearLabel.text = "2021"
        movieYearLabel.font = UIFont(name: "Poppins", size: 12)
        movieYearLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        movieYearLabel.snp.makeConstraints { make in
            make.top.equalTo(movieTypeLabel.snp.bottom).offset(5)
            make.left.equalTo(movieYearImageView.snp.right).offset(4)
        }
        
        contentView.addSubview(movieTimeImageView)
        movieTimeImageView.image = UIImage(named: "time")
        let tintedImage3 = movieTimeImageView.image?.withTintColor(.white, renderingMode: .alwaysOriginal)
        movieTimeImageView.image = tintedImage3
        movieTimeImageView.snp.makeConstraints { make in
            make.top.equalTo(movieYearLabel.snp.bottom).offset(5)
            make.left.equalTo(movieImageView.snp.right).offset(12)
            make.width.height.equalTo(16)
        }
        contentView.addSubview(movieTimeLabel)
        movieTimeLabel.textColor = .white
        movieTimeLabel.text = "139 Minutes"
        movieTimeLabel.font = UIFont(name: "Poppins", size: 12)
        movieTimeLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        movieTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(movieYearLabel.snp.bottom).offset(5)
            make.left.equalTo(movieTimeImageView.snp.right).offset(4)
        }
    }
    func configure(with item: Movie) {
        //çekilen veriyi hücre elemanlarına yerleştir
        let baseURL = "https://image.tmdb.org/t/p/w220_and_h330_face/"
        let posterPath = item.posterPath ?? ""

        let backdropPathString = baseURL + posterPath
        if let backdropURL = URL(string: backdropPathString) {
            if let imageData = try? Data(contentsOf: backdropURL) {
                if let backdropImage = UIImage(data: imageData) {
                    movieImageView.image = backdropImage
                } else {
                    print("Unable to create UIImage")
                }
            } else {
                // Veri alınamadı hatası
                print("Unable to fetch data")
            }
        } else {
            // Geçersiz URL hatası
            print("Invalid URL")
        }
        movieNameLabel.text = item.title
        movieRating.text = "\(item.voteAverage ?? 1.1)"
        movieTypeLabel.text = item.overview
        movieYearLabel.text = item.releaseDate
        movieTimeLabel.text = "123"
        
    }
    
}
