//
//  RecordingView.swift
//  MyPet
//
//  Created by NikitaKorniuk   on 12.03.25.
//

import UIKit
import SnapKit

protocol RecordingViewDelegate: AnyObject {
    func recordingViewDidStartRecording(_ recordingView: RecordingView)
    func recordingViewDidStopRecording(_ recordingView: RecordingView)
}

final class RecordingView: UIView {
    //MARK: - Properties
    private let microImageView: UIImageView = {
        let element = UIImageView()
        element.image = Icons.Micophone
        element.contentMode = .scaleAspectFit
        element.clipsToBounds = true
        return element
    }()
    
    private let titleLabel: UILabel = {
        let element = UILabel()
        element.text = Strings.ButtonTitles.startSpeak
        element.font = UIFont(name: Fonts.KonkhmerSleokchher.regular, size: 16)
        element.numberOfLines = 1
        element.textAlignment = .center
        return element
    }()
    
    private let waveformVisualizerImageView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFit
        element.isHidden = true
        return element
    }()
    
    private var isRecording = false
    
    weak var delegate: RecordingViewDelegate?
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        loadGifFileAtImageView()
        setupGestureRecognezers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    private func setupViews() {
        self.add(subviews: microImageView, titleLabel, waveformVisualizerImageView)
        self.backgroundColor = .white
        self.layer.cornerRadius = 16
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 8
    }
    
    private func loadGifFileAtImageView() {
        guard let gifURL = Bundle.main.url(forResource: "WaveformVisualizer", withExtension: "gif"),
              let gifData = try? Data(contentsOf: gifURL),
              let animatedImage = UIImage.animatedImage(withGIFData: gifData) else {
            return
        }
        waveformVisualizerImageView.image = animatedImage
    }
    
    private func setupGestureRecognezers() {
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc private func handleTap() {
        isRecording.toggle()
        
        UIView.transition(with: titleLabel, duration: 0.3, options: .transitionCrossDissolve) {
            self.titleLabel.text = self.isRecording ? Strings.ButtonTitles.recording : Strings.ButtonTitles.startSpeak
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = self.isRecording ? CGAffineTransform(scaleX: 1.1, y: 1.1) : .identity
        })
        
        if isRecording {
            waveformVisualizerImageView.isHidden = false
            waveformVisualizerImageView.alpha = 0.0
            UIView.animate(withDuration: 0.3) {
                self.waveformVisualizerImageView.alpha = 1.0
                self.microImageView.alpha = 0.0
            }
            self.delegate?.recordingViewDidStartRecording(self)
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.waveformVisualizerImageView.alpha = 0.0
                self.microImageView.alpha = 1.0
            }) { _ in
                self.waveformVisualizerImageView.isHidden = true
            }
            self.delegate?.recordingViewDidStopRecording(self)
        }
    }
}
//MARK: - Extension
extension RecordingView {
    private func setupConstraints() {
        microImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(44)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(microImageView.snp.bottom).offset(24)
            make.bottom.equalToSuperview().inset(16)
        }
        
        waveformVisualizerImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(19)
            make.leading.trailing.equalToSuperview().inset(7.5)
            make.bottom.equalTo(titleLabel.snp.top).inset(24)
        }
    }
}
