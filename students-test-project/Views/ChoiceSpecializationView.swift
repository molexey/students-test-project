//
//  ChoiceChipsView.swift
//  students-test-project
//
//  Created by molexey on 07.02.2023.
//

import UIKit

class ChoiceSpecializationView: UIView {

// MARK: - Views
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.isScrollEnabled = true
        view.alwaysBounceVertical = false
        view.alwaysBounceHorizontal = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: specializationСhips)
        view.axis = .horizontal
        view.spacing = 12
        return view
    }()
    
    private lazy var specializationСhips: [ChoiceChip] = {
        var chips: [ChoiceChip] = []
        for specialization in specializations {
            let chip = ChoiceChip()
            chip.setTitle(specialization, for: .normal)
            chip.size = .medium
            chip.addTarget(self, action: #selector(choiceChipTapped), for: .touchUpInside)
            chips.append(chip)
        }
        return chips
    }()
    
    // MARK: - Private properties
    
    private let specializations = ["iOS", "Android", "Design", "Flutter", "QA", "PM"]
    private var selectedChip: String?
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)

        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc func choiceChipTapped(_ sender: ChoiceChip) {
        if let index = specializationСhips.firstIndex(of: (sender)) {
            let offset = specializationСhips.prefix(index).reduce(0, { offset, chip in
                offset + chip.frame.width + 12
            })
            scrollView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
        }
        
        if let title = sender.titleLabel?.text {
            selectedChip = title
            selectChip(title)
        }
    }
    
    // MARK: - Private methods
    
    private func selectChip(_ specialization: String) {
        for chip in specializationСhips {
            chip.style = chip.titleLabel?.text == specialization ? .selected : .deselected
        }
    }
    
    private func setupUI() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
//        stackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
    }

}
