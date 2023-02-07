//
//  UIButton.swift
//  students-test-project
//
//  Created by molexey on 07.02.2023.
//

import UIKit

public extension UIButton {
    
    func setTitle(_ title: String?) {
        setTitle(title, for: .normal)
        setTitle(title, for: .highlighted)
        setTitle(title, for: .disabled)
    }
    
    func setAttributedTitle(_ title: NSAttributedString?) {
        setAttributedTitle(title, for: .normal)
        setAttributedTitle(title, for: .highlighted)
        setAttributedTitle(title, for: .disabled)
    }
    
    func setImage(_ image: UIImage?) {
        setImage(image, for: .normal)
        setImage(image, for: .highlighted)
        setImage(image, for: .disabled)
    }
    
    func setTitleColor(_ color: UIColor?) {
        setTitleColor(color, for: .normal)
        setTitleColor(color, for: .highlighted)
        setTitleColor(color, for: .disabled)
    }
}
