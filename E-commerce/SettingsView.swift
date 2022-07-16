//
//  SettingsView.swift
//  E-commerce
//
//  Created by Mister Okine on 19/02/2022.
//

import SwiftUI
import Firebase

struct SettingsView: View {
  
  @Environment(\.presentationMode) var presentationMode
  @AppStorage("isOnboarding") var isOnboarding: Bool = false
    @AppStorage("log_Status") var status = false


  var body: some View {
    NavigationView {
      ScrollView(.vertical, showsIndicators: false) {
        VStack(spacing: 20) {
          
          GroupBox(
            label:
              SettingsLabelView(labelText: "Certified", labelImage: "info.circle")
          ) {
            Divider().padding(.vertical, 4)
            
            HStack(alignment: .center, spacing: 10) {
              Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .cornerRadius(9)
              
              Text("This iOS Ecommerce App is built in order to make buying of Authentic Apple products fast, efficient and moreover safe as they're no doubts over the product you are purchasing from us")
                .font(.footnote)
            }
          }
          
          
          GroupBox(
            label: SettingsLabelView(labelText: "Any Hitches?", labelImage: "questionmark.square")
          ) {
            Divider().padding(.vertical, 4)
            
            Text("Incase you're experiencing any technical hitches or facing any challenges with the use of this Application, you can restart the application by toggle the switch in this box. Hope your problem is fixed? If not kindly send us a mail.")
              .padding(.vertical, 8)
              .frame(minHeight: 60)
              .layoutPriority(1)
              .font(.footnote)
              .multilineTextAlignment(.leading)
            
            Toggle(isOn: $isOnboarding) {
              if isOnboarding {
                Text("Restarted".uppercased())
                  .fontWeight(.bold)
                  .foregroundColor(Color.green)
              } else {
                Text("Restart".uppercased())
                  .fontWeight(.bold)
                  .foregroundColor(Color.secondary)
              }
            }
            .padding()
            .background(
              Color(UIColor.tertiarySystemBackground)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            )
          }
          
          
          GroupBox(
            label:
            SettingsLabelView(labelText: "Reach Us On", labelImage: "apps.iphone")
          ) {
            SettingsRowView(name: "Github", linkLabel: "SidneyOkine", linkDestination: "github.com/Sidney-Okine")
            SettingsRowView(name: "Twitter", linkLabel: "Sidney Okine" ,linkDestination: "twitter.com/OkineSidney")
            SettingsRowView(name: "Whatsapp", linkLabel: "Sidney Okine", linkDestination: "wa.me/message/YGTWZNOCO6RFI1")
            SettingsRowView(name: "LinkedIn", linkLabel: "Sidney Okine", linkDestination: "linkedin.com/in/okinesidney")
            SettingsRowView(name: "Website", linkLabel: "Sidney Okine", linkDestination: "sidneyokine.netlify.app")
            SettingsRowView(name: "Version", content: "1.0")
          }
            GroupBox(
            ) {
                if (status == false){
                    NavigationLink(destination: SignInView()){
                        HStack(spacing:30){
                            Text("Sign In".uppercased())
                            
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                        }
                    }

                }
                else{
                    Button(action: {
            
                        try? Auth.auth().signOut()
                        withAnimation{status = false}

                    })
                    {
                        HStack(spacing:30){
                            Text("Sign Out".uppercased())
                            
                        Image(systemName: "power")
                        }

                    }
                   
                }
              
            }
          
        }
        .navigationBarTitle(Text("Settings"), displayMode: .large)
        .navigationBarItems(
          trailing:
            Button(action: {
              presentationMode.wrappedValue.dismiss()
            }) {
              Image(systemName: "xmark")
            }
        )
        .padding()
      }
    }
  }
}

// MARK: - PREVIEW

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
      .preferredColorScheme(.dark)
  }
}
