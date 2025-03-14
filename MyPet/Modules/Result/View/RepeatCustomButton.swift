//
//  RepeatCustomButton.swift
//  MyPet
//
//  Created by NikitaKorniuk   on 14.03.25.
//

import UIKit
import SnapKit

final class RepeatCustomButton: UIButton {
    //MARK: - Properties
    private let titleButtonLabel: UILabel = {
        let element = UILabel()
        element.font = UIFont(name: Fonts.KonkhmerSleokchher.regular, size: 12)
        element.textAlignment = .center
        element.numberOfLines = 1
        return element
    }()
    
    private let imageV: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFit
        element.clipsToBounds = true
        return element
    }()
    
    private lazy var containerStackView: UIStackView = {
        let element = UIStackView(arrangedSubviews: [imageV, titleButtonLabel])
        element.axis = .horizontal
        element.alignment = .center
        element.spacing = 10
        return element
    }()
    //MARK: - Init
    init(title: String, image: UIImage) {
        super.init(frame: .zero)
        titleButtonLabel.text = title
        imageV.image = image
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    private func setupViews() {
        self.add(subviews: containerStackView)
        backgroundColor = Colors.settingsCellBackGround
        layer.cornerRadius = 16
    }
}
//MARK: - Extensions
extension RepeatCustomButton {
    private func setupConstraints() {
        containerStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        imageV.snp.makeConstraints { make in
            make.height.width.equalTo(16)
        }
    }
}
