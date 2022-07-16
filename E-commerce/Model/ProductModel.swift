//
//  ProductModel.swift
//  ProductModel
//
//  Created by Mister Okine on 16/02/2022.
//

import SwiftUI

struct Product: Identifiable {
    var id = UUID()
    var title : String
    var summary: String
    var image: String
    var description: String
    var price: Int
    var link: String
}
