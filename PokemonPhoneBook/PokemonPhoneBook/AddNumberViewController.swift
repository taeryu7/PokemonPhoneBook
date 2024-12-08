//
//  AddNumberView.swift
//  PokemonPhoneBook
//
//  Created by 유태호 on 12/6/24.
//

import UIKit
import SnapKit

class AddNumberViewController: UIViewController {
    
    private let titleLabel =  UILabel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        titleLabel.text = "연락처 추가"
        titleLabel.font = .systemFont(ofSize: 24)
        view.addSubview(titleLabel)
    }
}

#Preview {
    AddNumberViewController()
}
