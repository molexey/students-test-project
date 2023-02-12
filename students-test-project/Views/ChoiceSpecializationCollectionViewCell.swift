//
//  ChoiceSpecializationCollectionViewCell.swift
//  students-test-project
//
//  Created by molexey on 12.02.2023.
//

import UIKit

class ChoiceSpecializationCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = String(describing: ChoiceSpecializationCollectionViewCell.self)
    
    // MARK: - Views
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .blackSurf
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: - Public properties
    
    var model: ChoiceSpecializationCollectionCellModel?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    // MARK: - Public methods
    
    func configure(withModel model: ChoiceSpecializationCollectionCellModel) {
        self.model = model
        titleLabel.text = model.title
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        contentView.backgroundColor = .lightGraySurf
        contentView.layer.cornerRadius = 12.0
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24).isActive = true
    }
}
