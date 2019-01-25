//
//  NewAddressViewController.swift
//  MaryLimp
//
//  Created by Murilo Araujo on 04/12/18.
//  Copyright © 2018 Murilo Oliveira de Araujo. All rights reserved.
//

import UIKit
import MaterialComponents
import Firebase
import Lottie
import JTMaterialSwitch
import Alamofire

class NewAddressViewController: UIViewController, UIScrollViewDelegate {
    
    //info
    var placetype: Int? = nil
    var metragem: Int? = nil
    var banheiros: Int? = nil
    
    //Elements
    let pageControl: MDCPageControl = {
        let pc = MDCPageControl()
        pc.numberOfPages = 6
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    let numberofpages = 6
    
    // Scroll view
    let sv: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.isPagingEnabled = true
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        sv.isScrollEnabled = false
        return sv
    }()
    
    let metragemTextView: MDCTextField = {
        let tf = MDCTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = .numberPad
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.placeholder = "m²"
        return tf
    }()
    
    let metragemTFControler: MDCTextInputControllerOutlined
    
    let cepTextField: MDCTextField = {
        let tf = MDCTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = .numberPad
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.placeholder = "CEP"
        return tf
    }()
    
    let cepTFControler: MDCTextInputControllerFilled
    
    let loadingIndicator: MDCActivityIndicator = {
        let li = MDCActivityIndicator()
        li.translatesAutoresizingMaskIntoConstraints = false
        li.cycleColors = [UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0)]
        return li
    }()
    
    let uploadIndicator: MDCActivityIndicator = {
        let li = MDCActivityIndicator()
        li.translatesAutoresizingMaskIntoConstraints = false
        li.cycleColors = [UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0)]
        return li
    }()
    
    let searchCEPButton: MDCFlatButton = {
        let btn = MDCFlatButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImageTintColor(UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0), for: .normal)
        btn.image
        btn.setImage(UIImage(named: "round_search_black_36pt"), for: .normal)
        btn.addTarget(self, action: #selector(getCEP(sender:)), for: .touchUpInside)
        return btn
    }()
    
    let logradouroTextField: MDCTextField = {
        let tf = MDCTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.placeholder = "Logradouro"
        tf.isEnabled = false
        return tf
    }()
    
    let logradouroTFControler: MDCTextInputControllerFilled
    
    let numberTextField: MDCTextField = {
        let tf = MDCTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = .numberPad
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.placeholder = "Nº"
        tf.isEnabled = false
        tf.clearButtonMode = .never
        return tf
    }()
    
    let numberTFControler: MDCTextInputControllerFilled

    let complementoTextField: MDCTextField = {
        let tf = MDCTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.placeholder = "Complemento"
        tf.isEnabled = false
        return tf
    }()
    
    let complementoTFControler: MDCTextInputControllerFilled
    
    let bairroTextField: MDCTextField = {
        let tf = MDCTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.placeholder = "Bairro"
        tf.isEnabled = false
        return tf
    }()
    
    let bairroTFController: MDCTextInputControllerFilled
    
    let cityTextField: MDCTextField = {
        let tf = MDCTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.placeholder = "Cidade"
        tf.isEnabled = false
        return tf
    }()
    
    let cityTFControler: MDCTextInputControllerFilled
    
    let estadoTextField: MDCTextField = {
        let tf = MDCTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .allCharacters
        tf.placeholder = "Estado"
        tf.isEnabled = false
        return tf
    }()
    
    let estadoTFControler: MDCTextInputControllerFilled
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    func setup() {
        view.backgroundColor = .white
        
        view.addSubview(sv)
        sv.backgroundColor = .white
        sv.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        sv.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        sv.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        sv.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        sv.contentSize = CGSize(width: view.frame.width * CGFloat(numberofpages), height: view.frame.height-200)
        sv.delegate = self
        
        view.addSubview(pageControl)
        pageControl.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        pageControl.addTarget(self, action: #selector(didChangePage), for: .valueChanged)
        pageControl.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        
        let firstView: UIView = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            return v
        }()
        
        sv.addSubview(firstView)
        firstView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        firstView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        firstView.topAnchor.constraint(equalTo: sv.topAnchor).isActive = true
        firstView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        
        let secondView: UIView = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.isUserInteractionEnabled = true
            return v
        }()
        
        sv.addSubview(secondView)
        secondView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        secondView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        secondView.topAnchor.constraint(equalTo: sv.topAnchor).isActive = true
        secondView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        secondView.leftAnchor.constraint(equalTo: firstView.rightAnchor).isActive = true

        let thirdView: UIView = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            return v
        }()
        
        sv.addSubview(thirdView)
        thirdView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        thirdView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        thirdView.topAnchor.constraint(equalTo: sv.topAnchor).isActive = true
        thirdView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        thirdView.leftAnchor.constraint(equalTo: secondView.rightAnchor).isActive = true
        
        let fourthView: UIView = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            return v
        }()
        
        sv.addSubview(fourthView)
        fourthView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        fourthView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        fourthView.topAnchor.constraint(equalTo: sv.topAnchor).isActive = true
        fourthView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        fourthView.leftAnchor.constraint(equalTo: thirdView.rightAnchor).isActive = true
        
        let fifthView: UIView = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            return v
        }()
        
        sv.addSubview(fifthView)
        fifthView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        fifthView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        fifthView.topAnchor.constraint(equalTo: sv.topAnchor).isActive = true
        fifthView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        fifthView.leftAnchor.constraint(equalTo: fourthView.rightAnchor).isActive = true
        
        let sixView: UIView = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            return v
        }()
        
        sv.addSubview(sixView)
        sixView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        sixView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        sixView.topAnchor.constraint(equalTo: sv.topAnchor).isActive = true
        sixView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        sixView.leftAnchor.constraint(equalTo: fifthView.rightAnchor).isActive = true
        
        //FirstViewsetup
        
        let animation: LOTAnimationView = {
            let lot = LOTAnimationView(name: "building_evolution_animation")
            lot.translatesAutoresizingMaskIntoConstraints = false
            lot.contentMode = .scaleAspectFit
            return lot
        }()
        
        firstView.addSubview(animation)
        animation.bottomAnchor.constraint(equalTo: firstView.centerYAnchor).isActive = true
        animation.leftAnchor.constraint(equalTo: firstView.leftAnchor, constant: 20).isActive = true
        animation.rightAnchor.constraint(equalTo: firstView.rightAnchor, constant: -20).isActive = true
        animation.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        let firstTitle: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Cadastre seu imóvel"
            label.font = UIFont.boldSystemFont(ofSize: 34.0)
            label.textAlignment = .center
            return label
        }()
        
        firstView.addSubview(firstTitle)
        firstTitle.topAnchor.constraint(equalTo: animation.bottomAnchor, constant: 30).isActive = true
        firstTitle.leftAnchor.constraint(equalTo: firstView.leftAnchor, constant: 20).isActive = true
        firstTitle.rightAnchor.constraint(equalTo: firstView.rightAnchor, constant: -20).isActive = true
        
        let closebtn: MDCFlatButton = {
            let btn = MDCFlatButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("Voltar", for: .normal)
            btn.setTitleColor(.darkGray, for: .normal)
            return btn
        }()
        
        firstView.addSubview(closebtn)
        closebtn.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        closebtn.leftAnchor.constraint(equalTo: firstView.leftAnchor, constant: 15).isActive = true
        closebtn.addTarget(self, action: #selector(closeit(sender:)), for: .touchUpInside)
        
        let startbtn: MDCRaisedButton = {
            let btn = MDCRaisedButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("Começar", for: .normal)
            btn.setBackgroundColor(UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0))
            btn.setTitleColor(.white, for: .normal)
            return btn
        }()
        
        firstView.addSubview(startbtn)
        startbtn.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -40).isActive = true
        startbtn.centerXAnchor.constraint(equalTo: firstView.centerXAnchor).isActive = true
        startbtn.tag = 2
        startbtn.addTarget(self, action: #selector(gotoPage(sender:)), for: .touchUpInside)
        
        animation.play()
        
        //Second view setup
        
        let secondTitle: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Selecione o tipo de imóvel"
            label.font = UIFont.boldSystemFont(ofSize: 34.0)
            label.numberOfLines = 0
            return label
        }()
        
        secondView.addSubview(secondTitle)
        secondTitle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        secondTitle.leftAnchor.constraint(equalTo: secondView.leftAnchor, constant: 20).isActive = true
        secondTitle.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -20).isActive = true
        
        let backbutton1: MDCFlatButton = {
            let btn = MDCFlatButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("Voltar", for: .normal)
            btn.tag = 1
            btn.addTarget(self, action: #selector(gotoPage(sender:)), for: .touchUpInside)
            return btn
        }()
        
        secondView.addSubview(backbutton1)
        backbutton1.leftAnchor.constraint(equalTo: secondView.leftAnchor, constant: 20).isActive = true
        backbutton1.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -20).isActive = true
        
        let comercialbutton: MDCRaisedButton = {
            let btn = MDCRaisedButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("Escritório", for: .normal)
            btn.setBackgroundColor(UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0))
            btn.setTitleColor(.white, for: .normal)
            btn.addTarget(self, action: #selector(comercialPressed(sender:)), for: .touchUpInside)
            return btn
        }()
        
        secondView.addSubview(comercialbutton)
        comercialbutton.topAnchor.constraint(equalTo: secondView.centerYAnchor, constant: -40).isActive = true
        comercialbutton.leftAnchor.constraint(equalTo: secondView.leftAnchor, constant: 20).isActive = true
        comercialbutton.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -20).isActive = true
        comercialbutton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let residencialbutton: MDCRaisedButton = {
            let btn = MDCRaisedButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("Residência", for: .normal)
            btn.setBackgroundColor(UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0))
            btn.setTitleColor(.white, for: .normal)
            btn.addTarget(self, action: #selector(residencialPressed(sender:)), for: .touchUpInside)
            return btn
        }()
        
        secondView.addSubview(residencialbutton)
        residencialbutton.bottomAnchor.constraint(equalTo: comercialbutton.topAnchor, constant: -20).isActive = true
        residencialbutton.leftAnchor.constraint(equalTo: secondView.leftAnchor, constant: 20).isActive = true
        residencialbutton.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -20).isActive = true
        residencialbutton.heightAnchor.constraint(equalToConstant: 50).isActive  = true
        
        let outrosbutton: MDCRaisedButton = {
            let btn = MDCRaisedButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("Outros*", for: .normal)
            btn.setBackgroundColor(UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0))
            btn.setTitleColor(.white, for: .normal)
            btn.addTarget(self, action: #selector(othersPressed(sender:)), for: .touchUpInside)
            return btn
        }()
        
        secondView.addSubview(outrosbutton)
        outrosbutton.topAnchor.constraint(equalTo: comercialbutton.bottomAnchor, constant: 20).isActive = true
        outrosbutton.leftAnchor.constraint(equalTo: comercialbutton.leftAnchor).isActive = true
        outrosbutton.rightAnchor.constraint(equalTo: comercialbutton.rightAnchor).isActive = true
        outrosbutton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let outroslabel: UILabel = {
            let it = UILabel()
            it.translatesAutoresizingMaskIntoConstraints = false
            it.text = "* Consultório, loja, empresa, condomínio, eventos"
            it.numberOfLines = 0
            it.textAlignment = .center
            it.textColor = .lightGray
            return it
        }()
        
        secondView.addSubview(outroslabel)
        outroslabel.topAnchor.constraint(equalTo: outrosbutton.bottomAnchor, constant: 10).isActive = true
        outroslabel.leftAnchor.constraint(equalTo: outrosbutton.leftAnchor).isActive = true
        outroslabel.rightAnchor.constraint(equalTo: outrosbutton.rightAnchor).isActive = true
        
        //Third view setup
        
        let thirdTitle: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Selecione a metragem do imóvel"
            label.font = UIFont.boldSystemFont(ofSize: 34.0)
            label.numberOfLines = 0
            return label
        }()
        
        thirdView.addSubview(thirdTitle)
        thirdTitle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        thirdTitle.leftAnchor.constraint(equalTo: thirdView.leftAnchor, constant: 20).isActive = true
        thirdTitle.rightAnchor.constraint(equalTo: thirdView.rightAnchor, constant: -20).isActive = true
        
        let backbutton2: MDCFlatButton = {
            let btn = MDCFlatButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("Voltar", for: .normal)
            btn.tag = 2
            btn.addTarget(self, action: #selector(gotoPage(sender:)), for: .touchUpInside)
            return btn
        }()
        
        thirdView.addSubview(backbutton2)
        backbutton2.leftAnchor.constraint(equalTo: thirdView.leftAnchor, constant: 20).isActive = true
        backbutton2.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -20).isActive = true
        
        let slider: MDCSlider = {
            let it = MDCSlider()
            it.translatesAutoresizingMaskIntoConstraints = false
            it.minimumValue = 20
            it.maximumValue = 300
            it.numberOfDiscreteValues = 1
            it.isThumbHollowAtStart = false
            it.shouldDisplayDiscreteValueLabel = true
            it.addTarget(self, action: #selector(didChangeSliderValue(senderSlider:)), for: .valueChanged)
            return it
        }()
        
        thirdView.addSubview(slider)
        slider.leftAnchor.constraint(equalTo: thirdView.leftAnchor, constant: 20).isActive = true
        slider.rightAnchor.constraint(equalTo: thirdView.rightAnchor, constant: -20).isActive = true
        slider.centerYAnchor.constraint(equalTo: thirdView.centerYAnchor).isActive = true
        
        thirdView.addSubview(metragemTextView)
        metragemTextView.leftAnchor.constraint(equalTo: thirdView.leftAnchor, constant: 20).isActive = true
        metragemTextView.rightAnchor.constraint(equalTo: thirdView.centerXAnchor, constant: -20).isActive = true
        metragemTextView.bottomAnchor.constraint(equalTo: slider.topAnchor, constant: -20).isActive = true
        
        let thirdnextBtn: MDCRaisedButton = {
            let btn = MDCRaisedButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("Próximo", for: .normal)
            btn.setBackgroundColor(UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0))
            btn.setTitleColor(.white, for: .normal)
            btn.addTarget(self, action: #selector(thirdnext(sender:)), for: .touchUpInside)
            return btn
        }()
        
        thirdView.addSubview(thirdnextBtn)
        thirdnextBtn.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -20).isActive = true
        thirdnextBtn.rightAnchor.constraint(equalTo: thirdView.rightAnchor, constant: -20).isActive = true
        
        //Fourth view setup
        
        let fourthTitle: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Selecione a quantidade de banheiros no imóvel"
            label.font = UIFont.boldSystemFont(ofSize: 34.0)
            label.numberOfLines = 0
            return label
        }()
        
        fourthView.addSubview(fourthTitle)
        fourthTitle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        fourthTitle.leftAnchor.constraint(equalTo: fourthView.leftAnchor, constant: 20).isActive = true
        fourthTitle.rightAnchor.constraint(equalTo: fourthView.rightAnchor, constant: -20).isActive = true
        
        let backbutton3: MDCFlatButton = {
            let btn = MDCFlatButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("Voltar", for: .normal)
            btn.tag = 3
            btn.addTarget(self, action: #selector(gotoPage(sender:)), for: .touchUpInside)
            return btn
        }()
        
        fourthView.addSubview(backbutton3)
        backbutton3.leftAnchor.constraint(equalTo: fourthView.leftAnchor, constant: 20).isActive = true
        backbutton3.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -20).isActive = true
        
        let firstfloat: MDCFloatingButton = {
            let btn = MDCFloatingButton()
            btn.setTitle("1", for: .normal)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setBackgroundColor(UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0))
            btn.setTitleColor(.white, for: .normal)
            btn.tag = 1
            btn.addTarget(self, action: #selector(selectbath(sender:)), for: .touchUpInside)
            return btn
        }()
        
        let secondfloat: MDCFloatingButton = {
            let btn = MDCFloatingButton()
            btn.setTitle("2", for: .normal)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setBackgroundColor(UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0))
            btn.setTitleColor(.white, for: .normal)
            btn.tag = 2
            btn.addTarget(self, action: #selector(selectbath(sender:)), for: .touchUpInside)
            return btn
        }()
        
        let thirdfloat: MDCFloatingButton = {
            let btn = MDCFloatingButton()
            btn.setTitle("3", for: .normal)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setBackgroundColor(UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0))
            btn.setTitleColor(.white, for: .normal)
            btn.tag = 3
            btn.addTarget(self, action: #selector(selectbath(sender:)), for: .touchUpInside)
            return btn
        }()
        
        let fourthfloat: MDCFloatingButton = {
            let btn = MDCFloatingButton()
            btn.setTitle("4+", for: .normal)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setBackgroundColor(UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0))
            btn.setTitleColor(.white, for: .normal)
            btn.tag = 4
            btn.addTarget(self, action: #selector(selectbath(sender:)), for: .touchUpInside)
            return btn
        }()
        
        fourthView.addSubview(firstfloat)
        fourthView.addSubview(secondfloat)
        fourthView.addSubview(thirdfloat)
        fourthView.addSubview(fourthfloat)
        
        firstfloat.topAnchor.constraint(equalTo: fourthTitle.bottomAnchor, constant: 50).isActive = true
        firstfloat.leftAnchor.constraint(equalTo: fourthView.leftAnchor, constant: 20).isActive = true
        
        secondfloat.topAnchor.constraint(equalTo: firstfloat.bottomAnchor, constant: 20).isActive = true
        secondfloat.leftAnchor.constraint(equalTo: fourthView.leftAnchor, constant: 20).isActive = true
        
        thirdfloat.topAnchor.constraint(equalTo: secondfloat.bottomAnchor, constant: 20).isActive = true
        thirdfloat.leftAnchor.constraint(equalTo: fourthView.leftAnchor, constant: 20).isActive = true
        
        fourthfloat.topAnchor.constraint(equalTo: thirdfloat.bottomAnchor, constant: 20).isActive = true
        fourthfloat.leftAnchor.constraint(equalTo: fourthView.leftAnchor, constant: 20).isActive = true
        
        //Fith view setup
        
        let fifthTitle: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Entre o endereço do imóvel"
            label.font = UIFont.boldSystemFont(ofSize: 34.0)
            label.numberOfLines = 0
            return label
        }()
        
        fifthView.addSubview(loadingIndicator)
        loadingIndicator.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        loadingIndicator.rightAnchor.constraint(equalTo: fifthView.rightAnchor, constant: -20).isActive = true
        
        fifthView.addSubview(fifthTitle)
        fifthTitle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        fifthTitle.leftAnchor.constraint(equalTo: fifthView.leftAnchor, constant: 20).isActive = true
        fifthTitle.rightAnchor.constraint(equalTo: loadingIndicator.leftAnchor, constant: -20).isActive = true
        
        let backbutton4: MDCFlatButton = {
            let btn = MDCFlatButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("Voltar", for: .normal)
            btn.tag = 4
            btn.addTarget(self, action: #selector(gotoPage(sender:)), for: .touchUpInside)
            return btn
        }()
        
        fifthView.addSubview(backbutton4)
        backbutton4.leftAnchor.constraint(equalTo: fifthView.leftAnchor, constant: 20).isActive = true
        backbutton4.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -20).isActive = true
        
        fifthView.addSubview(cepTextField)
        fifthView.addSubview(searchCEPButton)
        cepTextField.topAnchor.constraint(equalTo: fifthTitle.bottomAnchor, constant: 30).isActive = true
        cepTextField.leftAnchor.constraint(equalTo: fifthView.leftAnchor, constant: 20).isActive = true
        searchCEPButton.rightAnchor.constraint(equalTo: fifthView.rightAnchor, constant: -20).isActive = true
        searchCEPButton.topAnchor.constraint(equalTo: cepTextField.topAnchor).isActive = true
        searchCEPButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        searchCEPButton.widthAnchor.constraint(equalToConstant: 68).isActive = true
        cepTextField.rightAnchor.constraint(equalTo: searchCEPButton.leftAnchor, constant: -10).isActive = true
        
        fifthView.addSubview(logradouroTextField)
        logradouroTextField.topAnchor.constraint(equalTo: cepTextField.bottomAnchor).isActive = true
        logradouroTextField.leftAnchor.constraint(equalTo: fifthView.leftAnchor, constant: 20).isActive = true
        logradouroTextField.rightAnchor.constraint(equalTo: cepTextField.rightAnchor).isActive = true
        
        fifthView.addSubview(numberTextField)
        numberTextField.topAnchor.constraint(equalTo: logradouroTextField.topAnchor).isActive = true
        numberTextField.leftAnchor.constraint(equalTo: logradouroTextField.rightAnchor, constant: 10).isActive = true
        numberTextField.rightAnchor.constraint(equalTo: fifthView.rightAnchor, constant: -20).isActive = true
        
        
        fifthView.addSubview(complementoTextField)
        complementoTextField.topAnchor.constraint(equalTo: logradouroTextField.bottomAnchor).isActive = true
        complementoTextField.leftAnchor.constraint(equalTo: fifthView.leftAnchor, constant: 20).isActive = true
        complementoTextField.rightAnchor.constraint(equalTo: fifthView.centerXAnchor, constant: -5).isActive = true
        
        fifthView.addSubview(bairroTextField)
        bairroTextField.topAnchor.constraint(equalTo: logradouroTextField.bottomAnchor).isActive = true
        bairroTextField.leftAnchor.constraint(equalTo: complementoTextField.rightAnchor, constant: 10).isActive = true
        bairroTextField.rightAnchor.constraint(equalTo: fifthView.rightAnchor, constant: -20).isActive = true
        
        fifthView.addSubview(cityTextField)
        cityTextField.topAnchor.constraint(equalTo: complementoTextField.bottomAnchor).isActive = true
        cityTextField.leftAnchor.constraint(equalTo: complementoTextField.leftAnchor).isActive = true
        cityTextField.rightAnchor.constraint(equalTo: complementoTextField.rightAnchor).isActive = true
        
        fifthView.addSubview(estadoTextField)
        estadoTextField.leftAnchor.constraint(equalTo: bairroTextField.leftAnchor).isActive = true
        estadoTextField.topAnchor.constraint(equalTo: bairroTextField.bottomAnchor).isActive = true
        estadoTextField.rightAnchor.constraint(equalTo: bairroTextField.rightAnchor).isActive = true
        
        let submitBtn: MDCRaisedButton = {
            let btn = MDCRaisedButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("Enviar", for: .normal)
            btn.setBackgroundColor(UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0))
            btn.setTitleColor(.white, for: .normal)
            btn.addTarget(self, action: #selector(submitData(sender:)), for: .touchUpInside)
            return btn
        }()
        
        fifthView.addSubview(submitBtn)
        submitBtn.rightAnchor.constraint(equalTo: fifthView.rightAnchor, constant: -20).isActive = true
        submitBtn.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -20).isActive = true
        
        //Six view setup
        
        let sixTitle: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Enviando dados"
            label.font = UIFont.boldSystemFont(ofSize: 34.0)
            label.numberOfLines = 0
            return label
        }()
        
        sixView.addSubview(sixTitle)
        sixTitle.leftAnchor.constraint(equalTo: sixView.leftAnchor, constant: 20).isActive = true
        sixTitle.bottomAnchor.constraint(equalTo: sixView.centerYAnchor).isActive = true
     
        sixView.addSubview(uploadIndicator)
        uploadIndicator.leftAnchor.constraint(equalTo: sixTitle.rightAnchor, constant: 20).isActive = true
        uploadIndicator.centerYAnchor.constraint(equalTo: sixTitle.centerYAnchor).isActive = true
    }
    
    @objc func didChangePage(sender: MDCPageControl){
        var offset = sv.contentOffset
        offset.x = CGFloat(sender.currentPage) * sv.bounds.size.width;
        sv.setContentOffset(offset, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.scrollViewDidScroll(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.scrollViewDidEndDecelerating(scrollView)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl.scrollViewDidEndScrollingAnimation(scrollView)
    }
    
    @objc func closeit(sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func gotoPage(sender: UIButton) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIView.animate(withDuration: 0.3) {
                self.sv.contentOffset.x = self.sv.frame.width * CGFloat(sender.tag - 1)
            }
        }
        
    }
    
    @objc func gotoPageWNumber(page: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIView.animate(withDuration: 0.3) {
                self.sv.contentOffset.x = self.sv.frame.width * CGFloat(page - 1)
            }
        }
    }
    
    //Second view Functions
    
    @objc func residencialPressed(sender: Any) {
        placetype = 0
        gotoPageWNumber(page: 3)
    }
    
    @objc func comercialPressed(sender: Any) {
        placetype = 1
        gotoPageWNumber(page: 3)
    }
    
    @objc func othersPressed(sender: Any) {
        
    }
    
    //Third view functions
    
    @objc func didChangeSliderValue(senderSlider:MDCSlider) {
        metragem = Int(senderSlider.value)
        metragemTextView.text = "\(metragem!)"
    }
    
    @objc func thirdnext(sender: Any) {
        if metragem == nil || metragem! <= 0 {
            let message = MDCSnackbarMessage(text: "Você precisa selecionar uma metragem para continuar")
            MDCSnackbarManager.show(message)
        } else {
            gotoPageWNumber(page: 4)
        }
    }
    
    //Fourth view functions
    
    @objc func selectbath(sender: MDCFloatingButton) {
        banheiros = sender.tag
        gotoPageWNumber(page: 5)
        let highlightController = MDCFeatureHighlightViewController(highlightedView: searchCEPButton) { (finished) in
            
        }
        highlightController.titleText = "Uma ajudinha!"
        highlightController.bodyText = "Insira o CEP e toque na lupa para liberar os outros campos. Se o CEP for encontrado os campos serão preenchidos automaticamente."
        highlightController.outerHighlightColor = UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0)
        highlightController.bodyColor = .white
        highlightController.titleColor = .white
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.present(highlightController, animated: true, completion: nil)
        }
    }
    
    //Fith view functions
    
    @objc func getCEP(sender: Any) {
        if cepTextField.text?.count != 8 {
            let message = MDCSnackbarMessage(text: "O cep deve possuir 8 dígitos e ser composto somente por números")
            MDCSnackbarManager.show(message)
        } else {
            UIApplication.shared.beginIgnoringInteractionEvents()
            loadingIndicator.startAnimating()
            
            Alamofire.request("https://webmaniabr.com/api/1/cep/"+cepTextField.text!+"/?app_key=isGR3dBUvtMjYuKo6YTZcsXRydQfAvJp&app_secret=kLpoxqQc8spkJg3OMRMPa3DSsJzs9yiffvTF8ifKEuZKO5Y3").responseData { (response) in
                
                if response.error != nil {
                    print("Erro: \(response.error!)" )
                    UIApplication.shared.endIgnoringInteractionEvents()
                    let message = MDCSnackbarMessage(text: "Erro: \(response.error!)")
                    MDCSnackbarManager.show(message)
                    self.loadingIndicator.stopAnimating()
                } else if let json = response.result.value {
                    print(json)
                    
                    do {
                        let address = try JSONDecoder().decode(EndereçoAPI.self, from: json)
                        self.logradouroTextField.text = address.endereco
                        self.cityTextField.text = address.cidade
                        self.estadoTextField.text = address.uf
                        self.bairroTextField.text = address.bairro
                    } catch {
                        
                    }
                    
                    UIApplication.shared.endIgnoringInteractionEvents()
                    self.loadingIndicator.stopAnimating()
                } else {
                    let message = MDCSnackbarMessage(text: "Erro: tente novamente mais tarde")
                    MDCSnackbarManager.show(message)
                    UIApplication.shared.endIgnoringInteractionEvents()
                    self.loadingIndicator.stopAnimating()
                }
                
                UIApplication.shared.endIgnoringInteractionEvents()
                self.loadingIndicator.stopAnimating()
                
                self.logradouroTextField.isEnabled = true
                self.numberTextField.isEnabled = true
                self.complementoTextField.isEnabled = true
                self.bairroTextField.isEnabled = true
                self.cityTextField.isEnabled = true
                self.estadoTextField.isEnabled = true
            }
            
            
        }
    }
    
    @objc func submitData(sender: Any) {
        if cepTextField.text == "" {
            let message = MDCSnackbarMessage(text: "Campo de CPF vazio, tente novamente")
            MDCSnackbarManager.show(message)
        } else if logradouroTextField.text == "" {
            let message = MDCSnackbarMessage(text: "Campo de Logradouro vazio, tente novamente")
            MDCSnackbarManager.show(message)
        } else if bairroTextField.text == "" {
            let message = MDCSnackbarMessage(text: "Campo de Bairro Vazio, tente novamente")
            MDCSnackbarManager.show(message)
        } else if cityTextField.text == "" {
            let message = MDCSnackbarMessage(text: "Campo de Cidade vazio, tente novamente")
            MDCSnackbarManager.show(message)
        } else if estadoTextField.text == "" {
            let message = MDCSnackbarMessage(text: "Campo de Estado vazio, tente novamente")
            MDCSnackbarManager.show(message)
        } else if banheiros == nil {
            let message = MDCSnackbarMessage(text: "Campo de Banheiros com erro, tente novamente")
            MDCSnackbarManager.show(message)
            gotoPageWNumber(page: 4)
        } else if metragem == nil {
            let message = MDCSnackbarMessage(text: "Campo de Metragem com erro, tente novamente")
            MDCSnackbarManager.show(message)
            gotoPageWNumber(page: 3)
        } else if placetype == nil {
            let message = MDCSnackbarMessage(text: "Campo de Tipo com erro, tente novamente")
            MDCSnackbarManager.show(message)
            gotoPageWNumber(page: 2)
        } else {
            gotoPageWNumber(page: 6)
            UIApplication.shared.beginIgnoringInteractionEvents()
            uploadIndicator.startAnimating()
            
            Firestore.firestore().collection("users").document(Auth.auth().currentUser!.uid).collection("enderecos").addDocument(data: [
                "type": placetype!,
                "msqr": metragem!,
                "banheiros": banheiros!,
                "cep": cepTextField.text!,
                "logradouro": logradouroTextField.text!,
                "numero": numberTextField.text ?? "S/N",
                "complemento": complementoTextField.text ?? "Sem complemento",
                "bairro": bairroTextField.text!,
                "cidade": cityTextField.text!,
                "estado": estadoTextField.text!,
                "created": Date()
            ]) { (error) in
                if error != nil {
                    //There was an error
                    self.uploadIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    let alertController = MDCAlertController(title: "Erro!", message: "\(error!.localizedDescription)")
                    let action = MDCAlertAction(title: "OK", handler: { (action) in
                        self.navigationController?.popToRootViewController(animated: true)
                        self.dismiss(animated: true, completion: nil)
                    })
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    self.uploadIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    let alertController = MDCAlertController(title: "Pronto!", message: "O endereço foi adicionado")
                    let action = MDCAlertAction(title: "OK", handler: { (action) in
                        self.navigationController?.popToRootViewController(animated: true)
                        self.dismiss(animated: true, completion: nil)
                    })
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    //General functions
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        metragemTFControler = MDCTextInputControllerOutlined(textInput: metragemTextView)
        cepTFControler = MDCTextInputControllerFilled(textInput: cepTextField)
        logradouroTFControler = MDCTextInputControllerFilled(textInput: logradouroTextField)
        numberTFControler = MDCTextInputControllerFilled(textInput: numberTextField)
        complementoTFControler = MDCTextInputControllerFilled(textInput: complementoTextField)
        bairroTFController = MDCTextInputControllerFilled(textInput: bairroTextField)
        cityTFControler = MDCTextInputControllerFilled(textInput: cityTextField)
        estadoTFControler = MDCTextInputControllerFilled(textInput: estadoTextField)
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
