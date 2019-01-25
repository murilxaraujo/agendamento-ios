//
//  LoginViewController.swift
//  MaryLimp
//
//  Created by Murilo Oliveira de Araujo on 22/11/18.
//  Copyright © 2018 Murilo Oliveira de Araujo. All rights reserved.
//

import UIKit
import MaterialComponents.MDCTextInput
import MaterialComponents.MDCButton
import MaterialComponents.MDCActivityIndicator
import FirebaseAuth
import MaterialComponents.MaterialSnackbar

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //Elements
    let snackbar = MDCSnackbarMessage()
    
    let actindicator: MDCActivityIndicator = {
        let it = MDCActivityIndicator()
        it.translatesAutoresizingMaskIntoConstraints = false
        it.cycleColors = [.white]
        return it
    }()
    
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0)
        return view
    }()
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 34.0)
        return label
    }()
    
    let emailTextField: MDCTextField = {
        let tf = MDCTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = .emailAddress
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.placeholder = "E-mail"
        return tf
    }()
    
    let passwordTextField: MDCTextField = {
        let tf = MDCTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.isSecureTextEntry = true
        tf.placeholder = "Senha"
        return tf
    }()
    
    let forgotPassBtn: MDCFlatButton = {
        let button = MDCFlatButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Esqueci minha senha", for: .normal)
        button.setTitleColor(UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0), for: .normal)
        button.addTarget(self, action: #selector(forgPassWord(sender:)), for: .touchUpInside)
        return button
    }()
    
    let nextButton: MDCRaisedButton = {
        let nextButton = MDCRaisedButton()
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Entrar", for: .normal)
        nextButton.addTarget(self, action: #selector(login(sender:)), for: .touchUpInside)
        nextButton.backgroundColor = UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0)
        return nextButton
    }()
    
    let signupBtn: MDCFlatButton = {
        let button = MDCFlatButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Criar conta", for: .normal)
        button.setTitleColor(UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0), for: .normal)
        button.addTarget(self, action: #selector(signup(sender:)), for: .touchUpInside)
        return button
    }()
    
    let usernameTextFieldController: MDCTextInputControllerOutlined
    let passwordTextFieldController: MDCTextInputControllerOutlined

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        usernameTextFieldController = MDCTextInputControllerOutlined(textInput: emailTextField)
        passwordTextFieldController = MDCTextInputControllerOutlined(textInput: passwordTextField)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Funcs
    
    func setup() {
        //Sets up view elements
        
        self.view.backgroundColor = .white
        
        view.addSubview(topView)
        topView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        topView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        topView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        topView.addSubview(loginLabel)
        loginLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -20).isActive = true
        loginLabel.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 20).isActive = true
        
        view.addSubview(emailTextField)
        emailTextField.delegate = self
        emailTextField.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 15).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 15).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -15).isActive = true
        
        view.addSubview(passwordTextField)
        passwordTextField.delegate = self
        passwordTextField.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 15).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -15).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 0).isActive = true
        
        view.addSubview(forgotPassBtn)
        forgotPassBtn.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 15).isActive = true
        forgotPassBtn.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 0).isActive = true
        
        view.addSubview(nextButton)
        nextButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -15).isActive = true
        nextButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 0).isActive = true
        
        view.addSubview(signupBtn)
        signupBtn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        signupBtn.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        topView.addSubview(actindicator)
        actindicator.centerYAnchor.constraint(equalTo: loginLabel.centerYAnchor).isActive = true
        actindicator.leftAnchor.constraint(equalTo: loginLabel.rightAnchor, constant: 15).isActive = true
    }
    
    @objc func login(sender: Any) {
        if emailTextField.text == "" || emailTextField.text == nil {
            snackbar.text = "Opa! Parece que o campo de e-mail está vazio!"
            MDCSnackbarManager.show(snackbar)
        } else if passwordTextField.text == "" || passwordTextField.text == nil {
            snackbar.text = "Opa! Parece que o campo de senha está vazio!"
            MDCSnackbarManager.show(snackbar)
        } else {
            UIApplication.shared.beginIgnoringInteractionEvents()
            actindicator.startAnimating()
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (res, err) in
                if err != nil {
                    UIApplication.shared.endIgnoringInteractionEvents()
                    self.actindicator.stopAnimating()
                    self.snackbar.text = "Erro: \(err!.localizedDescription)"
                    MDCSnackbarManager.show(self.snackbar)
                } else {
                    self.actindicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    let vc = UINavigationController(rootViewController: HomeViewController())
                    vc.isToolbarHidden = true
                    vc.isNavigationBarHidden = true
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func signup(sender: Any) {
        present(SignupTabViewController(), animated: true, completion: nil)
    }
    
    @objc func forgPassWord(sender: Any) {
        present(ResetPasswordViewController(), animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent // .default
    }
    
}
