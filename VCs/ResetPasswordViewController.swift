//
//  ResetPasswordViewController.swift
//  MaryLimp
//
//  Created by Murilo Oliveira de Araujo on 27/11/18.
//  Copyright © 2018 Murilo Oliveira de Araujo. All rights reserved.
//

import UIKit
import FirebaseAuth
import MaterialComponents.MDCSnackbarMessage
import MaterialComponents.MDCTextInput
import MaterialComponents.MDCButton
import MaterialComponents.MaterialDialogs
import MaterialComponents.MDCActivityIndicator

class ResetPasswordViewController: UIViewController {
    
    let actindicator: MDCActivityIndicator = {
        let it = MDCActivityIndicator()
        it.translatesAutoresizingMaskIntoConstraints = false
        it.cycleColors = [.white]
        return it
    }()
    
    let message = MDCSnackbarMessage()
    
    let topview: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0)
        return view
    }()
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Redefinir senha"
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 34.0)
        return label
    }()
    
    let emailTextView: MDCTextField = {
        let tv = MDCTextField()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.placeholder = "E-mail"
        tv.keyboardType = .emailAddress
        tv.autocorrectionType = .no
        tv.autocapitalizationType = .none
        return tv
    }()
    
    let emailtvcontroller: MDCTextInputControllerOutlined

    let submitBtn: MDCRaisedButton = {
        let btn = MDCRaisedButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Enviar", for: .normal)
        btn.setBackgroundColor(UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0))
        btn.addTarget(self, action: #selector(submit(sender:)), for: .touchUpInside)
        return btn
    }()
    
    let dismissBtn: MDCFloatingButton = {
        let btn = MDCFloatingButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setBackgroundColor(.white)
        btn.sizeToFit()
        btn.setImageTintColor(UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0), for: .normal)
        btn.addTarget(self, action: #selector(dismissit(sender:)), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }

    func setup() {
        view.backgroundColor = .white
        
        view.addSubview(topview)
        topview.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        topview.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        topview.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        topview.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        view.addSubview(loginLabel)
        loginLabel.bottomAnchor.constraint(equalTo: topview.bottomAnchor, constant: -15).isActive = true
        loginLabel.leftAnchor.constraint(equalTo: topview.leftAnchor, constant: 15).isActive = true
        loginLabel.rightAnchor.constraint(equalTo: topview.rightAnchor, constant: -15).isActive = true
        
        view.addSubview(emailTextView)
        emailTextView.topAnchor.constraint(equalTo: topview.bottomAnchor, constant: 15).isActive = true
        emailTextView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 15).isActive = true
        emailTextView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -15).isActive = true
        
        view.addSubview(submitBtn)
        submitBtn.topAnchor.constraint(equalTo: emailTextView.bottomAnchor, constant: 0).isActive = true
        submitBtn.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -15).isActive = true
    
        topview.addSubview(dismissBtn)
        dismissBtn.setImage(UIImage(named: "round_keyboard_arrow_down_black_48pt"), for: .normal)
        dismissBtn.rightAnchor.constraint(equalTo: topview.rightAnchor, constant: -15).isActive = true
        dismissBtn.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        dismissBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        dismissBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        topview.addSubview(actindicator)
        actindicator.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        actindicator.leftAnchor.constraint(equalTo: topview.leftAnchor, constant: 20).isActive = true
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        emailtvcontroller = MDCTextInputControllerOutlined(textInput: emailTextView)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent // .default
    }
    
    //Func
    
    @objc func submit(sender: Any) {
        if emailTextView.text == "" || emailTextView.text == nil {
            message.text = "Opa! O campo de e-mail está vazio."
            MDCSnackbarManager.show(message)
        } else {
            UIApplication.shared.beginIgnoringInteractionEvents()
            actindicator.startAnimating()
            Auth.auth().sendPasswordReset(withEmail: emailTextView.text!) { (err) in
                if err != nil {
                    UIApplication.shared.endIgnoringInteractionEvents()
                    self.actindicator.stopAnimating()
                    self.message.text = "Erro: \(err!.localizedDescription)"
                    MDCSnackbarManager.show(self.message)
                } else {
                    UIApplication.shared.endIgnoringInteractionEvents()
                    self.actindicator.stopAnimating()
                    let alertController = MDCAlertController(title: "Pronto!", message: "Você receberá um email para redefinir sua senha")
                    let action = MDCAlertAction(title: "OK", handler: { (action) in
                        self.dismiss(animated: true, completion: nil)
                    })
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func dismissit(sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
