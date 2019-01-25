//
//  PJSettingsViewController.swift
//  MaryLimp
//
//  Created by Murilo Araujo on 04/12/18.
//  Copyright © 2018 Murilo Oliveira de Araujo. All rights reserved.
//

import UIKit
import Firebase
import MaterialComponents

class PJSettingsViewController: UIViewController {

    let snackbar = MDCSnackbarMessage()
    
    var user: PJUser?
    
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
        sv.isScrollEnabled = true
        return sv
    }()
    
    let cnpjTextField: MDCTextField = {
        let tf = MDCTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "CNPJ"
        tf.keyboardType = .numberPad
        tf.isEnabled = false
        return tf
    }()
    
    let cnpjTFController: MDCTextInputControllerFilled
    
    let razaosocialTextField: MDCTextField = {
        let tf = MDCTextField()
        tf.placeholder = "Razao social"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .allCharacters
        tf.isEnabled = false
        return tf
    }()
    
    let razaosocialTFController: MDCTextInputControllerFilled
    
    let repTextField: MDCTextField = {
        let tf = MDCTextField()
        tf.placeholder = "Representante legal"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .sentences
        tf.isEnabled = false
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
        tf.isEnabled = false
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
        tf.isEnabled = false
        return tf
    }()
    
    let emailTFController: MDCTextInputControllerFilled
    
    let phoneTextField: MDCTextField = {
        let tf = MDCTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Telefone"
        tf.keyboardType = .numberPad
        tf.isEnabled = false
        return tf
    }()
    
    let phoneTFController: MDCTextInputControllerFilled
    
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
        scrollView.contentSize = CGSize(width: view.frame.width, height: 500)
        
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
                    self.user = PJUser(uid: Auth.auth().currentUser!.uid,
                                       cpf: (snapshot!.get("cpf") as! String),
                                       cnpj: (snapshot!.get("cnpj") as! String),
                                       email: Auth.auth().currentUser!.email!,
                                       razao: (snapshot!.get("razao") as! String),
                                       phone: (snapshot!.get("phone") as! String),
                                       rep: (snapshot!.get("rep") as! String))
                    
                    self.cnpjTextField.text = self.user!.cnpj
                    self.razaosocialTextField.text = self.user!.razao
                    self.cpfTextField.text = self.user!.cpf
                    self.phoneTextField.text = self.user!.phone
                    self.emailTextField.text = self.user!.email
                    self.repTextField.text = self.user!.rep
                    
                } else {
                    //Document does not exist
                    
                }
            }
        }
        
        actindicator.stopAnimating()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        cnpjTFController = MDCTextInputControllerFilled(textInput: cnpjTextField)
        razaosocialTFController = MDCTextInputControllerFilled(textInput: razaosocialTextField)
        repTFController = MDCTextInputControllerFilled(textInput: repTextField)
        cpfTFController = MDCTextInputControllerFilled(textInput: cpfTextField)
        phoneTFController = MDCTextInputControllerFilled(textInput: phoneTextField)
        emailTFController = MDCTextInputControllerFilled(textInput: emailTextField)
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent // .default
    }

}
