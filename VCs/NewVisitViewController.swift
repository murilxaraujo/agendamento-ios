//
//  NewVisitViewController.swift
//  MaryLimp
//
//  Created by Murilo Araujo on 04/12/18.
//  Copyright © 2018 Murilo Oliveira de Araujo. All rights reserved.
//

import UIKit
import MaterialComponents
import Firebase
import Lottie
import MercadoPagoSDK
import SafariServices

class NewVisitViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SFSafariViewControllerDelegate {

    //Elements
    let pageControl: MDCPageControl = {
        let pc = MDCPageControl()
        pc.numberOfPages = 5
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    var tipolimp: Int?
    
    let numberofpages = 5
    
    var selectedAddr: Addressess?
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
    
    //
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
    let cellb = "cellb"
    var arrayb: [Addressess] = []
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Aqui está o seu pedido:"
        label.font = UIFont.boldSystemFont(ofSize: 34.0)
        label.numberOfLines = 0
        return label
    }()
    
    let detaislabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Aqui está o seu pedido:"
        label.numberOfLines = 0
        return label
    }()
    
    let detaislabel2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Aqui está o seu pedido:"
        label.numberOfLines = 0
        return label
    }()
    
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
            return v
        }()
        
        sv.addSubview(secondView)
        secondView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        secondView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        secondView.topAnchor.constraint(equalTo: sv.topAnchor).isActive = true
        secondView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        secondView.leftAnchor.constraint(equalTo: firstView.rightAnchor).isActive = true
        
        //FirstViewsetup
        
        let animation: AnimationView = {
            let av = AnimationView()
            let lot = Animation.named("IconTransitions")
            av.translatesAutoresizingMaskIntoConstraints = false
            av.contentMode = .scaleAspectFit
            av.animation = lot
            return av
        }()
        
        firstView.addSubview(animation)
        animation.centerYAnchor.constraint(equalTo: firstView.centerYAnchor, constant: -100).isActive = true
        animation.leftAnchor.constraint(equalTo: firstView.leftAnchor, constant: 20).isActive = true
        animation.rightAnchor.constraint(equalTo: firstView.rightAnchor, constant: -20).isActive = true
        animation.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        let firstTitle: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Agende sua visita"
            label.font = UIFont.boldSystemFont(ofSize: 34.0)
            label.textAlignment = .center
            return label
        }()
        
        firstView.addSubview(firstTitle)
        firstTitle.topAnchor.constraint(equalTo: animation.bottomAnchor, constant: -20).isActive = true
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
        
        // Second View Setup
        
        let secondTitle: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Selecione o imóvel"
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
    
        secondView.addSubview(addressessCollectionView)
        addressessCollectionView.centerYAnchor.constraint(equalTo: secondView.centerYAnchor).isActive = true
        addressessCollectionView.leftAnchor.constraint(equalTo: secondView.leftAnchor).isActive = true
        addressessCollectionView.rightAnchor.constraint(equalTo: secondView.rightAnchor).isActive = true
        addressessCollectionView.heightAnchor.constraint(equalToConstant: 175).isActive = true
        addressessCollectionView.delegate = self
        addressessCollectionView.dataSource = self
        addressessCollectionView.register(addressessCollectionViewCellb.self, forCellWithReuseIdentifier: cellb)
        
        //Thirdview
        
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
        
        let thirdTitle: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Selecione o tipo de limpeza"
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
        
        let expressabutton: MDCRaisedButton = {
            let btn = MDCRaisedButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("Expressa", for: .normal)
            btn.setBackgroundColor(UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0))
            btn.setTitleColor(.white, for: .normal)
            btn.tag = 0
            btn.addTarget(self, action: #selector(cleantype(sender:)), for: .touchUpInside)
            return btn
        }()
        
        thirdView.addSubview(expressabutton)
        expressabutton.topAnchor.constraint(equalTo: thirdView.centerYAnchor, constant: -80).isActive = true
        expressabutton.leftAnchor.constraint(equalTo: thirdView.leftAnchor, constant: 20).isActive = true
        expressabutton.rightAnchor.constraint(equalTo: thirdView.rightAnchor, constant: -20).isActive = true
        expressabutton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let detalhadabutton: MDCRaisedButton = {
            let btn = MDCRaisedButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("Detalhada", for: .normal)
            btn.setBackgroundColor(UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0))
            btn.setTitleColor(.white, for: .normal)
            btn.tag = 1
            btn.addTarget(self, action: #selector(cleantype(sender:)), for: .touchUpInside)
            return btn
        }()
        
        thirdView.addSubview(detalhadabutton)
        detalhadabutton.topAnchor.constraint(equalTo: expressabutton.bottomAnchor, constant: 20).isActive = true
        detalhadabutton.leftAnchor.constraint(equalTo: thirdView.leftAnchor, constant: 20).isActive = true
        detalhadabutton.rightAnchor.constraint(equalTo: thirdView.rightAnchor, constant: -20).isActive = true
        detalhadabutton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let passadoriaButton: MDCRaisedButton = {
            let btn = MDCRaisedButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("Passadoria", for: .normal)
            btn.setBackgroundColor(UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0))
            btn.setTitleColor(.white, for: .normal)
            btn.tag = 1
            btn.addTarget(self, action: #selector(cleantype(sender:)), for: .touchUpInside)
            return btn
        }()
        
        thirdView.addSubview(passadoriaButton)
        passadoriaButton.topAnchor.constraint(equalTo: detalhadabutton.bottomAnchor, constant: 20).isActive = true
        passadoriaButton.leftAnchor.constraint(equalTo: thirdView.leftAnchor, constant: 20).isActive = true
        passadoriaButton.rightAnchor.constraint(equalTo: thirdView.rightAnchor, constant: -20).isActive = true
        passadoriaButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let outrosButton: MDCRaisedButton = {
            let btn = MDCRaisedButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("Outros", for: .normal)
            btn.setBackgroundColor(UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0))
            btn.setTitleColor(.white, for: .normal)
            btn.tag = 1
            btn.addTarget(self, action: #selector(cleantype(sender:)), for: .touchUpInside)
            return btn
        }()
        
        thirdView.addSubview(outrosButton)
        outrosButton.topAnchor.constraint(equalTo: passadoriaButton.bottomAnchor, constant: 20).isActive = true
        outrosButton.leftAnchor.constraint(equalTo: thirdView.leftAnchor, constant: 20).isActive = true
        outrosButton.rightAnchor.constraint(equalTo: thirdView.rightAnchor, constant: -20).isActive = true
        outrosButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let moreButtonl: MDCFlatButton = {
            let btn = MDCFlatButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("Saiba mais sobre os serviços", for: .normal)
            btn.setTitleColor(UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0), for: .normal)
            btn.addTarget(self, action: #selector(openServicos(sender:)), for: .touchUpInside)
            return btn
        }()
        
        thirdView.addSubview(moreButtonl)
        moreButtonl.topAnchor.constraint(equalTo: outrosButton.bottomAnchor, constant: 20).isActive = true
        moreButtonl.leftAnchor.constraint(equalTo: thirdView.leftAnchor, constant: 0).isActive  = true
        moreButtonl.rightAnchor.constraint(equalTo: thirdView.rightAnchor, constant: 0).isActive = true
        
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
        
        let fourthTitle: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Aqui está o seu pedido:"
            label.font = UIFont.boldSystemFont(ofSize: 34.0)
            label.numberOfLines = 0
            return label
        }()
        
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
        backbutton3.topAnchor.constraint(equalTo: fourthView.topAnchor, constant: 15).isActive = true
        
        fourthView.addSubview(fourthTitle)
        fourthTitle.topAnchor.constraint(equalTo: backbutton3.bottomAnchor, constant: 30).isActive = true
        fourthTitle.leftAnchor.constraint(equalTo: fourthView.leftAnchor, constant: 20).isActive = true
        fourthTitle.rightAnchor.constraint(equalTo: fourthView.rightAnchor, constant: -20).isActive = true
        
        let agendarButton: MDCRaisedButton = {
            let btn = MDCRaisedButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("Agendar", for: .normal)
            btn.setBackgroundColor(UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0))
            btn.setTitleColor(.white, for: .normal)
            btn.tag = 1
            btn.addTarget(self, action: #selector(pay(sender:)), for: .touchUpInside)
            return btn
        }()
        
        fourthView.addSubview(agendarButton)
        agendarButton.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -20).isActive = true
        agendarButton.leftAnchor.constraint(equalTo: fourthView.leftAnchor, constant: 20).isActive = true
        agendarButton.rightAnchor.constraint(equalTo: fourthView.rightAnchor, constant: -20).isActive = true
        agendarButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        fourthView.addSubview(priceLabel)
        priceLabel.bottomAnchor.constraint(equalTo: agendarButton.topAnchor, constant: -20).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: fourthView.leftAnchor, constant: 20).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: fourthView.rightAnchor, constant: -20).isActive = true
        
        fourthView.addSubview(detaislabel)
        detaislabel.topAnchor.constraint(equalTo: fourthTitle.bottomAnchor, constant: 20).isActive = true
        detaislabel.leftAnchor.constraint(equalTo: fourthView.leftAnchor, constant: 20).isActive = true
        detaislabel.rightAnchor.constraint(equalTo: fourthView.rightAnchor, constant: -20).isActive = true
        
        fourthView.addSubview(detaislabel2)
        detaislabel2.topAnchor.constraint(equalTo: detaislabel.bottomAnchor, constant: 10).isActive = true
        detaislabel2.leftAnchor.constraint(equalTo: fourthView.leftAnchor, constant: 20).isActive = true
        detaislabel2.rightAnchor.constraint(equalTo: fourthView.rightAnchor, constant: -20).isActive = true
        
        let moreButton: MDCFlatButton = {
            let btn = MDCFlatButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("Visualizar contrato", for: .normal)
            btn.setTitleColor(UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0), for: .normal)
            return btn
        }()
        
        fourthView.addSubview(moreButton)
        moreButton.topAnchor.constraint(equalTo: detaislabel2.bottomAnchor, constant: 20).isActive = true
        moreButton.leftAnchor.constraint(equalTo: fourthView.leftAnchor, constant: 0).isActive  = true
        moreButton.rightAnchor.constraint(equalTo: fourthView.rightAnchor, constant: 0).isActive = true
        
        getdata()
    }
    
    @objc func didChangePage(sender: MDCPageControl){
        var offset = sv.contentOffset
        offset.x = CGFloat(sender.currentPage) * sv.bounds.size.width;
        sv.setContentOffset(offset, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //pageControl.scrollViewDidScroll(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //pageControl.scrollViewDidEndDecelerating(scrollView)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        //pageControl.scrollViewDidEndScrollingAnimation(scrollView)
    }
    
    @objc func closeit(sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func gotoPage(sender: UIButton) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.pageControl.currentPage = sender.tag - 1
            UIView.animate(withDuration: 0.3) {
                self.sv.contentOffset.x = self.sv.frame.width * CGFloat(sender.tag - 1)
            }
        }
        
    }
    
    @objc func gotoPageWNumber(page: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIView.animate(withDuration: 0.3) {
                self.pageControl.currentPage = page - 1
                self.sv.contentOffset.x = self.sv.frame.width * CGFloat(page - 1)
            }
        }
    }
    
    @objc func openServicos(sender: Any) {
        let safariVC = SFSafariViewController(url: NSURL(string: "https://www.marylimp.com.br/services.html/")! as URL)
        self.present(safariVC, animated: true, completion: nil)
        safariVC.delegate = self
    }
    
    //collectionview
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return arrayb.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = addressessCollectionView.dequeueReusableCell(withReuseIdentifier: self.cellb, for: indexPath) as! addressessCollectionViewCellb
            cell.setupCell(item: arrayb[indexPath.item], index: indexPath.item)
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedAddr = arrayb[indexPath.item]
        gotoPageWNumber(page: 3)
        
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
    }
    
    func getdata() {
        if Auth.auth().currentUser == nil {
            return;
        }
        
        Firestore.firestore().collection("users").document(Auth.auth().currentUser!.uid).collection("enderecos").addSnapshotListener({ (snapshot, error) in
            
            if error != nil {
                //There was an error
            } else if snapshot!.isEmpty {
                // Isempty
            } else {
                self.arrayb.removeAll()
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
                                          sqrm: Double(document.get("msqr") as! Int),
                                          detalhes: nil)
                    self.arrayb.append(item)
                    
                }
                
                self.addressessCollectionView.reloadSections(IndexSet(integer: 0))
                
            }
            
        })
    }
    
    @objc func cleantype(sender: MDCRaisedButton) {
        self.tipolimp = sender.tag
        gotoPageWNumber(page: 4)
        if sender.tag == 0 {
          detaislabel2.text = "Limpeza expressa"
        } else {
            detaislabel2.text = "Limpeza detalhada"
        }
        agendar(sender: self)
    }
    
    @objc func agendar(sender: Any) {
        detaislabel.text = "\(selectedAddr!.logradouro), \(selectedAddr!.bairro), \(selectedAddr!.cidade) - \(selectedAddr!.estado)"
        
        if selectedAddr!.sqrm < 40 && selectedAddr!.addrtype == 1 {
            if tipolimp == 0 {
                priceLabel.text = "R$ 75,00"
            } else {
                priceLabel.text = "R$ 150,00"
            }
        } else if selectedAddr!.sqrm < 70 {
            if tipolimp == 0 {
                priceLabel.text = "R$ 90,00"
            } else {
                priceLabel.text = "R$ 180,00"
            }
        } else if selectedAddr!.sqrm < 100 {
            if tipolimp == 0 {
                priceLabel.text = "R$ 120,00"
            } else {
                priceLabel.text = "R$ 240,00"
            }
        } else if selectedAddr!.sqrm < 120 {
            if tipolimp == 0 {
                priceLabel.text = "R$ 170,00"
            } else {
                priceLabel.text = "R$ 340,00"
            }
        } else if selectedAddr!.sqrm < 160 {
            if tipolimp == 0 {
                priceLabel.text = "R$ 220,00"
            } else {
                priceLabel.text = "R$ 440,00"
            }
        } else if selectedAddr!.sqrm < 220 {
            if tipolimp == 0 {
                priceLabel.text = "R$ 300,00"
            } else {
                priceLabel.text = "R$ 600,00"
            }
        } else if selectedAddr!.sqrm < 300 {
            if tipolimp == 0 {
                priceLabel.text = "R$ 400,00"
            } else {
                priceLabel.text = "R$ 800,00"
            }
        }
    }
    
    @objc func pay(sender: Any) {
        
        _ = "226594734-52eb792f-8671-4536-8fac-13f70a88be5a"
        MercadoPagoCheckout.init(builder: MercadoPagoCheckoutBuilder.init(publicKey: "APP_USR-0b6e2cd9-1ba7-499f-bc3d-3a8be2ebf9cc", preferenceId: "387559019-e20c81af-0683-4d91-8c29-051beca70682")).start(navigationController: self.navigationController!)

    }
}

class addressessCollectionViewCellb: UICollectionViewCell {
    // For index == 0
    
    let cellView: MDCCard = {
        let card = MDCCard()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.isUserInteractionEnabled = false
        card.backgroundColor = UIColor(red:0.16, green:0.71, blue:0.96, alpha:1.0)
        return card
    }()
    
    let addLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Imóvel"
        label.textColor = .white
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
            icon.tintColor = UIColor.white
            icon.alpha = 1
        
            if item.addrtype == 0 {
            icon.image = UIImage(named: "round_home_black_36pt")
            } else {
            icon.image = UIImage(named: "round_work_black_36pt")
            }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
