//
//  ChoiceChip.swift
//  students-test-project
//
//  Created by molexey on 07.02.2023.
//

import UIKit

public enum ChoiceChipStyle {
    case selected
    case deselected
    
    var backgroundColor: UIColor {
        switch self {
        case .selected:
            return .blackSurf
        case .deselected:
            return .lightGraySurf
        }
    }
    
    var titleColor: UIColor {
        switch self {
        case .selected:
            return .whiteSurf
        case .deselected:
            return .blackSurf
        }
    }
}

public enum ChoiceChipSize {
    case large
    case medium
    case small
    
    var font: UIFont {
        switch self {
        case .large:
            return UIFont.systemFont(ofSize: 17, weight: .medium)
        case .medium:
            return UIFont.systemFont(ofSize: 14, weight: .medium)
        case .small:
            return UIFont.systemFont(ofSize: 12, weight: .medium)
        }
    }
    
    var contentEdgeInsets: UIEdgeInsets {
        switch self {
        case .large:
            return UIEdgeInsets(top: 12.0, left: 24.0, bottom: 12.0, right: 24.0)
        case .medium:
            return UIEdgeInsets(top: 12.0, left: 24.0, bottom: 12.0, right: 24.0)
        case .small:
            return UIEdgeInsets(top: 4.0, left: 16.0, bottom: 4.0, right: 16.0)
        }
    }
}

class ChoiceChip: UIButton {

    // MARK: - Public properties
        
    var style: ChoiceChipStyle = .deselected {
        didSet {
            applyStyle()
        }
    }
    var size: ChoiceChipSize = .large {
        didSet {
            applyStyle()
        }
    }
        
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.middleGraySurf : style.backgroundColor
        }
    }
    
    // MARK: - Lifecycle
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        applyStyle()
    }
    
    // MARK: - Private methods
    
    private func applyStyle() {
        layer.cornerRadius = 12.0
        contentEdgeInsets = size.contentEdgeInsets
        backgroundColor = style.backgroundColor
        setTitleColor(style.titleColor)
        titleLabel?.font = size.font
    }
}
