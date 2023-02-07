//
//  PrimaryButton.swift
//  students-test-project
//
//  Created by molexey on 07.02.2023.
//

import UIKit

class PrimaryButton: UIButton {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        applyStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        applyStyle()
    }

    // MARK: - Lifecycle
        
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        applyStyle()
    }
}

// MARK: - Extension for styling

extension PrimaryButton {
        
    public func applyStyle() {
        layer.cornerRadius = 30
        backgroundColor = .blackSurf
        setTitleColor(.whiteSurf)
    }
}
