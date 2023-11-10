//
//  LoginViewController.swift
//  medaxion_sample
//
//  Created by Casey West on 11/9/23.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Properties
    // Holds a reference to the viewModel which will handle the business logic
    var viewModel: LoginViewModelProtocol
    
    // MARK: - UI Components
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Medaxion Sample"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()

    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter username"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor.systemBlue // Choose your desired background color
        button.setTitleColor(UIColor.white, for: .normal) // Set the text color
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 10 // Rounded corners
        button.clipsToBounds = true // Ensures the corners are rounded

        // Optional: Add a shadow or other effects
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 4

        return button
    }()
    
    // MARK: - Lifecycle
    // Dependency Injection via initializer
    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupButtonActions()
    }
    
    // MARK: - Setup Methods
    /// Configures the user interface components and adds them to the view's hierarchy.
    private func setupLayout() {
        view.backgroundColor = .white
        
        // Subviews
        view.addSubview(titleLabel)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        // Disable autoresizing masks
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints for titleLabel
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Constraints for usernameTextField
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Constraints for passwordTextField
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: usernameTextField.heightAnchor)
        ])
        
        // Constraints for loginButton
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: usernameTextField.widthAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    /// Add target actions to the buttons
    private func setupButtonActions() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func loginButtonTapped() {
        // Update the viewModel with the input from the text fields.
        guard usernameTextField.text != "" else {
            self.presentAlert(title: "Error", message: "Please enter a valid username and try again.")
            return
        }
        
        guard passwordTextField.text != "" else {
            self.presentAlert(title: "Error", message: "Please enter a valid password and try again.")
            return
        }
        
        viewModel.username = usernameTextField.text
        viewModel.password = passwordTextField.text

        // Attempt to login using the viewModel.
        viewModel.login { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    // On success, navigate to the HomeViewController.
                    self?.navigateToHome()
                } else {
                    // On failure, show an error alert to the user.
                    self?.showLoginFailedAlert()
                }
            }
        }
    }

    
    //MARK: - Private Functions
    func navigateToHome() {
        // Perform all UI updates on the main thread
        DispatchQueue.main.async {
            // First, attempt to retrieve the scene with a connected window.
            // We filter for active scenes to avoid issues with inactive or background scenes.
            guard let windowScene = UIApplication.shared.connectedScenes
                    .filter({ $0.activationState == .foregroundActive })
                    .first(where: { $0 is UIWindowScene }) as? UIWindowScene else {
                // If there's no active window scene, present an error alert.
                self.presentAlert(title: "Error", message: "Could not find an active window scene.")
                return
            }
            
            // Attempt to find the key window. The key window is the one that is currently receiving user events.
            guard let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
                // If there's no key window, present an error alert.
                self.presentAlert(title: "Error", message: "Could not find a key window.")
                return
            }
            
            // Instantiate your API service
            let marvelApiService = MarvelApiService() // Assuming MarvelApiService conforms to MarvelApiServiceProtocol

            // Create a UICollectionViewLayout instance
            let layout = UICollectionViewFlowLayout() // Customize this layout as needed

            // Create an instance of HomeViewController with the required dependencies
            let homeVC = HomeViewController(marvelApiService: marvelApiService, layout: layout)

            // Create a new navigation controller with the HomeViewController at its root
            let navigationController = UINavigationController(rootViewController: homeVC)
            
            // Animate the transition by cross-dissolving to the new root view controller.
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                // Assign the new navigation controller as the root view controller of the window.
                // This effectively replaces the entire view stack and releases the login view controller from memory.
                window.rootViewController = navigationController
            }, completion: nil) // The completion handler could be used to perform any follow-up actions.
        }
    }
    
    private func showLoginFailedAlert() {
        let alert = UIAlertController(title: "Login Failed", message: "Please check your credentials and try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
}



