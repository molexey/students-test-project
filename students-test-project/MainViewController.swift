//
//  ViewController.swift
//  students-test-project
//
//  Created by molexey on 06.02.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Views
    
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
        view.clipsToBounds = true
        return view
    }()
        
    lazy var stackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 12.0
        return stackView
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
    
    // MARK: - Private properties
    
    private let defaultHeight: CGFloat = 334
    private let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64
    
    private var currentContainerHeight: CGFloat = 334
    private var containerViewHeightConstraint: NSLayoutConstraint?
    private var containerViewBottomConstraint: NSLayoutConstraint?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupPanGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateShowImageView()
        animatePresentContainer()
    }
    
    // MARK: - Actions
    
    @objc func sendButtonTapped() {
        showAlert("Поздравляем!", andAlertMessage: "Ваша заявка успешно отправлена!", andButtonTitle: "Закрыть")
    }
    
    // MARK: - Private methods
    
    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }
        
    @objc private func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        debugPrint("Pan gesture translation.y: \(translation.y)")
        
        let isDraggingDown = translation.y > 0
        debugPrint("Dragging direction: \(isDraggingDown ? "going down" : "going up")")
        
        let newHeight = currentContainerHeight - translation.y
        
        switch gesture.state {
        case .changed:
            if newHeight < maximumContainerHeight {
                containerViewHeightConstraint?.constant = newHeight
                view.layoutIfNeeded()
            }
        case .ended:
            if newHeight < defaultHeight {
                animateContainerHeight(defaultHeight)
            }
            else if newHeight < maximumContainerHeight && isDraggingDown {
                animateContainerHeight(defaultHeight)
            }
            else if newHeight > defaultHeight && !isDraggingDown {
                animateContainerHeight(maximumContainerHeight)
            }
        default:
            break
        }
    }
    
    private func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.containerViewHeightConstraint?.constant = height
            self.view.layoutIfNeeded()
        }
        currentContainerHeight = height
    }
    
    private func animatePresentContainer() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    private func animateShowImageView() {
        imageView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.imageView.alpha = 1.0
        }
    }
    
    private func setupUI() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        view.addSubview(internshipView)
        internshipView.translatesAutoresizingMaskIntoConstraints = false
        internshipView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        internshipView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        internshipView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: internshipView.topAnchor, constant: 24).isActive = true
        stackView.leadingAnchor.constraint(equalTo: internshipView.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: internshipView.trailingAnchor, constant: -20).isActive = true
        
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
        
        containerViewHeightConstraint = internshipView.heightAnchor.constraint(equalToConstant: defaultHeight)
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint = internshipView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: defaultHeight)
        containerViewBottomConstraint?.isActive = true
    }
    
    public func showAlert(_ alertTitle: String? = nil, andAlertMessage alertMessage: String? = nil, andButtonTitle buttonTitle: String? = "Ok", completion: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: alertTitle, message:
            alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: completion))
        present(alertController, animated: true, completion: nil)
    }

}
