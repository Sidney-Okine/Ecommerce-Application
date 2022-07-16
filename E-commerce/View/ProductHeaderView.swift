//
//  ProductHeaderView.swift
//  E-commerce
//
//  Created by Mister Okine on 17/02/2022.
//

import SwiftUI

struct ProductHeaderView: View {
    @State private var isAnimatingImage :Bool = false
    var product: Product
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color("Light Gray"),Color("Light Gray")]), startPoint: .topLeading, endPoint: .bottomTrailing)
            Image(product.image)
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width - 75, height: UIScreen.main.bounds.height/2.4, alignment: .center)
                .shadow(color: Color(red: 0, green: 0, blue: 0), radius: 8, x: 6, y: 8)
                .padding(.vertical,20)
                .scaleEffect(isAnimatingImage ? 1.0 : 0.6)
        }
        .onAppear(){
            withAnimation(.easeOut(duration: 0.8)){
                isAnimatingImage = true
            }
        }
        .frame(height:450)
    }
}
