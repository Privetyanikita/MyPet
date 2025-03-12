//
//  UIView+Ext.swift
//  MyPet
//
//  Created by NikitaKorniuk   on 10.03.25.
//

import UIKit

extension UIView {
    func add(subviews: UIView...) {
        subviews.forEach(self.addSubview)
    }
}
