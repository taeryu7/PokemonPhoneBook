//
//  ViewController.swift
//  PokemonPhoneBook
//
//  Created by 유태호 on 12/6/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    private let titleLabel = UILabel()
    private let addButton = UIButton()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupTableView()
    }
    
    
    
    private func configureUI() {
        view.backgroundColor = .white
        
        // 타이틀 레이블 설정
        titleLabel.text = "친구 목록"
        titleLabel.font = .systemFont(ofSize: 18, weight: .medium)
        titleLabel.textAlignment = .center  // 가운데 정렬로 변경
        
        // 추가 버튼 설정
        addButton.setTitle("추가", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        // 테이블뷰 설정
        tableView.backgroundColor = .white
        //tableView.separatorStyle = .none
        
        // 뷰에 추가
        view.addSubview(titleLabel)
        view.addSubview(addButton)
        view.addSubview(tableView)
        
        // 오토레이아웃 설정
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
    
    @objc
    private func addButtonTapped() {
        self.navigationController?.pushViewController(AddNumberViewController(), animated: true)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ContactCell.self, forCellReuseIdentifier: "ContactCell")
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

// MARK: - Custom Cell
class ContactCell: UITableViewCell {
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let phoneLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        // 프로필 이미지 설정
        profileImageView.backgroundColor = .lightGray
        profileImageView.layer.cornerRadius = 25
        profileImageView.clipsToBounds = true
        
        // 이름 레이블 설정
        nameLabel.text = "name"
        nameLabel.font = .systemFont(ofSize: 16)
        
        // 전화번호 레이블 설정
        phoneLabel.text = "010-0000-0000"
        phoneLabel.font = .systemFont(ofSize: 14)
        phoneLabel.textColor = .gray
        
        // 뷰에 추가
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(phoneLabel)
        
        // 오토레이아웃 설정 - 수평 정렬로 변경
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

#Preview {
    UINavigationController(rootViewController: ViewController())
}
