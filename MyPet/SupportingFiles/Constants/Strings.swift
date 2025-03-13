//
//  Strings.swift
//  MyPet
//
//  Created by NikitaKorniuk   on 11.03.25.
//

import Foundation

enum Strings {
    enum Titles {
        static let translator = "Translator"
        static let settings = "Settings"
        static let human = "Human"
        static let pet = "Pet"
        static let procesOfTranslation = "Process of translation..."
        static let result = "Result"
        static let settingsParameters = [
            "Rate Us",
            "Share App",
            "Contact Us",
            "Restore Purchases",
            "Privacy Policy",
            "Terms of Use"
        ]
    }

    enum ButtonTitles {
        static let translator = "Translator"
        static let settings = "Setttings"
        static let startSpeak = "Start Speak"
        static let recording = "Recording..."
    }
    
    enum AnswerPets {
        static let dog = [
            "Oh, you're awake! Great, I wasn't sleeping either, I was waiting for you!",
            "Can I go with you? Anywhere! Even to the bathroom! Even to work!",
            "Have you eaten? And what about me? Can I? Just a little bit? Just a sniff sniff?",
            "This finger is delicious, but your food is even better!",
            "I'm protecting you! From who? From everything! Even from the bag that moved!",
        ]
        static let cat = [
            "Touched me? Who gave you permission?",
            "I'm lying here for a reason. This is important. Very important.",
            "First you pet, then you don't pet... Make up your mind already!",
            "I see your food. I see my food too. But I want yours.",
            "If I'm looking at the wall, it means there's something there... Or maybe you should just relax.",
        ]
    }
}
