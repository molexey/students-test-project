//
//  ViewController.swift
//  students-test-project
//
//  Created by molexey on 06.02.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Views
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.isScrollEnabled = true
        view.alwaysBounceVertical = false
        view.bounces = false
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "3 6")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var internshipView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 32.0
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 12
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Стажировка в Surf"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .blackSurf
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        label.attributedText = NSMutableAttributedString(string: "Работай над реальными задачами под руководством опытного наставника и получи возможность стать частью команды мечты. ", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .middleGraySurf
       return label
    }()
    
    private lazy var choiceSpecializationView = ChoiceSpecializationView()
    
    private lazy var joinUsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Хочешь к нам?"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .middleGraySurf
        return label
    }()
    
    private lazy var sendButton: PrimaryButton = {
        let button = PrimaryButton()
        button.setTitle("Отправить заявку", for: .normal)
        button.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Actions
    
    @objc func sendButtonTapped() {
        showAlert("Поздравляем!", andAlertMessage: "Ваша заявка успешно отправлена!", andButtonTitle: "Закрыть")
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        contentView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: 0).isActive = true
        
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        
        contentView.addSubview(internshipView)
        internshipView.translatesAutoresizingMaskIntoConstraints = false
        internshipView.heightAnchor.constraint(equalToConstant: 600).isActive = true
        internshipView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -20).isActive = true
        internshipView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        internshipView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        internshipView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        
        internshipView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: internshipView.topAnchor, constant: 24).isActive = true
        stackView.leadingAnchor.constraint(equalTo: internshipView.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: internshipView.trailingAnchor, constant: -20).isActive = true
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)

        internshipView.addSubview(choiceSpecializationView)
        choiceSpecializationView.translatesAutoresizingMaskIntoConstraints = false
        choiceSpecializationView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 12).isActive = true
        choiceSpecializationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        choiceSpecializationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        internshipView.addSubview(sendButton)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 219).isActive = true
        
        internshipView.addSubview(joinUsLabel)
        joinUsLabel.translatesAutoresizingMaskIntoConstraints = false
        joinUsLabel.centerYAnchor.constraint(equalTo: sendButton.centerYAnchor).isActive = true
        joinUsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        joinUsLabel.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -20).isActive = true
    }
    
    public func showAlert(_ alertTitle: String? = nil, andAlertMessage alertMessage: String? = nil, andButtonTitle buttonTitle: String? = "Ok", completion: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: alertTitle, message:
            alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: completion))
        present(alertController, animated: true, completion: nil)
    }

}
