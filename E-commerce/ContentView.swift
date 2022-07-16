//
//  ContentView.swift
//  AppleProducts
//
//  Created by Mister Okine on 14/02/2022.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("log_Status") var status = false
    @State var show = false
    var products : [Product] = productData
    var iPhoneProducts : [Product] = iPhoneProductData
    var macProducts : [Product] =  macProductData
    var hometvproducts : [Product] = homeAndTvData
    var iPadProducts : [Product] = iPadData
    var accessories : [Product] = appleAccessories
    var watches : [Product] = watchProducts
    @State private var isShowingSettings: Bool = false
    @StateObject var cartManager = CartManager()

    
    @State var selected = tabs[0]

    @Namespace var animation
    private var gridItemLayout = [GridItem(.flexible())]
    
    
    var body: some View {
        NavigationView{

            ScrollView{
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 5){
                        ForEach(tabs,id: \.self){tab in
                            TabButton(title: tab, selected: $selected, animation: animation)
                            if tabs.last != tab{Spacer(minLength: 0)}

                        }
                        
                    }
                    .padding()
                }
                if selected == tabs[0] {
                    LazyVGrid(columns: gridItemLayout, spacing: 20){
                        ForEach(products.shuffled()) { item in
                            NavigationLink(destination: ProductDetailView(product: item)){
                                CardView(product: item)
                                    .environmentObject(cartManager)
                                    .padding(.vertical,4)
                            }

                        }
                    }
                }
                if selected == tabs[1] {
                    LazyVGrid(columns: gridItemLayout, spacing: 20){
                        ForEach(iPhoneProducts) { item in
                            NavigationLink(destination: ProductDetailView(product: item)){
                                CardView(product: item)
                                    .environmentObject(cartManager)
                                    .padding(.vertical,4)
                            }
                        }
                    }
                }
                if selected == tabs[2] {
                    LazyVGrid(columns: gridItemLayout, spacing: 20){
                        ForEach(iPadProducts) { item in
                            NavigationLink(destination: ProductDetailView(product: item)){
                                CardView(product: item)
                                    .environmentObject(cartManager)
                                    .padding(.vertical,4)
                            }
                        }
                    }
                }
                if selected == tabs[3] {
                    LazyVGrid(columns: gridItemLayout, spacing: 20){
                        ForEach(macProducts) { item in
                            NavigationLink(destination: ProductDetailView(product: item)){
                                CardView(product: item)
                                    .environmentObject(cartManager)
                                    .padding(.vertical,4)
                            }
                        }
                    }
                }
                if selected == tabs[4] {
                    LazyVGrid(columns: gridItemLayout, spacing: 20){
                        ForEach(watches) { item in
                            NavigationLink(destination: ProductDetailView(product: item)){
                                CardView(product: item)
                                    .environmentObject(cartManager)
                                    .padding(.vertical,4)
                            }
                        }
                    }
                }
                if selected == tabs[5] {
                    LazyVGrid(columns: gridItemLayout, spacing: 20){
                        ForEach(homeAndTvData) { item in
                            NavigationLink(destination: ProductDetailView(product: item)){
                                CardView(product: item)
                                    .environmentObject(cartManager)
                                    .padding(.vertical,4)
                            }
                        }
                    }
                }
                if selected == tabs[6] {
                    LazyVGrid(columns: gridItemLayout, spacing: 20){
                        ForEach(airPods) { item in
                            NavigationLink(destination: ProductDetailView(product: item)){
                                CardView(product: item)
                                    .environmentObject(cartManager)
                                    .padding(.vertical,4)
                            }
                        }
                    }
                }
                if selected == tabs[7] {
                    LazyVGrid(columns: gridItemLayout, spacing: 20){
                        ForEach(accessories) { item in
                            NavigationLink(destination: ProductDetailView(product: item)){
                                CardView(product: item)
                                    .environmentObject(cartManager)
                                    .padding(.vertical,4)
                            }
                        }
                    }
                }

            }
            .navigationBarItems(leading:
                                    Button(action: {
                                      isShowingSettings = true
                                    }) {
                                      Image(systemName: "slider.horizontal.3").foregroundColor(Color.blue)
                                    } //: BUTTON
                                    .sheet(isPresented: $isShowingSettings) {
                                      SettingsView()
                                    }
           )
            .toolbar {
                            NavigationLink {
                                CartView()
                                    .environmentObject(cartManager)
                            } label: {
                                CartButton(numberOfProducts: cartManager.products.count)
                            }
                        }
            .navigationTitle(selected)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
var tabs = ["Latest Deals 🎊","iPhone","iPad","Mac","Watch","TV & Home","AirPods","Accessories"]


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
