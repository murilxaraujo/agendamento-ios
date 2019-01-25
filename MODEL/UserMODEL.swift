//
//  UserMODEL.swift
//  MaryLimp
//
//  Created by Murilo Araujo on 04/12/18.
//  Copyright © 2018 Murilo Oliveira de Araujo. All rights reserved.
//

import Foundation

class PFUser {
    var uid: String!
    var cpf: String!
    var email: String!
    var name: [String:String]!
    var phone: String!
    var type: Int!
    
    init(uid: String!, cpf: String!, email: String!, name: [String: String]!, phone: String!) {
        self.uid = uid
        self.cpf = cpf
        self.email = email
        self.name = name
        self.phone = phone
        self.type = 0
    }
}

class PJUser {
    var uid: String!
    var cpf: String!
    var cnpj: String!
    var email: String!
    var razao: String!
    var phone: String!
    var rep: String!
    var type: Int!
    
    init(uid: String!, cpf: String!, cnpj: String!, email: String!, razao: String!, phone: String!, rep: String!) {
        self.uid = uid
        self.cpf = cpf
        self.cnpj = cnpj
        self.email = email
        self.razao = razao
        self.phone = phone
        self.rep = rep
        self.type = 1
    }
}

struct EndereçoAPI: Decodable {
    let endereco: String
    let bairro: String
    let cidade: String
    let uf: String
    let cep: String
}
