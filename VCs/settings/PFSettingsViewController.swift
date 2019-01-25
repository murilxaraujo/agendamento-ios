//
//  PFSettingsViewController.swift
//  MaryLimp
//
//  Created by Murilo Araujo on 04/12/18.
//  Copyright © 2018 Murilo Oliveira de Araujo. All rights reserved.
//

import UIKit
import Firebase
import MaterialComponents

class PFSettingsViewController: UIViewController {

    let snackbar = MDCSnackbarMessage()
    
    var user: PFUser?
    
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
        label.text = "Perfil"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 34.0)
        return label
    }()
    
    let backbtn: MDCFloatingButton = {
        let btn = MDCFloatingButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "baseline_keyboard_arrow_left_black_36pt"), for: .normal)
        btn.backgroundColor = .clear
        btn.setShadowColor(.clear, for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(backit(sender:)), for: .touchUpInside)
        return btn
    }()
    
    let logoffbtn: MDCFloatingButton = {
        let btn = MDCFloatingButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setBackgroundColor(.clear)
        btn.setImageTintColor(.white, for: .normal)
        btn.setShadowColor(.clear, for: .normal)
        btn.setImage(UIImage(named: "baseline_exit_to_app_black_36pt"), for: .normal)
        btn.addTarget(self, action: #selector(logoff(sender:)), for: .touchUpInside)
        return btn
    }()
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let firstNameTextField: MDCTextField = {
        let tf = MDCTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Nome"
        tf.isEnabled = false
        return tf
    }()
    
    let firstnameTFController: MDCTextInputControllerFilled
    
    let surnameTextField: MDCTextField = {
        let tf = MDCTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Sobrenome"
        tf.isEnabled = false
        return tf
    }()
    
    let surnameTFController: MDCTextInputControllerFilled
    
    let cpfTextField: MDCTextField = {
        let tf = MDCTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "CPF"
        tf.keyboardType = .numberPad
        tf.isEnabled = false
        return tf
    }()
    
    let cpfTFController: MDCTextInputControllerFilled
    
    let phoneTextField: MDCTextField = {
        let tf = MDCTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Telefone"
        tf.keyboardType = .numberPad
        tf.isEnabled = false
        return tf
    }()
    
    let phoneTFController: MDCTextInputControllerFilled
    
    let emailTextField: MDCTextField = {
        let tf = MDCTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = .emailAddress
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.placeholder = "E-mail"
        tf.isEnabled = false
        return tf
    }()
    
    let emailTFController: MDCTextInputControllerFilled
    
    let passwordTextField: MDCTextField = {
        let tf = MDCTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Senha"
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.isSecureTextEntry = true
        tf.isEnabled = false
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
        tf.isEnabled = false
        return tf
    }()
    
    let rptpsswrdTFController: MDCTextInputControllerFilled
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        view.backgroundColor = .white
        
        view.addSubview(topView)
        topView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        topView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        topView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        topView.addSubview(loginLabel)
        loginLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 15).isActive = true
        loginLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -15).isActive = true
        
        topView.addSubview(actindicator)
        actindicator.centerYAnchor.constraint(equalTo: loginLabel.centerYAnchor).isActive = true
        actindicator.leftAnchor.constraint(equalTo: loginLabel.rightAnchor, constant: 15).isActive = true
        
        topView.addSubview(backbtn)
        backbtn.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        backbtn.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        
        topView.addSubview(logoffbtn)
        logoffbtn.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -15).isActive = true
        logoffbtn.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.contentSize = CGSize(width: view.frame.width, height: 400)
        
        scrollView.addSubview(firstNameTextField)
        firstNameTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15).isActive = true
        firstNameTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15).isActive = true
        firstNameTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -35).isActive = true
        
        scrollView.addSubview(surnameTextField)
        surnameTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15).isActive = true
        surnameTextField.leftAnchor.constraint(equalTo: firstNameTextField.rightAnchor, constant: 15).isActive = true
        surnameTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15).isActive = true
        
        scrollView.addSubview(cpfTextField)
        cpfTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor).isActive = true
        cpfTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15).isActive = true
        cpfTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15).isActive = true
        
        scrollView.addSubview(phoneTextField)
        phoneTextField.topAnchor.constraint(equalTo: cpfTextField.bottomAnchor).isActive = true
        phoneTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15).isActive = true
        phoneTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15).isActive = true
        
        scrollView.addSubview(emailTextField)
        emailTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        
        getData()
    }
    
    @objc func backit(sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func logoff(sender: Any) {
        
        let alertController = MDCAlertController(title: "Opa!", message: "Você quer mesmo sair?")
        let action = MDCAlertAction(title: "sim", handler: { (action) in
            do {
                try Auth.auth().signOut()
                UIApplication.shared.endIgnoringInteractionEvents()
                self.actindicator.stopAnimating()
                self.present(LoginViewController(), animated: true, completion: nil)
            } catch let err {
                print(err)
            }
        })
        let action2 = MDCAlertAction(title: "Não") { (actionn) in

        }
        
        alertController.addAction(action)
        alertController.addAction(action2)
        
        self.present(alertController, animated: true, completion: nil)
        
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        actindicator.startAnimating()
        do {
            try Auth.auth().signOut()
            UIApplication.shared.endIgnoringInteractionEvents()
            actindicator.stopAnimating()
            self.present(LoginViewController(), animated: true, completion: nil)
        } catch let err {
            print(err)
        }
    }
    
    func getData() {
        actindicator.startAnimating()
        
        Firestore.firestore().collection("users").document(Auth.auth().currentUser!.uid).getDocument { (snapshot, error) in
            if error != nil {
                //There was an error
            } else {
                if snapshot!.exists {
                    self.user = PFUser(uid: Auth.auth().currentUser!.uid,
                                       cpf: (snapshot!.get("cpf") as! String),
                                       email: (snapshot!.get("email") as! String),
                                       name: ["first": snapshot!.get("fname") as! String,
                                              "sur": snapshot!.get("sname") as! String,
                                              "full": "\(snapshot!.get("fname") as! String) \(snapshot!.get("sname") as! String)"],
                                       phone: (snapshot!.get("phone") as! String))
                    
                    self.firstNameTextField.text = self.user!.name["first"]
                    self.surnameTextField.text = self.user!.name["sur"]
                    self.cpfTextField.text = self.user!.cpf
                    self.phoneTextField.text = self.user!.phone
                    self.emailTextField.text = self.user!.email
                    
                } else {
                    //Document does not exist
                    
                }
            }
        }
        
        actindicator.stopAnimating()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent // .default
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        emailTFController = MDCTextInputControllerFilled(textInput: emailTextField)
        passwordTFContrller = MDCTextInputControllerFilled(textInput: passwordTextField)
        firstnameTFController = MDCTextInputControllerFilled(textInput: firstNameTextField)
        surnameTFController = MDCTextInputControllerFilled(textInput: surnameTextField)
        cpfTFController = MDCTextInputControllerFilled(textInput: cpfTextField)
        phoneTFController = MDCTextInputControllerFilled(textInput: phoneTextField)
        rptpsswrdTFController = MDCTextInputControllerFilled(textInput: rptPasswordTextField)
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
