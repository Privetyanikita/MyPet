//
//  RoleSwitcher.swift
//  MyPet
//
//  Created by NikitaKorniuk   on 11.03.25.
//

import UIKit

final class RoleSwitcherView: UIView {
    //MARK: - Properties
    private let humanLabel: UILabel = {
        let element = UILabel()
        element.text = Strings.Titles.human.uppercased()
        element.font = UIFont(name: Fonts.KonkhmerSleokchher.regular, size: 16)
        element.textColor = .black
        element.textAlignment = .center
        return element
    }()
    
    private let petLabel: UILabel = {
        let element = UILabel()
        element.text = Strings.Titles.pet.uppercased()
        element.font = UIFont(name: Fonts.KonkhmerSleokchher.regular, size: 16)
        element.textColor = .black
        element.textAlignment = .center
        return element
    }()
    
    private let switchButton: UIButton = {
        let button = UIButton(type: .system)
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        let image = Icons.ArrowSwap.withConfiguration(symbolConfig)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [humanLabel, switchButton, petLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 40
        return stackView
    }()
    
    private(set) var isHumanFirst = true
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(containerStackView)
        switchButton.addTarget(self, action: #selector(switchRole), for: .touchUpInside)
    }
    
    @objc private func switchRole() {
        isHumanFirst.toggle()

        UIView.animate(withDuration: 0.3) {
            if self.isHumanFirst {
                self.containerStackView.insertArrangedSubview(self.humanLabel, at: 0)
                self.containerStackView.insertArrangedSubview(self.petLabel, at: 2)
            } else {
                self.containerStackView.insertArrangedSubview(self.petLabel, at: 0)
                self.containerStackView.insertArrangedSubview(self.humanLabel, at: 2)
            }
            
            self.containerStackView.layoutIfNeeded()
        }
    }
}

// MARK: - Constraints
extension RoleSwitcherView {
    private func setupConstraints() {
        containerStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        humanLabel.snp.makeConstraints { make in
            make.width.equalTo(petLabel)
        }
    }
}
