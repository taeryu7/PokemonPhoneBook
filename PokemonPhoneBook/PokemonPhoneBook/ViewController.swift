//
//  ViewController.swift
//  PokemonPhoneBook
//
//  Created by 유태호 on 12/6/24.
//

import UIKit
import SnapKit
import CoreData

// MARK: - ViewController
/// CoreData를 사용하여 연락처 데이터를 관리하고 테이블뷰로 표시
class ViewController: UIViewController {
  
  // MARK: - Properties
  /// 상단 타이틀 표시용 레이블
  private let titleLabel = UILabel()
  
  /// 새로운 연락처 추가용 버튼
  private let addButton = UIButton()
  
  /// 연락처 목록을 표시할 테이블뷰
  private let tableView = UITableView()
  
  /// CoreData에서 불러온 연락처 데이터 저장용 배열
  private var contacts: [PokemonPhoneBook] = []
  
  // MARK: - Lifecycle Methods
  override func viewDidLoad() {
      super.viewDidLoad()
      configureUI()    // UI 요소 설정
      setupTableView() // 테이블뷰 설정
      loadContacts()  // 초기 데이터 로드
  }
  
  /// 화면이 나타날 때마다 데이터 새로고침
  override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      loadContacts()  // CoreData에서 데이터 로드
  }
  
  // MARK: - UI Configuration
  /// UI 요소 설정 및 레이아웃 구성
  private func configureUI() {
      view.backgroundColor = .white
      
      // 타이틀 레이블 설정
      titleLabel.text = "친구 목록"
      titleLabel.font = .systemFont(ofSize: 18, weight: .medium)
      titleLabel.textAlignment = .center
      
      // 추가 버튼 설정
      addButton.setTitle("추가", for: .normal)
      addButton.setTitleColor(.black, for: .normal)
      addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
      
      // 테이블뷰 설정
      tableView.backgroundColor = .white
      
      // 뷰에 UI 요소 추가
      view.addSubview(titleLabel)
      view.addSubview(addButton)
      view.addSubview(tableView)
      
      // MARK: Auto Layout
      // SnapKit 활용한 제약조건 설정
      titleLabel.snp.makeConstraints { make in
          make.top.equalTo(view.safeAreaLayoutGuide).offset(-20)
          make.centerX.equalToSuperview()
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
          make.left.right.equalTo(view.safeAreaLayoutGuide)
          make.bottom.equalTo(view.safeAreaLayoutGuide)
      }
  }
  
  // MARK: - TableView Setup
  /// 테이블뷰 초기 설정
  private func setupTableView() {
       tableView.delegate = self
       tableView.dataSource = self
       tableView.register(ContactCell.self, forCellReuseIdentifier: "ContactCell")
       tableView.rowHeight = 80  // 셀 높이 지정
       tableView.separatorStyle = .singleLine  // 구분선 스타일 지정
       tableView.separatorInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)  // 구분선 여백 좌우 40으로 설정
   }
  
  // MARK: - Data Management
  /// CoreData에서 연락처 데이터 로드
  private func loadContacts() {
      let context = (UIApplication.shared.delegate as! AppDelegate)
          .persistentContainer.viewContext
      
      let request = PokemonPhoneBook.fetchRequest()
      
      do {
          contacts = try context.fetch(request)
          tableView.reloadData()
      } catch {
          print("데이터 로드 실패: \(error)")
      }
  }
  
  // MARK: - Actions
  /// 추가 버튼 탭시 새 연락처 추가 화면으로 이동
  @objc private func addButtonTapped() {
      let addVC = AddNumberViewController()
      self.navigationController?.pushViewController(addVC, animated: true)
  }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
  /// 테이블뷰 행 개수 반환
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return contacts.count
  }
  
  /// 각 행의 셀 구성
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(
          withIdentifier: "ContactCell",
          for: indexPath) as? ContactCell else {
          return UITableViewCell()
      }
      
      let contact = contacts[indexPath.row]
      cell.configure(with: contact)  // 셀 데이터 설정
      cell.selectionStyle = .none    // 선택 효과 제거
      
      return cell
  }
  
  /// 행 높이 지정
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 80  // 고정 높이 지정
  }
}

// MARK: - SwiftUI Preview
/// 프리뷰 설정
#Preview {
  /*
   네비게이션 컨트롤러를 사용하는 이유:
   1. 실제 앱 환경 시뮬레이션
   2. 네비게이션 바, 타이틀, 버튼 등의 UI 요소 확인
   3. push/pop 등 네비게이션 동작 테스트
  */
  UINavigationController(
      rootViewController: ViewController()
  )
  
  /*
   프리뷰 옵션:
   - 기본 뷰: ViewController()
   - 다크모드:
     let vc = ViewController()
     vc.overrideUserInterfaceStyle = .dark
     return UINavigationController(rootViewController: vc)
   - 특정 기기:
     ViewController().previewDevice("iPhone 15 Pro")
  */
}

// MARK: - Preview 팁
/*
1. 실시간 렌더링으로 코드 수정시 즉시 반영
2. 다양한 상태 테스트 가능
3. 여러 디바이스/환경 테스트 가능
4. Canvas에서 직접 상호작용 테스트
*/
