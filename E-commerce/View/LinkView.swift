//
//  LinkView.swift
//  E-commerce
//
//  Created by Mister Okine on 17/02/2022.
//

import SwiftUI

struct LinkView: View {
    var product : Product
    var body: some View {

        GroupBox() {
          HStack {
            Text("For more info")
            Spacer()
              Link(product.title, destination: URL(string: product.link)!).foregroundColor(Color.blue)
              Image(systemName: "arrow.up.right.square").foregroundColor(Color.blue)
          }
          .font(.footnote)
        }
    }
}

struct LinkView_Previews: PreviewProvider {
    static var previews: some View {
        LinkView(product: productData[0])
    }
}
