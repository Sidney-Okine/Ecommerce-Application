//
//  OnBoardingView.swift
//  OnBoardingView
//
//

import SwiftUI

struct OnBoardingView: View {
    
    var productshow : [Product] = productData
    var body: some View {
        TabView{
            ForEach(productshow[0...4].shuffled()){ item in
                AppleProductsCardView(product: item)
            }
            
        }
        .tabViewStyle(PageTabViewStyle())
        .padding(.vertical,0)
        .edgesIgnoringSafeArea(.all)

    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView(productshow: productData)
    }
}
