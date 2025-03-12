//
//  ResultViewController.swift
//  MyPet
//
//  Created by NikitaKorniuk   on 12.03.25.
//

import UIKit
import SnapKit

final class ResultViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let element = UILabel()
        element.text = Strings.Titles.result
        element.font = UIFont(name: Fonts.KonkhmerSleokchher.regular, size: 32)
        element.textColor = .black
        element.textAlignment = .center
        element.numberOfLines = 1
        return element
    }()
    
    private let messageImageView: UIImageView = {
        let element = UIImageView()
        element.image = Icons.MessageBig
        element.contentMode = .scaleAspectFit
        element.clipsToBounds = true
        return element
    }()
    
    private let petImageView: UIImageView = {
        let element = UIImageView()
        element.image = Icons.Cat
        element.contentMode = .scaleAspectFit
        element.clipsToBounds = true
        return element
    }()
    
    private let closeButton: UIButton = {
        let element = UIButton()
        element.setImage(Icons.Close, for: .normal)
        element.layer.cornerRadius = 24
        element.backgroundColor = .white
        return element
    }()
    
    private let requestLabel: UILabel = {
        let element = UILabel()
        element.font = UIFont(name: Fonts.KonkhmerSleokchher.regular, size: 12)
        element.textColor = .black
        element.numberOfLines = 7
        element.textAlignment = .center
        return element
    }()
    
    private let fromRequest: TranslatFrom
    private let toRequest: Pet
    
    init(requestFromSpeech: String, from: TranslatFrom, to pet: Pet) {
        self.fromRequest = from
        self.requestLabel.text = requestFromSpeech
        self.toRequest = pet
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
        setupViews()
        addTarget()
        setupScreens()
        setupConstraints()
    }
    
    private func setupViews() {
        view.add(subviews: titleLabel, messageImageView, petImageView, closeButton, requestLabel)
    }
    
    private func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = Colors.gradientBackGroundView
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.frame = view.bounds

        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func addTarget() {
        closeButton.addTarget(self, action: #selector(closeTap), for: .touchUpInside)
    }
    
    private func setupScreens() {
        if fromRequest == .human {
            
        } else {
            
        }
        
        switch toRequest {
        case .cat:
            petImageView.image = Icons.Cat
        case .dog:
            petImageView.image = Icons.Dog
        }
    }
    
    @objc private func closeTap() {
        dismiss(animated: true)
    }
}

extension ResultViewController {
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(58)
        }
        
        messageImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(91)
            make.leading.trailing.equalToSuperview().inset(49)
        }
        
        petImageView.snp.makeConstraints { make in
            make.top.equalTo(messageImageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(103)
        }
        
        closeButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.leading.equalToSuperview().inset(30)
            make.height.width.equalTo(48)
        }
        
        requestLabel.snp.makeConstraints { make in
            make.top.equalTo(messageImageView)
            make.leading.trailing.equalTo(messageImageView).inset(25)
            make.bottom.equalTo(messageImageView.snp.bottom).offset(-115)
        }
    }
}
