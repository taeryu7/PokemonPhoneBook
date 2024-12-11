//
//  ContactCell.swift
//  PokemonPhoneBook - 연락처 정보를 표시하는 커스텀 테이블뷰 셀
//
//  Created by 유태호 on 12/10/24.
//

import UIKit
import SnapKit

/// 연락처 정보(프로필 이미지, 이름, 전화번호)를 표시하는 커스텀 테이블뷰 셀
class ContactCell: UITableViewCell {
   // MARK: - Properties
   /// 프로필 이미지를 표시할 원형 이미지뷰
   private let profileImageView = UIImageView()
   
   /// 연락처 이름을 표시할 레이블
   private let nameLabel = UILabel()
   
   /// 전화번호를 표시할 레이블
   private let phoneLabel = UILabel()
   
   // MARK: - Initialization
   /// 코드로 셀을 생성할 때 호출되는 초기화 메서드
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
       setupCell()
   }
   
   /// 스토리보드로 셀을 생성할 때 호출되는 초기화 메서드 (현재는 미사용)
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   
   // MARK: - Setup
   /// UI 요소들의 기본 속성 설정 및 레이아웃 구성
   private func setupCell() {
       // 프로필 이미지 기본 설정
       profileImageView.backgroundColor = .lightGray  // 이미지가 없을 때 표시될 배경색
       profileImageView.layer.cornerRadius = 25      // 원형 모서리 설정
       profileImageView.clipsToBounds = true         // 이미지가 원 안에 맞게 잘리도록 설정
       
       // 이름 레이블 폰트 설정
       nameLabel.font = .systemFont(ofSize: 16)
       
       // 전화번호 레이블 폰트와 색상 설정
       phoneLabel.font = .systemFont(ofSize: 14)
       phoneLabel.textColor = .gray
       
       // 셀의 컨텐츠뷰에 UI 요소들 추가
       contentView.addSubview(profileImageView)
       contentView.addSubview(nameLabel)
       contentView.addSubview(phoneLabel)
       
       // SnapKit을 사용한 오토레이아웃 설정
       profileImageView.snp.makeConstraints { make in
           make.centerY.equalToSuperview()           // 수직 중앙 정렬
           make.leading.equalToSuperview().offset(40) // 좌측 여백 40
           make.width.height.equalTo(50)             // 50x50 크기
       }
       
       nameLabel.snp.makeConstraints { make in
           make.centerY.equalToSuperview()           // 수직 중앙 정렬
           make.leading.equalTo(profileImageView.snp.trailing).offset(40) // 프로필 이미지 우측 40 여백
       }
       
       phoneLabel.snp.makeConstraints { make in
           make.centerY.equalToSuperview()           // 수직 중앙 정렬
           make.leading.equalTo(nameLabel.snp.trailing).offset(40) // 이름 레이블 우측 40 여백
           make.trailing.equalToSuperview().offset(-40) // 우측 여백 40
       }
   }
   
   // MARK: - Configuration
   /// CoreData에서 가져온 연락처 정보로 셀 구성
   /// - Parameter contact: CoreData의 PokemonPhoneBook 엔티티 데이터
   func configure(with contact: PokemonPhoneBook) {
       nameLabel.text = contact.name          // 이름 설정
       phoneLabel.text = contact.phoneNumber  // 전화번호 설정
       
       // 저장된 프로필 이미지가 있으면 표시, 없으면 기본 배경색 사용
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
