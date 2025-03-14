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
    
    private lazy var tableView: UITableView = {
        let element = UITableView()
        element.register(SettingsOptionViewCell.self, forCellReuseIdentifier: SettingsOptionViewCell.reuseID)
        element.estimatedRowHeight = 50
        element.rowHeight = 64
        element.backgroundColor = .clear
        element.separatorStyle = .none
        element.delegate = self
        element.dataSource = self
        return element
    }()
    
    private let stringsData = Strings.Titles.settingsParameters
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.add(subviews: titleLabel, tableView)
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
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stringsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsOptionViewCell.reuseID, for: indexPath) as! SettingsOptionViewCell
        cell.configure(title: stringsData[indexPath.row])
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alert = UIAlertController(
            title: "Soon",
            message: "It's still in development.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}
