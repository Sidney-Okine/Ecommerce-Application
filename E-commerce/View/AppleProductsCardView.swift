//
//  AppleProductsCardView.swift
//  AppleProductsCardView
//
//  Created by Mister Okine on 14/02/2022.
//

import SwiftUI

struct AppleProductsCardView: View {
    @State private var isAnimating :Bool = false
    
    var product: Product
    
    var body: some View {
        ZStack{
//            Linear DarkGray Gradient
            LinearGradient(gradient: Gradient(colors: [Color.blue,Color.gray]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
//            Highlight Image
            VStack(spacing: 22){
                Image(product.image)
                    .resizable()
                    .scaledToFit()
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.30), radius: 8, x: 6, y: 9)
                    .scaleEffect(isAnimating ? 1.0 : 0.65)
//                Title of Image Highlight
                Text(product.title)
                    .foregroundColor(Color.black)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.10), radius: 2.5, x: 2.5, y: 2.5)
//           A brief intro/ summary of the item on display
                Text(product.summary)
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,10)
                
                StartButtonView()
                    .padding(.bottom,5)
                
            }
            .onAppear{
                withAnimation(.easeOut(duration:1)){
                    isAnimating = true
                }
            }
            .frame(minWidth:0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(Color.white)
            .cornerRadius(20)
            .padding(.horizontal,20)
            .padding(.vertical,30)
        }
    }
    
}

struct AppleProductsCardView_Previews: PreviewProvider {
    static var previews: some View {
        AppleProductsCardView(product: productData[1])
    }
}
