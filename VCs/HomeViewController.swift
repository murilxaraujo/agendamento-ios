//
//  HomeViewController.swift
//  MaryLimp
//
//  Created by Murilo Oliveira de Araujo on 16/11/18.
//  Copyright © 2018 Murilo Oliveira de Araujo. All rights reserved.
//

import UIKit
import MaterialComponents
import Firebase

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var userpf: PFUser?
    var userpj: PJUser?
    
    let cella = "cella"
    let cellb = "cellb"
    
    var arraya: [Visit] = [Visit(date: Date(), docID: "", worker: nil, address: "", rate: 0, comment: Comment(text: "", pics: nil), periodo: 1, price: 1, discount: nil, done: true, paymenttype: 0, payment: "")]
    var arrayb: [Addressess] = [Addressess(cep: "", logradouro: "", number: nil, bairro: "", cidade: "", estado: "", comp: nil, pref: nil, addrtype: 0, sqrm: 0, detalhes: nil, uid: "")]
    
    let actindicator: MDCActivityIndicator = {
        let it = MDCActivityIndicator()
        it.translatesAutoresizingMaskIntoConstraints = false
        it.cycleColors = [.white]
        it.sizeToFit()
        return it
    }()
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Olá"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 34.0)
        return label
    }()
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let visitsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Visitas"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let visitsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.allowsSelection = true
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    let addressessLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Imóveis"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let addressessCollectionView: UICollectionView = {
        let view = UICollectionViewFlowLayout()
        view.scrollDirection = .horizontal
        view.minimumLineSpacing = 15
        let cv = UICollectionView(frame: .zero, collectionViewLayout: view)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.allowsSelection = true
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    let settingsBtn: MDCFloatingButton = {
        let btn = MDCFloatingButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setBackgroundColor(.white)
        btn.sizeToFit()
        btn.setImageTintColor(UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0), for: .normal)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        
        view.backgroundColor = UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0)
        
        view.addSubview(loginLabel)
        loginLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        loginLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 15).isActive = true
        
        view.addSubview(actindicator)
        actindicator.centerYAnchor.constraint(equalTo: loginLabel.centerYAnchor).isActive = true
        actindicator.leftAnchor.constraint(equalTo: loginLabel.rightAnchor, constant: 15).isActive = true
        actindicator.startAnimating()
        
        view.addSubview(settingsBtn)
        settingsBtn.setImage(UIImage(named: "round_account_circle_black_48pt"), for: .normal)
        settingsBtn.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -15).isActive = true
        settingsBtn.centerYAnchor.constraint(equalTo: loginLabel.centerYAnchor).isActive = true
        
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: settingsBtn.bottomAnchor, constant: 15).isActive = true
        scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        scrollView.addSubview(visitsLabel)
        visitsLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15).isActive = true
        visitsLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 15).isActive = true
        
        scrollView.addSubview(visitsCollectionView)
        visitsCollectionView.topAnchor.constraint(equalTo: visitsLabel.bottomAnchor, constant: 0).isActive = true
        visitsCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        visitsCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        visitsCollectionView.heightAnchor.constraint(equalToConstant: 175).isActive = true
        visitsCollectionView.delegate = self
        visitsCollectionView.dataSource = self
        visitsCollectionView.register(visitsCollectionViewCell.self, forCellWithReuseIdentifier: cella)
        
        scrollView.addSubview(addressessLabel)
        addressessLabel.topAnchor.constraint(equalTo: visitsCollectionView.bottomAnchor, constant: 15).isActive = true
        addressessLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 15).isActive = true
        
        scrollView.addSubview(addressessCollectionView)
        addressessCollectionView.topAnchor.constraint(equalTo: addressessLabel.bottomAnchor, constant: 0).isActive = true
        addressessCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        addressessCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        addressessCollectionView.heightAnchor.constraint(equalToConstant: 175).isActive = true
        addressessCollectionView.delegate = self
        addressessCollectionView.dataSource = self
        addressessCollectionView.register(addressessCollectionViewCell.self, forCellWithReuseIdentifier: cellb)
        
        
        
        getdata()
    }
    
    //Funcs
    func getdata() {
        
        Firestore.firestore().collection("users").document(Auth.auth().currentUser!.uid).getDocument { (doc, error) in
            if error != nil {
                let alertController = MDCAlertController(title: "Erro!", message: error!.localizedDescription)
                let action = MDCAlertAction(title: "OK", handler: { (action) in
                    self.dismiss(animated: true, completion: nil)
                })
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
            } else {
                if doc!.exists {
                    if (doc!.get("type") as! Int) == 0 {
                        //Type 0 setup
                        self.settingsBtn.addTarget(self, action: #selector(self.gosetpf(sender:)), for: .touchUpInside)
                        self.userpf = PFUser(uid: doc!.documentID,
                                        cpf: (doc!.get("cpf") as! String),
                                        email: (doc!.get("email") as! String),
                                        name: ["first":doc!.get("fname") as! String,"sur":doc!.get("sname") as! String,"full":"\(doc!.get("fname") as! String) \(doc!.get("sname") as! String)"],
                                        phone: (doc!.get("phone") as! String))
                        self.loginLabel.text = "Olá, \(doc!.get("fname") as! String)"
                        
                    } else {
                        
                        //type 1 setup
                        self.settingsBtn.addTarget(self, action: #selector(self.gosetpj(sender:)), for: .touchUpInside)
                        self.userpj = PJUser(uid: doc!.documentID,
                                             cpf: (doc!.get("cpf") as! String),
                                             cnpj: (doc!.get("cnpj") as! String),
                                             email: (doc!.get("email") as! String),
                                             razao: (doc!.get("razao") as! String),
                                             phone: (doc!.get("phone") as! String),
                                             rep: (doc!.get("rep") as! String))
                    }
                    
                    
                    Firestore.firestore().collection("users").document(Auth.auth().currentUser!.uid).collection("enderecos").addSnapshotListener({ (snapshot, error) in
                        
                        if error != nil {
                            //There was an error
                        } else if snapshot!.isEmpty {
                            // Isempty
                        } else {
                            self.arrayb.removeAll()
                            self.arrayb.append(Addressess(cep: "", logradouro: "", number: nil, bairro: "", cidade: "", estado: "", comp: nil, pref: nil, addrtype: 0, sqrm: 0, detalhes: nil))
                            for document in snapshot!.documents {
                                let item = Addressess(cep: document.get("cep") as! String,
                                                      logradouro: document.get("logradouro") as! String,
                                                      number: document.get("numero") as? String,
                                                      bairro: document.get("bairro") as! String,
                                                      cidade: document.get("cidade") as! String,
                                                      estado: document.get("estado") as! String,
                                                      comp: (document.get("complemento") as! String),
                                                      pref: nil,
                                                      addrtype: document.get("type") as! Int,
                                                      sqrm: 00,
                                                      detalhes: nil,
                                                      uid: document.documentID)
                                self.arrayb.append(item)
                                
                            }
                            
                            self.addressessCollectionView.reloadSections(IndexSet(integer: 0))
                            
                            self.actindicator.stopAnimating()
                        }
                        
                    })
                    
                } else {
                    let alertController = MDCAlertController(title: "Opa!", message: "Houve um erro, não foi possível acessar seus dados, entre em contato com o suporte")
                    let action = MDCAlertAction(title: "OK", handler: { (action) in
                        self.present(LoginViewController(), animated: true, completion: nil)
                    })
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func gosetpf(sender: Any) {
        let vc = PFSettingsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func gosetpj(sender: Any) {
        let vc = PJSettingsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.visitsCollectionView {
            return arraya.count
        } else {
            return arrayb.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.visitsCollectionView {
            let cell = visitsCollectionView.dequeueReusableCell(withReuseIdentifier: self.cella, for: indexPath) as! visitsCollectionViewCell
            cell.setupCell(item: arraya[indexPath.item], index: indexPath.item)
            return cell
        } else {
            let cell = addressessCollectionView.dequeueReusableCell(withReuseIdentifier: self.cellb, for: indexPath) as! addressessCollectionViewCell
            cell.setupCell(item: arrayb[indexPath.item], index: indexPath.item)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent // .default
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected item at \(indexPath.item)")
        if collectionView == self.visitsCollectionView {
            
            if indexPath.item == 0 {
                self.navigationController?.pushViewController(NewVisitViewController(), animated: true)
            } else {
                
            }
            
        } else {
            
            if indexPath.item == 0 {
                self.navigationController?.pushViewController(NewAddressViewController(), animated: true)
            } else {
                deleteAddress(indexpath: indexPath.item)
            }
            
        }
    }
    
    func deleteAddress(indexpath: Int) {
        let documentID: String = arrayb[indexpath].uid
        
        Firestore.firestore().collection("users").document(Auth.auth().currentUser!.uid).collection("enderecos").document(documentID).delete { (error) in
            if error != nil {
                //there was an error
            }
        }
    }
    
}

//First cell

class visitsCollectionViewCell: UICollectionViewCell {
    
    let cellView: MDCCard = {
        let card = MDCCard()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.isUserInteractionEnabled = false
        return card
    }()
    
    // For index == 0
    
    let plusBtn: MDCFloatingButton = {
        let btn = MDCFloatingButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.lightGray
        btn.setShadowColor(.clear, for: .normal)
        btn.setImageTintColor(.white, for: .normal)
        btn.isUserInteractionEnabled = false
        return btn
    }()
    
    let addMoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Agendar visita"
        label.textColor = UIColor.lightGray
        return label
    }()
    
    
    
    //For all the others
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "XX"
        return label
    }()
    
    let monthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "xxxx"
        return label
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.tintColor = UIColor(red:1.00, green:0.71, blue:0.12, alpha:1.0)
        return iv
    }()
    
    
    func setupCell(item: Visit, index: Int) {
        
        if index == 0 {
            addSubview(cellView)
            cellView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            cellView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            cellView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            
            cellView.addSubview(plusBtn)
            plusBtn.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
            plusBtn.centerYAnchor.constraint(equalTo: cellView.centerYAnchor, constant: -15).isActive = true
            plusBtn.setImage(UIImage(named: "baseline_add_black_48pt"), for: .normal)
            
            cellView.addSubview(addMoreLabel)
            addMoreLabel.topAnchor.constraint(equalTo: plusBtn.bottomAnchor, constant: 15).isActive = true
            addMoreLabel.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
            
        } else {
            
            addSubview(cellView)
            cellView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            cellView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            cellView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            
            addSubview(dateLabel)
            dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20).isActive = true
            
            addSubview(imageView)
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
            imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
            
            addSubview(monthLabel)
            monthLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: 15).isActive = true
            monthLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 15).isActive = true
            monthLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
            monthLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//Second cell

class addressessCollectionViewCell: UICollectionViewCell {
    // For index == 0

    
    let plusBtn: MDCFloatingButton = {
        let btn = MDCFloatingButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0)
        btn.backgroundColor = UIColor.lightGray
        btn.setShadowColor(.clear, for: .normal)
        btn.setImageTintColor(.white, for: .normal)
        btn.isUserInteractionEnabled = false
        return btn
    }()
    
    let addMoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Novo imóvel"
        label.textColor = .lightGray
        return label
    }()
    
    let cellView: MDCCard = {
        let card = MDCCard()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.isUserInteractionEnabled = false
        return card
    }()
    
    let addLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Imóvel"
        label.textColor = .lightGray
        return label
    }()
    
    let icon: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.tintColor = .lightGray
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    func setupCell(item: Addressess, index: Int) {
        plusBtn.alpha = 0
        addMoreLabel.alpha = 0
        addLabel.alpha = 0
        icon.alpha = 0
        
        if index == 0 {
            addSubview(cellView)
            cellView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            cellView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            cellView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            
            cellView.addSubview(plusBtn)
            plusBtn.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            plusBtn.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -15).isActive = true
            plusBtn.setImage(UIImage(named: "baseline_add_black_48pt"), for: .normal)
            plusBtn.alpha = 1
            
            cellView.addSubview(addMoreLabel)
            addMoreLabel.topAnchor.constraint(equalTo: plusBtn.bottomAnchor, constant: 15).isActive = true
            addMoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            addMoreLabel.alpha = 1
            
        } else {
            addSubview(cellView)
            cellView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            cellView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            cellView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            
            cellView.addSubview(addLabel)
            addLabel.topAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -48).isActive = true
            addLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            addLabel.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -5).isActive = true
            addLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 5).isActive = true
            addLabel.textAlignment = .center
            addLabel.text = item.logradouro
            addLabel.alpha = 1
            
            cellView.addSubview(icon)
            icon.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
            icon.centerYAnchor.constraint(equalTo: cellView.centerYAnchor, constant: -15).isActive = true
            icon.heightAnchor.constraint(equalToConstant: 50).isActive = true
            icon.widthAnchor.constraint(equalToConstant: 50).isActive = true
            icon.alpha = 1
            
            if item.addrtype == 0 {
                icon.image = UIImage(named: "round_home_black_36pt")
            } else {
                icon.image = UIImage(named: "round_work_black_36pt")
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// it



