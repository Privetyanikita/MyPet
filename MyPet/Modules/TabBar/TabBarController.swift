//
//  MainTabBarController.swift
//  MyPet
//
//  Created by NikitaKorniuk   on 10.03.25.
//

import UIKit

final class TabBarController: UITabBarController {
    
    private let customTabBarView = UIView()
    private let customTabBarHeight: CGFloat = 82

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupCustomTabBar()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        let bottomInset = customTabBarHeight + 20
        additionalSafeAreaInsets.bottom = bottomInset
    }

    private func setupTabBar() {
        let translatorVC = TranslatorViewController()
        let clickerVC = SettingsViewController()
        
        translatorVC.tabBarItem = UITabBarItem(title: Strings.ButtonTitles.translator, image: Icons.Massages, selectedImage: Icons.Massages)
        clickerVC.tabBarItem = UITabBarItem(title: Strings.ButtonTitles.settings, image: Icons.Settings, selectedImage: Icons.Settings)

        viewControllers = [translatorVC, clickerVC]
        
        tabBar.isHidden = true
    }

    private func setupCustomTabBar() {
        let tabBarWidth = view.bounds.width * 0.55
        let tabBarYPosition = view.bounds.height - customTabBarHeight - 45
        
        customTabBarView.frame = CGRect(
            x: (view.bounds.width - tabBarWidth) / 2,
            y: tabBarYPosition,
            width: tabBarWidth,
            height: customTabBarHeight
        )
        
        customTabBarView.backgroundColor = .white
        customTabBarView.layer.cornerRadius = 16

        view.addSubview(customTabBarView)

        setupTabBarButtons()
    }

    private func setupTabBarButtons() {
        let buttonWidth = customTabBarView.bounds.width / 2

        let translatorButton = createButton(
            title: Strings.ButtonTitles.translator,
            image: Icons.Massages,
            font: UIFont(name: Fonts.KonkhmerSleokchher.regular, size: 12) ?? UIFont.systemFont(ofSize: 12),
            action: #selector(didTapTranslator),
            frame: CGRect(x: 0, y: 0, width: buttonWidth, height: customTabBarHeight)
        )

        let clickerButton = createButton(
            title: Strings.ButtonTitles.settings,
            image: Icons.Settings,
            font: UIFont(name: Fonts.KonkhmerSleokchher.regular, size: 12) ?? UIFont.systemFont(ofSize: 12),
            action: #selector(didTapClicker),
            frame: CGRect(x: buttonWidth, y: 0, width: buttonWidth, height: customTabBarHeight)
        )

        customTabBarView.addSubview(translatorButton)
        customTabBarView.addSubview(clickerButton)
    }
    
    private func createButton(title: String, image: UIImage?, font: UIFont, action: Selector, frame: CGRect) -> UIButton {
        var config = UIButton.Configuration.plain()
        config.image = image
        config.imagePlacement = .top
        config.imagePadding = 5
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.black
        ]
        
        config.attributedTitle = AttributedString(title, attributes: AttributeContainer(attributes))

        let button = UIButton(configuration: config)
        button.frame = frame
        button.addTarget(self, action: action, for: .touchUpInside)
        
        return button
    }

    @objc private func didTapTranslator() {
        selectedIndex = 0
    }

    @objc private func didTapClicker() {
        selectedIndex = 1
    }
}
