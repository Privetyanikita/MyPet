//
//  MainTabBarController.swift
//  MyPet
//
//  Created by NikitaKorniuk   on 10.03.25.
//

import UIKit

final class TabBarController: UITabBarController {
    //MARK: - Properties
    private var translatorButton: UIButton!
    private var clickerButton: UIButton!
    private var activeButton: UIButton?
    private let customTabBarView = UIView()
    private let customTabBarHeight: CGFloat = 82
    
    //MARK: - Life cycle
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
    
    //MARK: - Private Methods
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
        
        translatorButton = createButton(
            title: Strings.ButtonTitles.translator,
            image: Icons.Massages,
            font: UIFont(name: Fonts.KonkhmerSleokchher.regular, size: 12) ?? UIFont.systemFont(ofSize: 12),
            action: #selector(didTapTranslator),
            frame: CGRect(x: 0, y: 0, width: buttonWidth, height: customTabBarHeight)
        )
        
        clickerButton = createButton(
            title: Strings.ButtonTitles.settings,
            image: Icons.Settings,
            font: UIFont(name: Fonts.KonkhmerSleokchher.regular, size: 12) ?? UIFont.systemFont(ofSize: 12),
            action: #selector(didTapClicker),
            frame: CGRect(x: buttonWidth, y: 0, width: buttonWidth, height: customTabBarHeight)
        )
        
        customTabBarView.addSubview(translatorButton)
        customTabBarView.addSubview(clickerButton)
        updateButtonStates(translatorButton)
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
    
    private func updateButtonStates(_ selectedButton: UIButton) {
        let activeColor = UIColor.black
        let inactiveColor = UIColor.gray
        let font = UIFont(name: Fonts.KonkhmerSleokchher.regular, size: 12) ?? UIFont.systemFont(ofSize: 12)

        if selectedButton == translatorButton {
            translatorButton.configuration?.attributedTitle = AttributedString(
                Strings.ButtonTitles.translator,
                attributes: AttributeContainer([.font: font, .foregroundColor: activeColor])
            )
            translatorButton.configuration?.image = Icons.Massages.withTintColor(activeColor)
            clickerButton.configuration?.attributedTitle = AttributedString(
                Strings.ButtonTitles.settings,
                attributes: AttributeContainer([.font: font, .foregroundColor: inactiveColor])
            )
            clickerButton.configuration?.image = Icons.Settings.withTintColor(inactiveColor)
        } else if selectedButton == clickerButton {
            clickerButton.configuration?.attributedTitle = AttributedString(
                Strings.ButtonTitles.settings,
                attributes: AttributeContainer([.font: font, .foregroundColor: activeColor])
            )
            clickerButton.configuration?.image = Icons.Settings.withTintColor(activeColor)
            translatorButton.configuration?.attributedTitle = AttributedString(
                Strings.ButtonTitles.translator,
                attributes: AttributeContainer([.font: font, .foregroundColor: inactiveColor])
            )
            translatorButton.configuration?.image = Icons.Massages.withTintColor(inactiveColor)
        }
    }


    
    @objc private func didTapTranslator() {
        selectedIndex = 0
        updateButtonStates(translatorButton)
    }
    
    @objc private func didTapClicker() {
        selectedIndex = 1
        updateButtonStates(clickerButton)
    }
}
