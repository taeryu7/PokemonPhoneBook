//
//  ViewController.swift
//  PokemonPhoneBook
//
//  Created by 유태호 on 12/6/24.
//

import UIKit
import SnapKit

// MARK: - ViewController
/// 메인 화면을 담당하는 뷰컨트롤러
class ViewController: UIViewController {
   
   // MARK: - Properties
   /// 상단 타이틀을 표시할 레이블
   private let titleLabel = UILabel()
   /// 연락처 추가 버튼
   private let addButton = UIButton()
   /// 연락처 목록을 표시할 테이블뷰
   private let tableView = UITableView()
   
   // MARK: - Lifecycle
   override func viewDidLoad() {
       super.viewDidLoad()
       configureUI()    // UI 구성 요소 설정
       setupTableView() // 테이블뷰 초기 설정
   }
   
   // MARK: - UI Setup
   /// UI 구성 요소들의 속성 설정 및 레이아웃 구성
   private func configureUI() {
       view.backgroundColor = .white
       
       // 타이틀 레이블 설정
       titleLabel.text = "친구 목록"
       titleLabel.font = .systemFont(ofSize: 18, weight: .medium)
       titleLabel.textAlignment = .center  // 가운데 정렬
       
       // 추가 버튼 설정
       addButton.setTitle("추가", for: .normal)
       addButton.setTitleColor(.black, for: .normal)
       addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
       
       // 테이블뷰 설정
       tableView.backgroundColor = .white
       //tableView.separatorStyle = .none  // 셀 구분선 제거 (현재 주석처리)
       
       // 각 UI 요소들을 메인 뷰에 추가
       view.addSubview(titleLabel)
       view.addSubview(addButton)
       view.addSubview(tableView)
       
       // MARK: - Auto Layout
       // SnapKit을 사용한 오토레이아웃 설정
       titleLabel.snp.makeConstraints { make in
           make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
           make.centerX.equalToSuperview()  // 가운데 정렬
           make.height.equalTo(40)
       }
       
       addButton.snp.makeConstraints { make in
           make.centerY.equalTo(titleLabel)
           make.trailing.equalToSuperview().offset(-20)
           make.width.equalTo(40)
           make.height.equalTo(40)
       }
       
       tableView.snp.makeConstraints { make in
           make.top.equalTo(titleLabel.snp.bottom).offset(10)
           make.leading.trailing.bottom.equalToSuperview()
       }
   }
   
   // MARK: - Actions
   /// 추가 버튼 탭 시 호출되는 메서드
   @objc
   private func addButtonTapped() {
       // 새로운 연락처 추가 화면으로 네비게이션 푸시
       self.navigationController?.pushViewController(AddNumberViewController(), animated: true)
   }
   
   // MARK: - TableView Setup
   /// 테이블뷰 초기 설정을 담당하는 메서드
   private func setupTableView() {
       tableView.delegate = self
       tableView.dataSource = self
       // ContactCell 클래스를 테이블뷰 셀로 등록
       tableView.register(ContactCell.self, forCellReuseIdentifier: "ContactCell")
   }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
   /// 테이블뷰의 행 개수를 반환하는 메서드
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 6  // 현재는 고정된 6개의 행 표시
   }
   
   /// 각 행에 표시될 셀을 구성하는 메서드
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell else {
           return UITableViewCell()
       }
       cell.selectionStyle = .none  // 셀 선택 시 하이라이트 효과 제거
       return cell
   }
   
   /// 각 행의 높이를 지정하는 메서드
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 80  // 셀 높이 80포인트로 고정
   }
}

// MARK: - Custom Cell
/// 연락처 정보를 표시하는 커스텀 테이블뷰 셀
class ContactCell: UITableViewCell {
   // MARK: - Properties
   /// 프로필 이미지를 표시할 이미지뷰
   private let profileImageView = UIImageView()
   /// 이름을 표시할 레이블
   private let nameLabel = UILabel()
   /// 전화번호를 표시할 레이블
   private let phoneLabel = UILabel()
   
   // MARK: - Initialization
   /// 커스텀 셀 초기화 메서드
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
       setupCell()
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   
   // MARK: - Setup
   /// 셀 UI 구성요소 설정 및 레이아웃 구성
   private func setupCell() {
       // 프로필 이미지 설정
       profileImageView.backgroundColor = .lightGray
       profileImageView.layer.cornerRadius = 25  // 원형 이미지
       profileImageView.clipsToBounds = true
       
       // 이름 레이블 설정
       nameLabel.text = "name"
       nameLabel.font = .systemFont(ofSize: 16)
       
       // 전화번호 레이블 설정
       phoneLabel.text = "010-0000-0000"
       phoneLabel.font = .systemFont(ofSize: 14)
       phoneLabel.textColor = .gray
       
       // 셀 컨텐츠뷰에 UI 요소 추가
       contentView.addSubview(profileImageView)
       contentView.addSubview(nameLabel)
       contentView.addSubview(phoneLabel)
       
       // 오토레이아웃 설정 - 수평 정렬
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
}

// MARK: - SwiftUI Preview Provider
/*
SwiftUI Preview를 통해 UIKit 뷰 컨트롤러를 실시간으로 미리보기 하는 기능
iOS 13부터 도입된 이 기능은 UI 개발 시 빠른 피드백을 가능
*/

#Preview { // Preview 매크로 시작
   /*
    UINavigationController로 감싸는 이유:
    1. 실제 앱에서 사용될 네비게이션 환경을 시뮬레이션
    2. 네비게이션 바, 타이틀, 버튼 등의 UI 요소 확인 가능
    3. push/pop 등 네비게이션 동작 테스트 가능
   */
   UINavigationController(  // 네비게이션 컨트롤러 인스턴스 생성
       rootViewController: ViewController()  // ViewController를 루트 뷰 컨트롤러로 설정
   )
   
   /*
    다른 프리뷰 옵션들:
    - 기본 뷰만 보기: ViewController()
    - 다크모드:
      let vc = ViewController()
      vc.overrideUserInterfaceStyle = .dark
      return UINavigationController(rootViewController: vc)
    - 특정 디바이스:
      ViewController().previewDevice("iPhone 15 Pro")
   */
}

// MARK: - Preview 활용 Tips
/*
1. 실시간 렌더링: 코드 수정 시 즉시 반영
2. 여러 상태 테스트 가능
3. 다양한 디바이스/환경 설정 테스트
4. Canvas에서 직접 인터랙션 테스트
*/
