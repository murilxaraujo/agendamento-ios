//
//  SignUpPJViewController.swift
//  MaryLimp
//
//  Created by Murilo Oliveira de Araujo on 30/11/18.
//  Copyright © 2018 Murilo Oliveira de Araujo. All rights reserved.
//

import UIKit
import MaterialComponents
import Firebase

class SignUpPJViewController: UIViewController {

    let message: MDCSnackbarMessage
    
    let actindicator: MDCActivityIndicator = {
        let it = MDCActivityIndicator()
        it.translatesAutoresizingMaskIntoConstraints = false
        it.cycleColors = [.white]
        it.sizeToFit()
        return it
    }()
    
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0)
        return view
    }()
    
    let navBar: MDCNavigationBar = {
        let bar = MDCNavigationBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.title = "Cadastro PJ"
        bar.titleTextColor = .white
        bar.backgroundColor = UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0)
        return bar
    }()
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.isScrollEnabled = true
        return sv
    }()
    
    //Elements
    
    let cnpjTextField: MDCTextField = {
        let tf = MDCTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "CNPJ"
        tf.keyboardType = .numberPad
        return tf
    }()
    
    let cnpjTFController: MDCTextInputControllerFilled
    
    let razaosocialTextField: MDCTextField = {
        let tf = MDCTextField()
        tf.placeholder = "Razao social"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .allCharacters
        return tf
    }()
    
    let razaosocialTFController: MDCTextInputControllerFilled
    
    let repTextField: MDCTextField = {
        let tf = MDCTextField()
        tf.placeholder = "Representante legal"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .sentences
        return tf
    }()
    
    let repTFController: MDCTextInputControllerFilled
    
    let cpfTextField: MDCTextField = {
        let tf = MDCTextField()
        tf.placeholder = "CPF representante legal"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.keyboardType = .numberPad
        return tf
    }()
    
    let cpfTFController: MDCTextInputControllerFilled
    
    let emailTextField: MDCTextField = {
        let tf = MDCTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = .emailAddress
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.placeholder = "E-mail"
        return tf
    }()
    
    let emailTFController: MDCTextInputControllerFilled
    
    let phoneTextField: MDCTextField = {
        let tf = MDCTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Telefone"
        tf.keyboardType = .numberPad
        return tf
    }()
    
    let phoneTFController: MDCTextInputControllerFilled
    
    let passwordTextField: MDCTextField = {
        let tf = MDCTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Senha"
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let passwordTFContrller: MDCTextInputControllerFilled
    
    let rptPasswordTextField: MDCTextField = {
        let tf = MDCTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.isSecureTextEntry = true
        tf.placeholder = "Repita a senha"
        return tf
    }()
    
    let rptPasswdTFController: MDCTextInputControllerFilled
    
    let submitBtn: MDCRaisedButton = {
        let btn = MDCRaisedButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Enviar", for: .normal)
        btn.setBackgroundColor(UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0))
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    let returnBtn: MDCFlatButton = {
        let btn = MDCFlatButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Voltar", for: .normal)
        btn.setTitleColor(UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0), for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        view.addSubview(topView)
        topView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        topView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        topView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        topView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        view.addSubview(navBar)
        navBar.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        navBar.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        navBar.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        scrollView.contentSize = CGSize(width: view.frame.width, height: 750)
        
        scrollView.addSubview(cnpjTextField)
        cnpjTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15).isActive = true
        cnpjTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        cnpjTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        
        scrollView.addSubview(razaosocialTextField)
        razaosocialTextField.topAnchor.constraint(equalTo: cnpjTextField.bottomAnchor).isActive = true
        razaosocialTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        razaosocialTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        
        scrollView.addSubview(cpfTextField)
        cpfTextField.topAnchor.constraint(equalTo: razaosocialTextField.bottomAnchor).isActive = true
        cpfTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        cpfTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        
        scrollView.addSubview(repTextField)
        repTextField.topAnchor.constraint(equalTo: cpfTextField.bottomAnchor).isActive = true
        repTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        repTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        
        scrollView.addSubview(phoneTextField)
        phoneTextField.topAnchor.constraint(equalTo: repTextField.bottomAnchor).isActive = true
        phoneTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        phoneTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        
        scrollView.addSubview(emailTextField)
        emailTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        
        scrollView.addSubview(passwordTextField)
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        
        scrollView.addSubview(rptPasswordTextField)
        rptPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        rptPasswordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        rptPasswordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        
        scrollView.addSubview(submitBtn)
        submitBtn.topAnchor.constraint(equalTo: rptPasswordTextField.bottomAnchor, constant: 0).isActive = true
        submitBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        submitBtn.addTarget(self, action: #selector(submit(sender:)), for: .touchUpInside)
        
        scrollView.addSubview(returnBtn)
        returnBtn.topAnchor.constraint(equalTo: rptPasswordTextField.bottomAnchor).isActive = true
        returnBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        returnBtn.addTarget(self, action: #selector(back(sender:)), for: .touchUpInside)
        
        navBar.rightBarButtonItem = UIBarButtonItem(customView: actindicator)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent // .default
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        cnpjTFController = MDCTextInputControllerFilled(textInput: cnpjTextField)
        razaosocialTFController = MDCTextInputControllerFilled(textInput: razaosocialTextField)
        repTFController = MDCTextInputControllerFilled(textInput: repTextField)
        cpfTFController = MDCTextInputControllerFilled(textInput: cpfTextField)
        phoneTFController = MDCTextInputControllerFilled(textInput: phoneTextField)
        emailTFController = MDCTextInputControllerFilled(textInput: emailTextField)
        passwordTFContrller = MDCTextInputControllerFilled(textInput: passwordTextField)
        rptPasswdTFController = MDCTextInputControllerFilled(textInput: rptPasswordTextField)
        message = MDCSnackbarMessage()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @objc func back(sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func submit(sender: Any) {
        if cnpjTextField.text == "" {
            message.text = "Campo CNPJ vazio :("
            MDCSnackbarManager.show(message)
        } else if razaosocialTextField.text == "" {
            message.text = "Campo Razão Social vazio :("
            MDCSnackbarManager.show(message)
        } else if repTextField.text == "" {
            message.text = "Campo Representante Legal vazio :("
            MDCSnackbarManager.show(message)
        } else if cpfTextField.text == "" {
            message.text = "Campo CPF vazio :("
            MDCSnackbarManager.show(message)
        } else if phoneTextField.text == "" {
            message.text = "Campo Telefone vazio :("
            MDCSnackbarManager.show(message)
        } else if emailTextField.text == "" {
            message.text = "Campo E-mail vazio :("
            MDCSnackbarManager.show(message)
        } else if passwordTextField.text == "" {
            message.text = "Campo Senha vazio :("
            MDCSnackbarManager.show(message)
        } else if rptPasswordTextField.text == "" {
            message.text = "Campo Senha vazio :("
            MDCSnackbarManager.show(message)
        } else if passwordTextField.text != rptPasswordTextField.text {
            message.text = "As senhas são diferentes"
            MDCSnackbarManager.show(message)
        } else {
            UIApplication.shared.beginIgnoringInteractionEvents()
            actindicator.startAnimating()
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
                if error != nil {
                    UIApplication.shared.endIgnoringInteractionEvents()
                    self.actindicator.stopAnimating()
                    let alertController = MDCAlertController(title: "Erro: ", message: error!.localizedDescription)
                    let action = MDCAlertAction(title: "OK", handler: { (action) in
                        self.dismiss(animated: true, completion: nil)
                    })
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    Firestore.firestore().collection("users").document(result!.user.uid).setData([
                        "type": 1,
                        "cnpj": self.cnpjTextField.text!,
                        "razao": self.razaosocialTextField.text!,
                        "cpf": self.cpfTextField.text!,
                        "rep": self.repTextField.text!,
                        "email": self.emailTextField.text!,
                        "phone": self.phoneTextField.text!,
                        "creatd": Date()
                        ], completion: { (error1) in
                            if error1 != nil {
                                UIApplication.shared.endIgnoringInteractionEvents()
                                self.actindicator.stopAnimating()
                                let alertController = MDCAlertController(title: "Erro: ", message: error1!.localizedDescription)
                                let action = MDCAlertAction(title: "OK", handler: { (action) in
                                    self.dismiss(animated: true, completion: nil)
                                })
                                alertController.addAction(action)
                                self.present(alertController, animated: true, completion: nil)
                            } else {
                                UIApplication.shared.endIgnoringInteractionEvents()
                                self.actindicator.stopAnimating()
                                let vc = UINavigationController(rootViewController: HomeViewController())
                                vc.isToolbarHidden = true
                                vc.isNavigationBarHidden = true
                                self.present(vc, animated: true, completion: nil)
                            }
                    })
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
