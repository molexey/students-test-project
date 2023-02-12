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
        view.decelerationRate = UIScrollView.DecelerationRate(rawValue: CGFloat(0.0))
        view.delegate = self
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
    
    private let specializations = ["iOS", "Android", "Design", "Flutter", "QA", "PM", "0123456789"]
    private let thresholdX = 12.0
    private var selectedChip: String?
    private var isEndOfScroll = false
    private var allTranslationX = 0.0
    
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
        if let title = sender.titleLabel?.text {
            selectedChip = title
            selectChip(title)
        }
        
        if let index = stackView.arrangedSubviews.firstIndex(of: (sender)) {
            moveChipToFirstPos(index: index)
        }
    }
    
    // MARK: - Private methods
    
    private func selectChip(_ specialization: String) {
        for chip in specializationСhips {
            chip.style = chip.titleLabel?.text == specialization ? .selected : .deselected
        }
    }
    
    private func moveChipToFirstPos(index: Int) {
            UIView.animate(withDuration: 0.25) { [weak self] () -> Void in
                self?.stackView.arrangedSubviews.prefix(index).forEach { [weak self] chip in
                    chip.alpha = 0
                    self?.stackView.addArrangedSubview(chip)
                    self?.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
                    chip.alpha = 1
            }
        }
    }
    
    private func firstToLast() {
        guard let firstView = stackView.arrangedSubviews.first else { return }
        firstView.alpha = 0.0
        stackView.addArrangedSubview(firstView)
        stackView.layoutIfNeeded()
        scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x - firstView.frame.width - stackView.spacing, y: 0), animated: false)
        debugPrint("scrollView.contentOffset \(scrollView.contentOffset)")
        UIView.animate(withDuration: 0.25) { () -> Void in
            firstView.alpha = 1.0
        }
    }
    
    private func lastToFirst() {
        guard let lastView = stackView.arrangedSubviews.last else { return }
        lastView.alpha = 0.0
        stackView.insertArrangedSubview(lastView, at: 0)
        stackView.layoutIfNeeded()
        scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x + lastView.frame.width + stackView.spacing, y: 0), animated: false)
        debugPrint("scrollView.contentOffset \(scrollView.contentOffset)")
        UIView.animate(withDuration: 0.25) { () -> Void in
            lastView.alpha = 1.0
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

extension ChoiceSpecializationView: UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        allTranslationX = 0.0
        debugPrint("scrollViewDidEndDragging")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maxOffset = scrollView.contentSize.width - scrollView.frame.size.width
        let isEndOfContent = scrollView.contentOffset.x >= maxOffset
        let isStartOfContent = scrollView.contentOffset.x < 0
        let translationX = scrollView.panGestureRecognizer.translation(in: scrollView.superview).x
        debugPrint("translationX \(translationX)")
        debugPrint("allTranslationX \(allTranslationX)")
        
        if (translationX - allTranslationX).magnitude >= thresholdX {
            allTranslationX = translationX
        
            if isEndOfContent { firstToLast() }
            if isStartOfContent { lastToFirst() }
        }
    }
    
}
