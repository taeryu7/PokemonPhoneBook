//
//  AddNumberViewController.swift
//  PokemonPhoneBook - 포켓몬 연락처 앱
//
//  Created by 유태호 on 12/6/24.
//

import UIKit
import SnapKit

// MARK: - AddNumberViewController
/// 새로운 연락처를 추가하는 화면을 담당하는 뷰컨트롤러
/// UIImagePickerController 관련 델리게이트를 채택하여 이미지 선택 기능 구현
class AddNumberViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
   // MARK: - Properties
   /// 프로필 이미지를 표시할 이미지뷰
   private let profileImageView = UIImageView()
   /// 이름을 입력받을 텍스트필드
   private let nameTextField = UITextField()
   /// 전화번호를 입력받을 텍스트필드
   private let phoneTextField = UITextField()
   /// 랜덤 포켓몬 이미지를 가져오는 버튼
   private let randomPokemonButton = UIButton()
   
   // MARK: - Lifecycle
   override func viewDidLoad() {
       super.viewDidLoad()
       configureUI()           // UI 구성요소 설정
       setupNavigationBar()    // 네비게이션 바 설정
       setupGestureRecognizer() // 제스처 인식기 설정
   }
   
   // MARK: - Navigation Setup
   /// 네비게이션 바 설정을 담당하는 메서드
   private func setupNavigationBar() {
       title = "연락처 추가"
       // 저장 버튼 생성 및 설정
       let saveBarButton = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(saveButtonTapped))
       navigationItem.rightBarButtonItem = saveBarButton
   }
   
   // MARK: - UI Configuration
   /// UI 구성요소들의 속성 설정 및 레이아웃 구성
   private func configureUI() {
       view.backgroundColor = .white
       
       // 프로필 이미지뷰 설정
       profileImageView.backgroundColor = .systemGray5
       profileImageView.layer.cornerRadius = 50  // 원형 이미지
       profileImageView.clipsToBounds = true
       profileImageView.contentMode = .scaleAspectFit
       
       // 랜덤 포켓몬 버튼 설정
       randomPokemonButton.setTitle("랜덤 포켓몬", for: .normal)
       randomPokemonButton.setTitleColor(.systemBlue, for: .normal)
       randomPokemonButton.addTarget(self, action: #selector(randomPokemonButtonTapped), for: .touchUpInside)
       
       // 이름 입력 텍스트필드 설정
       nameTextField.placeholder = "이름을 입력하세요"
       nameTextField.borderStyle = .roundedRect
       
       // 전화번호 입력 텍스트필드 설정
       phoneTextField.placeholder = "전화번호를 입력하세요"
       phoneTextField.borderStyle = .roundedRect
       phoneTextField.keyboardType = .numberPad
       
       // UI 요소들을 뷰에 추가
       view.addSubview(profileImageView)
       view.addSubview(randomPokemonButton)
       view.addSubview(nameTextField)
       view.addSubview(phoneTextField)
       
       // MARK: - Auto Layout
       // SnapKit을 사용한 오토레이아웃 설정
       profileImageView.snp.makeConstraints { make in
           make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
           make.centerX.equalToSuperview()
           make.width.height.equalTo(100)
       }
       
       randomPokemonButton.snp.makeConstraints { make in
           make.top.equalTo(profileImageView.snp.bottom).offset(10)
           make.centerX.equalToSuperview()
           make.height.equalTo(30)
       }
       
       nameTextField.snp.makeConstraints { make in
           make.top.equalTo(randomPokemonButton.snp.bottom).offset(20)
           make.leading.trailing.equalToSuperview().inset(20)
           make.height.equalTo(40)
       }
       
       phoneTextField.snp.makeConstraints { make in
           make.top.equalTo(nameTextField.snp.bottom).offset(20)
           make.leading.trailing.equalToSuperview().inset(20)
           make.height.equalTo(40)
       }
   }
   
   // MARK: - Gesture Setup
   /// 프로필 이미지 탭 제스처 설정
   private func setupGestureRecognizer() {
       let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
       profileImageView.isUserInteractionEnabled = true
       profileImageView.addGestureRecognizer(tapGesture)
   }
   
   // MARK: - Actions
   /// 프로필 이미지뷰 탭 시 호출되는 메서드
   @objc private func profileImageTapped() {
       let picker = UIImagePickerController()
       picker.delegate = self
       picker.sourceType = .photoLibrary
       present(picker, animated: true)
   }
   
   /// 랜덤 포켓몬 버튼 탭 시 호출되는 메서드
   @objc private func randomPokemonButtonTapped() {
       // 1~1000 사이의 랜덤 ID로 포켓몬 API 호출
       let randomId = Int.random(in: 1...1000)
       let urlString = "https://pokeapi.co/api/v2/pokemon/\(randomId)"
       
       guard let url = URL(string: urlString) else { return }
       
       // API 호출하여 포켓몬 데이터 가져오기
       URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
           guard let data = data,
                 let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                 let sprites = json["sprites"] as? [String: Any],
                 let frontDefault = sprites["front_default"] as? String,
                 let imageUrl = URL(string: frontDefault) else { return }
           
           // 포켓몬 이미지 다운로드
           URLSession.shared.dataTask(with: imageUrl) { data, response, error in
               guard let imageData = data else { return }
               
               // 메인 스레드에서 UI 업데이트
               DispatchQueue.main.async {
                   self?.profileImageView.image = UIImage(data: imageData)
               }
           }.resume()
       }.resume()
   }
   
   /// 저장 버튼 탭 시 호출되는 메서드
    @objc private func saveButtonTapped() {
        guard let name = nameTextField.text, !name.isEmpty,
              let phoneNumber = phoneTextField.text, !phoneNumber.isEmpty else {
            let alert = UIAlertController(title: "입력 오류",
                                        message: "이름과 전화번호를 입력해주세요",
                                        preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            present(alert, animated: true)
            return
        }
        
        let context = (UIApplication.shared.delegate as! AppDelegate)
            .persistentContainer.viewContext
        
        let contact = PokemonPhoneBook(context: context)
        contact.name = name
        contact.phoneNumber = phoneNumber
        if let image = profileImageView.image {
            contact.profileImage = image.jpegData(compressionQuality: 1.0)?.base64EncodedString()
        }
        
        do {
            try context.save()
            navigationController?.popViewController(animated: true)
        } catch {
            print("저장 실패: \(error)")
        }
    }
}

// MARK: - UIImagePickerControllerDelegate
/// 이미지 피커 관련 델리게이트 메서드 구현
extension AddNumberViewController {
   /// 이미지 선택 완료 시 호출되는 메서드
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       if let image = info[.originalImage] as? UIImage {
           profileImageView.image = image
       }
       picker.dismiss(animated: true)
   }
}

// MARK: - Preview
/// SwiftUI 프리뷰를 위한 설정
#Preview {
   UINavigationController(rootViewController: AddNumberViewController())
}
