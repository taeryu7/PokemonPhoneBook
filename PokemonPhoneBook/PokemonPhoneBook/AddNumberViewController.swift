//
//  AddNumberView.swift
//  PokemonPhoneBook
//
//  Created by 유태호 on 12/6/24.
//

import UIKit
import SnapKit

class AddNumberViewController: UIViewController {
    
    private let profileImageView = UIImageView()
    private let nameTextField = UITextField()
    private let phoneTextField = UITextField()
    private let saveButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupNavigationBar()
        
    }
    
    private func setupNavigationBar() {
        title = "연락처 추가"
        
        // "저장" 버튼 추가
        let saveBarButton = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveBarButton
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        // 프로필 이미지 설정
        profileImageView.backgroundColor = .lightGray
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        
        // 이름 텍스트필드 설정
        nameTextField.placeholder = "이름을 입력하세요"
        nameTextField.borderStyle = .roundedRect
        
        // 전화번호 텍스트필드 설정
        phoneTextField.placeholder = "전화번호를 입력하세요"
        phoneTextField.borderStyle = .roundedRect
        phoneTextField.keyboardType = .numberPad
        
        // 뷰에 추가
        view.addSubview(profileImageView)
        view.addSubview(nameTextField)
        view.addSubview(phoneTextField)
        
        // 오토레이아웃 설정
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
    }
    
    @objc private func saveButtonTapped() {
        // 저장 로직 구현
        navigationController?.popViewController(animated: true)
    }
}

//커밋테스트용 주석
#Preview {
    AddNumberViewController()
}
