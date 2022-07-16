//
//  TabButton.swift
//  TabButton
//
//  Created by Mister Okine on 15/02/2022.
//

import SwiftUI

struct TabButton: View {
    var title: String
    @Binding var selected: String
    var animation: Namespace.ID
    
    var body: some View {
        
        Button(action: { withAnimation(.spring()){selected = title}}){
                
                Text(title)
                    .font(.system(size: 15))
                    .foregroundColor(selected == title ? .white : .black)
                    .padding(.vertical,10)
                    .padding(.horizontal,selected == title ? 20 : 0)
                    .background(
                        ZStack{
                            if selected == title {
                                Color.black
                                    .clipShape(Capsule())
                                    .matchedGeometryEffect(id: "Tab", in: animation)
                                    .frame(maxWidth: .infinity)

                            }
                        }
                    )

            }

    }
}

