 //
//  MODEL.swift
//  MaryLimp
//
//  Created by Murilo Oliveira de Araujo on 28/11/18.
//  Copyright © 2018 Murilo Oliveira de Araujo. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Comment {
    var text: String
    var pics: [String]?
}

class Visit {
    var date: Date
    var worker: String?
    var address: String
    var rate: Int?
    var comment: Comment?
    var periodo: Int
    var price: Double?
    var discount: Int?
    var done: Bool
    var paymenttype: Int?
    var payment: String?
    
    init(date: Date, docID: String, worker: String?, address: String, rate: Int?, comment: Comment?, periodo: Int, price: Double?, discount: Int?, done: Bool, paymenttype: Int?, payment: String?) {
        self.date = date
        self.worker = worker
        self.address = address
        self.rate = rate
        self.comment = comment
        self.periodo = periodo
        self.price = price
        self.discount = discount
        self.done = done
        self.paymenttype = paymenttype
        self.payment = payment
    }
}

class Addressess {
    var cep: String
    var logradouro: String
    var number: String?
    var bairro: String
    var cidade: String
    var estado: String
    var comp: String?
    var pref: String?
    var addrtype: Int
    var sqrm: Double
    var detalhes: String?
    
    init(cep: String, logradouro: String, number: String?, bairro: String, cidade: String, estado: String, comp: String?, pref: String?, addrtype: Int, sqrm: Double, detalhes: String?) {
        self.cep = cep
        self.logradouro = logradouro
        self.number = number
        self.bairro = bairro
        self.cidade = cidade
        self.estado = estado
        self.comp = comp
        self.pref = pref
        self.addrtype = addrtype
        self.sqrm = sqrm
        self.detalhes = detalhes
    }
}
