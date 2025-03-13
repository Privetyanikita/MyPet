//
//  SettingsOptionViewCell.swift
//  MyPet
//
//  Created by NikitaKorniuk   on 13.03.25.
//

import UIKit
import SnapKit

final class SettingsOptionViewCell: UITableViewCell {
    
    private let backgroundShieldView: UIView = {
        let element = UIView()
        element.layer.cornerRadius = 20
        element.backgroundColor = Colors.settingsCellBackGround
        element.clipsToBounds = true
        return element
    }()
    
    private let titleLabel: UILabel = {
        let element = UILabel()
        element.font = UIFont(name: Fonts.KonkhmerSleokchher.regular, size: 16)
        element.textColor = .black
        element.textAlignment = .left
        element.numberOfLines = 1
        return element
    }()
    
    private let arrowRightImage: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFit
        element.image = Icons.ArrowRight
        element.clipsToBounds = true
        return element
    }()
    
    static let reuseID = String(describing: SettingsOptionViewCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.backgroundColor = .clear
        backgroundView?.backgroundColor = .clear
        contentView.addSubview(backgroundShieldView)
        backgroundShieldView.addSubview(titleLabel)
        backgroundShieldView.addSubview(arrowRightImage)
    }
    
    func configure(title text: String) {
        titleLabel.text = text
    }
}

extension SettingsOptionViewCell {
    private func setupConstrains() {
        backgroundShieldView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(7)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(52)
        }
        
        arrowRightImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
        }
    }
}
