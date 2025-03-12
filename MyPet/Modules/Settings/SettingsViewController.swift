//
//  Settings.swift
//  MyPet
//
//  Created by NikitaKorniuk   on 10.03.25.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let element = UILabel()
        element.text = Strings.Titles.settings
        element.font = UIFont(name: Fonts.KonkhmerSleokchher.regular, size: 32)
        element.textColor = .black
        element.textAlignment = .center
        element.numberOfLines = 1
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.add(subviews: titleLabel)
    }
    
    private func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = Colors.gradientBackGroundView
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.frame = view.bounds

        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension SettingsViewController {
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(58)
        }
    }
}
