//
//  DetailButtonView.swift
//  DetailButtonView
//
//  Created by Mister Okine on 14/02/2022.
//

import SwiftUI

struct StartButtonView: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    var body: some View {
        Button(action: {
            isOnboarding = false
        })
        {
            HStack(spacing:10){
                Text("Start")
                
                Image(systemName: "bag.circle")
                    .imageScale(.large)
            }
            .padding(.horizontal,16)
            .padding(.vertical,7)
            .background(Capsule().strokeBorder(Color.black))
        }
        .accentColor(Color.black)    }
}

struct StartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StartButtonView()
            .previewLayout(.sizeThatFits)
    }
}
