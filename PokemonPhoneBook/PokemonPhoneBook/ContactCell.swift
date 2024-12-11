//
//   ContactCell.swift
//  PokemonPhoneBook
//
//  Created by 유태호 on 12/10/24.
//

import UIKit
import SnapKit

class ContactCell: UITableViewCell {
    // MARK: - Properties
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let phoneLabel = UILabel()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupCell() {
        // 프로필 이미지 설정
        profileImageView.backgroundColor = .lightGray
        profileImageView.layer.cornerRadius = 25
        profileImageView.clipsToBounds = true
        
        // 이름 레이블 설정
        nameLabel.font = .systemFont(ofSize: 16)
        
        // 전화번호 레이블 설정
        phoneLabel.font = .systemFont(ofSize: 14)
        phoneLabel.textColor = .gray
        
        // 셀 컨텐츠뷰에 UI 요소 추가
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(phoneLabel)
        
        // 오토레이아웃 설정
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(40)
            make.width.height.equalTo(50)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(profileImageView.snp.trailing).offset(40)
        }
        
        phoneLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(nameLabel.snp.trailing).offset(40)
        }
    }
    
    // MARK: - Configuration
    func configure(with contact: PokemonPhoneBook) {
        nameLabel.text = contact.name
        phoneLabel.text = contact.phoneNumber
        
        if let imageString = contact.profileImage,
           let imageData = Data(base64Encoded: imageString),
           let image = UIImage(data: imageData) {
            profileImageView.image = image
        } else {
            profileImageView.image = nil
            profileImageView.backgroundColor = .lightGray
        }
    }
}
