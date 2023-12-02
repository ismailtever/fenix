//
//  DetailVC.swift
//  fenix
//
//  Created by Ismail Tever on 2.12.2023.
//

import UIKit

class DetailVC: UIViewController {
    
//MARK: - Properties
    
    let detailImageView = UIImageView()
    let posterImageView = UIImageView()
    let posterLabel = UILabel()
    let seenView = UIView()
    let ratingImageView = UIImageView()
    let ratingLabel = UILabel()
    let calenderImageView = UIImageView()
    let calenderLabel = UILabel()
    let typeImageView = UIImageView()
    let typeLabel = UILabel()
    let descriptionLabel = UILabel()

//MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
//MARK: - Functions
    
    func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.1329745948, green: 0.1571635008, blue: 0.1828652918, alpha: 1)

        let backButton = UIButton(type: .system)
        backButton.setTitle("<", for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.tintColor = .white
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalToSuperview().offset(32)
            make.width.equalTo(44)
            make.height.equalTo(44)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "Detail"
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "Montserrat", size: 16)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backButton)
        }
        
        let saveButton = UIButton(type: .system)
        saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.tintColor = .white
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-24)
            make.centerY.equalTo(backButton)
            make.width.equalTo(18)
            make.height.equalTo(24)
        }
        
        view.addSubview(detailImageView)
        detailImageView.backgroundColor = .white
        detailImageView.layer.cornerRadius = 15
        detailImageView.layer.masksToBounds = true
        detailImageView.image = UIImage(named: "spiderman1")
        detailImageView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.width.equalTo(375)
            make.height.equalTo(210)
        }
        
        view.addSubview(seenView)
        seenView.backgroundColor = #colorLiteral(red: 0.2056852281, green: 0.2193862796, blue: 0.2583034039, alpha: 1)
        seenView.layer.masksToBounds = true
        seenView.layer.cornerRadius = 10
        seenView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(11)
            make.bottom.equalTo(detailImageView.snp.bottom).inset(9)
            make.width.equalTo(54)
            make.height.equalTo(24)
        }
        
        view.addSubview(ratingImageView)
        ratingImageView.image = UIImage(named: "star")
        ratingImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-41)
            make.bottom.equalTo(detailImageView.snp.bottom).inset(13)
            make.width.equalTo(16)
            make.height.equalTo(16)
        }
        
        view.addSubview(ratingLabel)
        ratingLabel.font = UIFont(name: "Montserrat", size: 12)
        ratingLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        ratingLabel.numberOfLines = 0
        ratingLabel.textColor = #colorLiteral(red: 1, green: 0.5283361673, blue: 0, alpha: 1)
        ratingLabel.text = "9.5"
        ratingLabel.snp.makeConstraints { make in
            make.left.equalTo(ratingImageView.snp.right).offset(4)
            make.bottom.equalTo(ratingImageView.snp.bottom)
            make.width.equalTo(25)
            make.height.equalTo(15)
        }
        
        view.addSubview(posterImageView)
        posterImageView.backgroundColor = .orange
        posterImageView.layer.cornerRadius = 15
        posterImageView.layer.masksToBounds = true
        posterImageView.image = UIImage(named: "spiderman")
        posterImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(29)
            make.top.equalTo(detailImageView.snp.bottom).inset(60)
            make.width.equalTo(95)
            make.height.equalTo(120)
        }
        
        view.addSubview(posterLabel)
        posterLabel.font = UIFont(name: "Poppins", size: 18)
        posterLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        posterLabel.numberOfLines = 0
        posterLabel.textColor = .white
        posterLabel.text = "Spiderman No Way Home"
        posterLabel.snp.makeConstraints { make in
            make.left.equalTo(posterImageView.snp.right).offset(29)
            make.right.equalToSuperview().offset(-29)
            make.bottom.equalTo(posterImageView.snp.bottom)
            make.width.equalTo(210)
            make.height.equalTo(48)
        }

        view.addSubview(calenderImageView)
        calenderImageView.image = UIImage(named: "calender")
        calenderImageView.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.left.equalToSuperview().offset(63)
            make.top.equalTo(posterImageView.snp.bottom).offset(24)
        }
        
        view.addSubview(calenderLabel)
        calenderLabel.font = UIFont(name: "Montserrat", size: 12)
        calenderLabel.text = "2021"
        calenderLabel.textColor = #colorLiteral(red: 0.5730340481, green: 0.5718125701, blue: 0.6154962778, alpha: 1)
        calenderLabel.snp.makeConstraints { make in
            make.left.equalTo(calenderImageView.snp.right).offset(4)
            make.top.equalTo(posterImageView.snp.bottom).offset(24)
            make.width.equalTo(40)
            make.height.equalTo(15)
        }
        
        let lineView1 = UIView()
        lineView1.backgroundColor = #colorLiteral(red: 0.5730340481, green: 0.5718125701, blue: 0.6154962778, alpha: 1)
        view.addSubview(lineView1)
        lineView1.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.height.equalTo(16)
            make.left.equalTo(calenderLabel.snp.right).offset(12)
            make.top.equalTo(calenderLabel.snp.top)
        }
        
        view.addSubview(typeImageView)
        typeImageView.image = UIImage(named: "ticket1")
        typeImageView.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.left.equalTo(lineView1.snp.right).offset(12)
            make.top.equalTo(calenderLabel.snp.top)
        }
        
        view.addSubview(typeLabel)
        typeLabel.font = UIFont(name: "Montserrat", size: 12)
        typeLabel.text = "Action"
        typeLabel.textColor = #colorLiteral(red: 0.5730340481, green: 0.5718125701, blue: 0.6154962778, alpha: 1)
        typeLabel.snp.makeConstraints { make in
            make.left.equalTo(typeImageView.snp.right).offset(4)
            make.top.equalTo(calenderLabel.snp.top)
            make.width.equalTo(100)
            make.height.equalTo(15)
        }
        
        let aboutLabel = UILabel()
        aboutLabel.text = "About Movie"
        aboutLabel.textColor = .white
        aboutLabel.font = UIFont(name: "Poppins", size: 14)
        aboutLabel.font = UIFont.boldSystemFont(ofSize: 14)
        view.addSubview(aboutLabel)
        aboutLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(27)
            make.top.equalTo(calenderImageView.snp.bottom).offset(32)
            make.width.equalTo(92)
            make.height.equalTo(33)
        }
        
        let lineView2 = UIView()
        lineView2.backgroundColor = #colorLiteral(red: 0.2281888723, green: 0.2471576035, blue: 0.2773309648, alpha: 1)
        view.addSubview(lineView2)
        lineView2.snp.makeConstraints { make in
            make.width.equalTo(90)
            make.height.equalTo(4)
            make.left.equalToSuperview().offset(26)
            make.top.equalTo(aboutLabel.snp.bottom).offset(4)
        }
        
        
        descriptionLabel.text = "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences."
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont(name: "Poppins", size: 12)
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 12)
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(29)
            make.top.equalTo(lineView2.snp.bottom).offset(24)
            make.width.equalTo(317)
            make.height.equalTo(87)
        }
    }
    
//MARK: - OBJC Functions
    
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveButtonTapped() {
        
    }
    
}