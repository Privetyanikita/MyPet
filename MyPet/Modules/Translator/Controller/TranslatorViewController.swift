//
//  TranslatorViewController.swift
//  MyPet
//
//  Created by NikitaKorniuk   on 10.03.25.
//

import UIKit
import SnapKit

class TranslatorViewController: UIViewController {
    //MARK: - Properties
    private let titleLabel: UILabel = {
        let element = UILabel()
        element.text = Strings.Titles.translator
        element.font = UIFont(name: Fonts.KonkhmerSleokchher.regular, size: 32)
        element.textColor = .black
        element.textAlignment = .center
        element.numberOfLines = 1
        return element
    }()
    
    private let petImageView: UIImageView = {
        let element = UIImageView()
        element.image = Icons.Cat
        element.contentMode = .scaleAspectFit
        element.clipsToBounds = true
        return element
    }()
    
    private let processTranslation: UILabel = {
        let element = UILabel()
        element.text = Strings.Titles.procesOfTranslation
        element.font = UIFont(name: Fonts.KonkhmerSleokchher.regular, size: 16)
        element.textColor = .black
        element.textAlignment = .center
        element.numberOfLines = 1
        element.alpha = 0
        return element
    }()
    
    private let roleSwitcher = RoleSwitcherView()
    private let petSwitcher = PetSwitcher()
    private let recordingView = RecordingView()
    
    private let recognizer = SpeechRecognizer()
    private var requestText: String = ""
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupDelegates()
        speechToText()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        processTranslationAndBackScreen()
    }
    
    //MARK: - Private Methods
    private func setupViews() {
        view.add(subviews: titleLabel, roleSwitcher, petSwitcher, recordingView, petImageView, processTranslation)
        setGradientBackground()
    }
    
    private func setupDelegates() {
        petSwitcher.delegate = self
        recordingView.delegate = self
    }
    
    private func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = Colors.gradientBackGroundView
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func processTranslationAndResultScreen() {
        UIView.animate(withDuration: 0.3, animations: { [self] in
            [titleLabel, roleSwitcher, recordingView, petSwitcher].forEach { $0.alpha = 0 }
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                self.processTranslation.alpha = 1
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
            let viewController = ResultViewController(requestFromSpeech: requestText,
                                                      from: roleSwitcher.isHumanFirst ? .human : .pet,
                                                      to: petSwitcher.isCatSelected ? .cat : .dog)
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true)
        }
    }
    
    private func processTranslationAndBackScreen() {
        [titleLabel, roleSwitcher, recordingView, petSwitcher].forEach { $0.alpha = 1 }
        processTranslation.alpha = 0
    }
    
    private func speechToText() {
        recognizer.onResult = { text in
            self.requestText = text
        }
    }
}

//MARK: - Extension
extension TranslatorViewController {
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(58)
        }
        
        roleSwitcher.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(76.5)
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.height.equalTo(61)
        }
        
        petSwitcher.snp.makeConstraints { make in
            make.top.equalTo(roleSwitcher.snp.bottom).offset(58)
            make.trailing.equalToSuperview().inset(35)
            make.width.equalTo(107)
            make.height.equalTo(176)
        }
        
        recordingView.snp.makeConstraints { make in
            make.top.equalTo(roleSwitcher.snp.bottom).offset(58)
            make.leading.equalToSuperview().inset(35)
            make.trailing.equalTo(petSwitcher.snp.leading).offset(-35)
            make.height.equalTo(176)
        }
        
        petImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(recordingView.snp.bottom).offset(51)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(36)
        }
        
        processTranslation.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(petImageView.snp.top).inset(-63)
        }
    }
}

extension TranslatorViewController: PetSwitcherDelegate {
    func petSwitcherDidSelected(isCatSelected: Bool) {
        let newImage = isCatSelected ? Icons.Cat : Icons.Dog
        print(requestText)
        
        UIView.transition(with: petImageView, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.petImageView.image = newImage
        }, completion: nil)
    }
}

extension TranslatorViewController: RecordingViewDelegate {
    func recordingViewDidStartRecording(_ recordingView: RecordingView) {
        recognizer.startListening()
    }
    
    func recordingViewDidStopRecording(_ recordingView: RecordingView) {
        recognizer.stopListening()
        processTranslationAndResultScreen()
    }
}
