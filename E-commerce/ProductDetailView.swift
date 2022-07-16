//
//  ProductDetailView.swift
//  ProductDetailView
//
//  Created by Mister Okine on 16/02/2022.
//

import SwiftUI

struct ProductDetailView: View {
    var product : Product
    var body: some View {

            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .center, spacing: 20){
                    ProductHeaderView(product: product)

                    VStack(alignment: .leading, spacing: 20){
                        
                        Text(product.title)
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                        
                        Text(product.summary)
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Text("Overview of the \(product.title)")
                            .fontWeight(.bold)
                            .foregroundColor(Color.blue)
                        
                        Text(product.description)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Color.black)
                        
                        LinkView(product: product)
                            .padding(.bottom,30)
                            .padding(.top,15)
                    }
                    .padding(.horizontal,20)
                    .frame(maxWidth:640,alignment: .center)
                    

                }

                
            }
            .edgesIgnoringSafeArea(.top)
            
       
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: productData[0])
    }
}
