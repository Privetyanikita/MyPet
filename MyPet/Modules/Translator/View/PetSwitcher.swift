//
//  PetSwitcher.swift
//  MyPet
//
//  Created by NikitaKorniuk   on 12.03.25.
//

import UIKit
import SnapKit

protocol PetSwitcherDelegate: AnyObject {
    func petSwitcherDidSelected(isCatSelected: Bool)
}

final class PetSwitcher: UIView {
    
    private let catImageView: UIImageView = {
        let element = UIImageView()
        element.backgroundColor = .clear
        element.image = Icons.Cat
        element.clipsToBounds = true
        element.contentMode = .scaleAspectFit
        return element
    }()
    
    private let catBackground: UIView = {
        let element = UIView()
        element.backgroundColor = Colors.catPetSwitcherBackGround
        element.layer.cornerRadius = 8
        return element
    }()
    
    private let dogImageView: UIImageView = {
        let element = UIImageView()
        element.backgroundColor = Colors.dogPetSwitcherBackGround
        element.image = Icons.Dog
        element.clipsToBounds = true
        element.contentMode = .scaleAspectFit
        return element
    }()
    
    private let dogBackGroundView: UIView = {
        let element = UIView()
        element.backgroundColor = Colors.dogPetSwitcherBackGround
        element.layer.cornerRadius = 8
        return element
    }()
    
    private(set) var isCatSelected = true
    
    weak var delegate: PetSwitcherDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupRecognizers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.add(subviews: catBackground, dogBackGroundView)
        catBackground.add(subviews: catImageView)
        dogBackGroundView.add(subviews: dogImageView)
        self.layer.cornerRadius = 12
        self.backgroundColor = .white
        unSelectedAndSelected(petSelected: .cat)
    }
    
    private func setupRecognizers() {
        catBackground.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(petChangeTap)))
        dogBackGroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(petChangeTap)))
    }
    
    @objc private func petChangeTap() {
        isCatSelected.toggle()
        print(isCatSelected)
        
        delegate?.petSwitcherDidSelected(isCatSelected: isCatSelected)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.isCatSelected ? self.unSelectedAndSelected(petSelected: .cat) : self.unSelectedAndSelected(petSelected: .dog)
        })
    }
    
    private func unSelectedAndSelected(petSelected: Pet) {
        switch petSelected {
        case .cat:
            catImageView.alpha = 1
            catBackground.alpha = 1
            catImageView.transform = .identity
            
            dogImageView.alpha = 0.5
            dogBackGroundView.alpha = 0.5
            dogImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        case .dog:
            catImageView.alpha = 0.5
            catBackground.alpha = 0.5
            catImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
            dogImageView.alpha = 1
            dogBackGroundView.alpha = 1
            dogImageView.transform = .identity
        }
    }
}

extension PetSwitcher {
    private func setupConstraints() {
        
        catBackground.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(18.5)
            make.top.equalToSuperview().inset(12)
            make.height.width.equalTo(70)
        }
        
        catImageView.snp.makeConstraints { make in
            make.top.equalTo(catBackground.snp.top).inset(15)
            make.leading.equalTo(catBackground.snp.leading).inset(15)
            make.height.width.equalTo(40)
        }
        
        dogBackGroundView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(catBackground)
            make.top.equalTo(catBackground.snp.bottom).offset(12)
            make.bottom.equalToSuperview().inset(12)
            make.height.width.equalTo(70)
        }
        
        dogImageView.snp.makeConstraints { make in
            make.top.equalTo(dogBackGroundView.snp.top).inset(15)
            make.leading.equalTo(dogBackGroundView.snp.leading).inset(15)
            make.height.width.equalTo(40)
        }
    }
}
