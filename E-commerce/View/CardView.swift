//
//  CardView.swift
//  CardView
//
//  Created by Mister Okine on 15/02/2022.
//

import SwiftUI

struct CardView: View {
    var product : Product
    @EnvironmentObject var cartManager: CartManager
    var body: some View {
        ZStack(alignment: .topTrailing){
            Button {
                cartManager.addToCart(product: product)
                
            } label: {
                Image(systemName: "plus")
                                .padding(10)
                                .foregroundColor(.white)
                                .background(.blue)
                                .cornerRadius(50)
                                .padding()
                        }
                VStack{
                    Image(product.image)
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 280, height: 200, alignment: .center)
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.20), radius: 2, x: 2, y: 5)
                        
                    Text(product.title)
                        .fontWeight(.heavy)
                        .font(.title2)
                                            
                    HStack{
                        Text("$\(product.price).00")
                            .padding(.horizontal,15)
                        
                        Button(action:{
                            
                        })
                        {
                        Text("Buy Now")
                                
                        }
                        .padding(.horizontal,16)
                        .padding(.vertical,4)
                        .background(Color.blue)
                        .cornerRadius(20)
                        .foregroundColor(Color.white)
                    }
                    .padding(.top,3)
                }
            .frame( width: UIScreen.main.bounds.width-100, height: UIScreen.self.main.bounds.height / 2.2)
            
        }
        .background(Color("Light Gray"))
        .cornerRadius(20)
        .padding(.bottom,15)
        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.50), radius: 6, x: 2, y: 6)


    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(product: productData[0])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
