//
//  SignInView.swift
//  E-commerce
//
//  Created by Mister Okine on 19/02/2022.
//

import SwiftUI
import Firebase
import Combine
import LocalAuthentication


struct SignInView: View {
    @ObservedObject var emailObj = EmailValidationObj()
    @ObservedObject var passObj = PasswordValidationObj()
    @State var show = false
    @AppStorage("log_Status") var status = false
    @State var visible = false
    @State var alert = false
    @State var error = ""
    @State var msg = ""
    @State var creation = false
    @State var loading = false
    @State private var isAnimating :Bool = false
    @Environment(\.presentationMode) var presentationMode


    var body: some View {
        NavigationView{
            ZStack{
                ScrollView(.vertical,showsIndicators: false){
                    VStack{
                            Image("logo")
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 180, height: 180, alignment: .center)
                            .cornerRadius(20)
                            .padding(.bottom,10)
                            .padding(.top,30)
                            
        //                    Text("Welcome Back!")
        //                        .font(.title)
        //                        .font(Font.system(size: 24))
        //                        .fontWeight(.light)
        //                        .multilineTextAlignment(.leading)
        //                        .shadow(color: .gray, radius: 1, x: 1.6, y: 3.0)
                            
                            Text("Login To Continue")
                                .font(.title3)
                                .fontWeight(.heavy)
                                .padding(.bottom,20)

                        VStack(spacing: 20){
                            VStack(alignment: .leading, spacing: 4) {
                                HStack{
                                    Image(systemName: "envelope").padding()
                                    
                                    TextField("Enter Email", text: $emailObj.email).font(Font.system(size: 18))
                                        .multilineTextAlignment(.leading)
                                        .foregroundColor(.black)
                                        .padding()
                                        
                                }
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                                .frame(width: UIScreen.main.bounds.width-50, height: 45)
                                    Text(emailObj.error).foregroundColor(.red).font(.caption).padding(.top,5)
                                        
                            }
                            VStack(alignment: .leading, spacing: 4) {
                                HStack{
                                    Image(systemName: "lock").padding()
                                    if self.visible {
                                    
                                    TextField("Password", text: $passObj.pass).foregroundColor(.black).font(Font.system(size: 20))
                                        .multilineTextAlignment(.leading)
                                        .foregroundColor(.black)
                                        .padding()

                                    }
                                    else{
                                        SecureField("Password",text: $passObj.pass).padding().font(Font.system(size: 20))
                                    }
                                    
                                    Button(action: {
                                        self.visible.toggle()
                                    })
                                    {
                                        Image(systemName: self.visible ? "eye.slash.fill": "eye.fill").padding(.trailing,5).foregroundColor(Color.blue)
                                    }
                                    
                                }
                                .frame(width: UIScreen.main.bounds.width-50, height: 45)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))

                                Text(passObj.error).foregroundColor(.red).font(.caption).padding(.top,5)
                            }
                            HStack{
                                Spacer()
                                Button( action: {
                                    self.reset()
                                })
                                {
                                    Text("Forgot Password?")
                                        .fontWeight(.light)
                                        .foregroundColor(Color.red)
                                        .italic()
                                        .padding(.bottom,15)
                                        .padding(.trailing,5)
                                        
                                }
                            }.contextMenu{
                                alert(isPresented: $alert){
                                    Alert(title: Text("Error"), message: Text(self.error), dismissButton: .default(Text("Okay")))
                                 }
                                .frame(width: UIScreen.main.bounds.width - 20)
                            }
                            
                            if self.loading{
                                
                                HStack{
                                    
                                    Spacer()

                                    Spacer()
                                }
                            }
                            else {
                                Button( action: {
                                    
                                    self.verify()
                                    self.loading.toggle()

                                        })
                                        {
                                        Text("Login")
                                            .foregroundColor(Color.white)
                                            .font(.system(size: 22))
                                            .padding(.vertical)
                                            .frame(width: UIScreen.main.bounds.width - 100)
                                    
                                }
                                .background(Color.black)
                                .disabled(emailObj.email != "" && passObj.pass != "" ? false : true)
                                .cornerRadius(15)
                                .alert(isPresented: $alert){
                                   Alert(title: Text("Error"), message: Text(self.error), dismissButton: .default(Text("Okay")))
                                }
                            }
                        }
                        Divider()
                            .padding(.top,20)
                        NavigationLink(destination: SignUp(show: self.$show), isActive: self.$show) {
                                                      
                                                      Text("")
                                                  }
                                                  .hidden()
                        Button(action: {
                                              self.show.toggle()
                                          }) {
                                              
                                              Text("Create An Account")
                                                .italic()
                                                .fontWeight(.regular)
                                                .foregroundColor(Color.blue)
                                          }
                                          .padding()
                    }
                    .padding(.top, 20)
                }
                
                
            }
            .navigationBarItems(
                trailing:
                  Button(action: {
                    presentationMode.wrappedValue.dismiss()
                  }) {
                    Image(systemName: "xmark")
                  }
              )
              .padding()
            .edgesIgnoringSafeArea(.all)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        
                
    }
    func reset(){
              
              if emailObj.email != ""{
                  
                  Auth.auth().sendPasswordReset(withEmail: emailObj.email) { (err) in
                    self.loading.toggle()
                      if err != nil{
                          
                          self.error = err!.localizedDescription
                          self.alert.toggle()
                          return
                      }
                      
                      self.error = "RESET"
                      self.alert.toggle()
                  }
              }
              else{
                  
                  self.error = "Email is empty !"
                  self.alert.toggle()
              }
          }
    func verify(){
              
        if emailObj.email != "" && passObj.pass != "" {
            
                  Auth.auth().signIn(withEmail: emailObj.email, password: passObj.pass) { (res, err) in
                      
                    self.loading.toggle()
                      if err != nil{
                          
                          self.error = err!.localizedDescription
                          self.alert.toggle()
                        return
                      }
                    
                    print("Successful")
                    withAnimation{self.status = true}
                    UserDefaults.standard.set(true, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                    
                  }
              }
              else{
                  
                  self.error = "Please fill all the contents properly"
                  self.alert.toggle()
                self.loading.toggle()
                
              }
          }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}



class UpdateDetails : ObservableObject {
    @Published var firstname = ""
    @Published var lastname = ""
    @Published var contact = ""
    
    @Published var isFirstnameValid = false
    @Published var isLastnameValid = false
    @Published var isContactValid = false

    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        $firstname
            .receive(on: RunLoop.main)
            .map{
                firstname in
                return firstname.count > 2
            }.assign(to: \.isFirstnameValid , on: self)
            .store(in: &cancellableSet)
    
        $lastname
            .receive(on: RunLoop.main)
            .map{
                lastname in
                return lastname.count > 2
            }.assign(to: \.isLastnameValid , on: self)
            .store(in: &cancellableSet)
    
        $contact
            .receive(on: RunLoop.main)
            .map{
                contact in
            return contact.count > 9 && contact.count <= 13
            }.assign(to: \.isContactValid , on: self)
            .store(in: &cancellableSet)
    }
}

extension String {
    // TODO: Test cases
    func isValidEmail() -> Bool {
        let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}"
            + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
            + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
            + "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
            + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
            + "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
            + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"

        let emailValidation = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailValidation.evaluate(with: self)
    }
    
    func isPassword() -> Bool {
        let passwordRegex = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<]{6,}$"
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return passwordPred.evaluate(with: self)
    }
    
    func isUpperCase() -> Bool {
        let uppercaseReqRegex = ".*[A-Z]+.*"
        return NSPredicate(format:"SELF MATCHES %@", uppercaseReqRegex).evaluate(with: self)
    }
    
    func isLowerCase() -> Bool {
        let lowercaseReqRegex = ".*[a-z]+.*"
        return NSPredicate(format:"SELF MATCHES %@", lowercaseReqRegex).evaluate(with: self)
    }
    
    func containsCharacter() -> Bool {
        let characterReqRegex = ".*[!@#$%^&*()\\-_=+{}|?>.<]+.*"
        return NSPredicate(format:"SELF MATCHES %@", characterReqRegex).evaluate(with: self)
    }
    
    func containsDigit() -> Bool {
        let digitReqRegex = ".*[0-9]+.*"
        return NSPredicate(format:"SELF MATCHES %@", digitReqRegex).evaluate(with: self)
    }
}

class EmailValidationObj: ObservableObject {
    @Published var email = "" {
        didSet {
            if self.email.isEmpty {
                self.error = "Required*"
            } else if !self.email.isValidEmail() {
                self.error = "Invalid email"
            } else {
                self.error = ""
            }
        }
    }
    
    @Published var error = ""
}


class PasswordValidationObj: ObservableObject {
    @Published var pass = "" {
        didSet {
            self.isValidPassword()
        }
    }
    
    @Published var error = ""
    
    private func isValidPassword() {
        guard !self.pass.isEmpty else {
            self.error = "Required*"
            return
        }
        
        let setPassError = self.pass.isPassword() == false
        
        if setPassError {
            if self.pass.count < 7 {
                self.error = "Must be at least 7 characters"
            } else if !self.pass.isUpperCase() {
                self.error = "Must contain at least one uppercase."
            } else if !self.pass.isLowerCase() {
                self.error = "Must contain at least one lowercase"
            } else if !self.pass.containsCharacter() {
                self.error = "Must contain at least one special character"
            } else if !self.pass.containsDigit() {
                self.error = "Must contain at least one digit"
            }
            
        } else {
             if self.pass.count < 7 || !self.pass.isLowerCase() || !self.pass.isUpperCase() || !self.pass.containsCharacter() {
                self.error = "Hint:Must contain 1 Uppercase,1 lowercase and a Special Character"
            }
             else{
                self.error = ""
             }
            
        }
    }
}

class PasswordValidObj: ObservableObject {
    @Published var cpass = "" {
        didSet {
            self.isValidPassword()
        }
    }
    
    @Published var error = ""
    
    private func isValidPassword() {
        guard !self.cpass.isEmpty else {
            self.error = "Required*"
            return
        }
        
        let setPassError = self.cpass.isPassword() == false
        
        if setPassError {
            if self.cpass.count < 7 {
                self.error = "Must be at least 7 characters"
            } else if !self.cpass.isUpperCase() {
                self.error = "Must contain at least one uppercase."
            } else if !self.cpass.isLowerCase() {
                self.error = "Must contain at least one lowercase"
            } else if !self.cpass.containsCharacter() {
                self.error = "Must contain at least one special character"
            } else if !self.cpass.containsDigit() {
                self.error = "Must contain at least one digit"
            }
            
        } else {
            if self.cpass.count < 7 || !self.cpass.isLowerCase() || !self.cpass.isUpperCase() || !self.cpass.containsCharacter() {
                self.error = "Hint:Must contain 1 Uppercase,1 lowercase and a Special Character"
            }
            else{
                self.error = ""
            }
            
        }
    }
}
class NumbersOnly: ObservableObject {
    @Published var value = "" {
        didSet {
            let filtered = value.filter { $0.isNumber }
            
            if value != filtered {
                value = filtered
            }
        }
    }
}
struct Validation: View {
    var icon: String
    var color: Color
    var message: String
    
    var body: some View{
        
        HStack{
            Image(systemName: icon).foregroundColor(color).font(.caption2)
            Text(message).foregroundColor(color).font(.caption2)
        }
        
    }
}

struct SignUp : View {
    @ObservedObject var emailObj = EmailValidationObj()
    @ObservedObject var passObj = PasswordValidationObj()
    @ObservedObject var cpassObj = PasswordValidObj()
    @ObservedObject var input = NumbersOnly()
    @ObservedObject var updateDetails = UpdateDetails()
    @State var color = Color.black.opacity(0.7)
    @State var visible = false
    @State var revisible = false
    @Binding var show : Bool
    @State var alert = false
    @State var error = ""
    @State var creation = false
    @State var loading = false
    @State var msg = ""
    @Environment(\.presentationMode) var presentationMode

    
     
     var body: some View{
         
         ZStack{
            ZStack(alignment: .topLeading) {
                 
                ScrollView(.vertical,showsIndicators: false){
                     VStack(spacing:10){
                         
                         Image("logo")
                             .resizable()
                             .renderingMode(.original)
                             .frame(width: 150, height: 150, alignment: .center)
                             .cornerRadius(20)
                            .padding(.bottom,10)
                        
                        HStack{
                             Text("Register to get Started")
                                .font(.title)
                                 .fontWeight(.heavy)
                                .foregroundColor(Color.black)
                            
                        }
                        .padding(.bottom,15)
                        
                        VStack(alignment: .leading, spacing: 7) {
                            
                            HStack{
                                Image(systemName: "envelope").padding()
                                
                                TextField("Email", text: $emailObj.email).font(Font.system(size: 16))
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(height: 45)
                                    
                            }
                            .frame(width: UIScreen.main.bounds.width-50)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                            
                                Text(emailObj.error).foregroundColor(.red).font(.caption)
                                    
                        }
                        
                        VStack(alignment: .leading, spacing: 7) {
                            HStack{
                                Image(systemName: "lock").padding()
                                if self.visible {
                                TextField("Enter Password", text: $passObj.pass).foregroundColor(.black).font(Font.system(size: 16))
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(height: 45)
                            
                                }
                                else {
                                    SecureField("Enter Password", text: $passObj.pass).padding().font(Font.system(size: 16))
                                }
                                Button(action: {
                                    self.visible.toggle()
                                })
                                {
                                    Image(systemName: self.visible ? "eye.slash.fill": "eye.fill").padding().foregroundColor(Color.blue)
                                }
                                

                            }
                            .frame(width: UIScreen.main.bounds.width-50)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))

                            Text(passObj.error).foregroundColor(.red).font(.caption)
                        }
                        VStack(alignment: .leading, spacing: 7) {
                            HStack{
                                Image(systemName: "lock").padding()
                                if self.revisible{
                                
                                    TextField("Confirm Password", text: $cpassObj.cpass).foregroundColor(.black).font(Font.system(size: 16))
                                        .multilineTextAlignment(.leading)
                                        .foregroundColor(.black)
                                        .padding()
                                        .frame(height: 45)
                                }
                                else{
                                    SecureField("Confirm Password", text: $cpassObj.cpass).padding().font(Font.system(size: 16))

                                }
                                Button(action: {
                                    self.revisible.toggle()
                                })
                                {
                                    Image(systemName: self.revisible ? "eye.slash.fill": "eye.fill").padding().foregroundColor(Color.blue)
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width-50)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))

                            Text(cpassObj.error).foregroundColor(.red).font(.caption)
                            
                            if cpassObj.error == "" && passObj.pass != cpassObj.cpass && cpassObj.cpass != ""{
                               
                                    Validation(icon: "exclamationmark.triangle.fill", color: Color.red, message: "Passwords don't match")
                                
                            }
                        
                            HStack (spacing: 10){
                                Image(systemName: "phone")
                                    .padding()
                                
                                TextField("Phone", text: $input.value)
                                    .padding()
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.black)
                                    
                                    .keyboardType(.decimalPad)
                            }
                            .frame(width: UIScreen.main.bounds.width-50, height: 50)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                        }
                        if self.loading{
                            HStack{
                                
                                Spacer()
                                
                                Spacer()
                                
                            }
                        }
                            
                            else {
                                Button(action: {
                                    
                                    self.register()
                                    
                                    self.loading.toggle()
                                    self.creation.toggle()
                                  
                                
                                }) {
                                    
                                    Text("Register")
                                        .foregroundColor(.white)
                                        .padding(.vertical)
                                        .frame(width: UIScreen.main.bounds.width - 100)
                                }
                                .disabled(!(passObj.pass == cpassObj.cpass))
                                .background(Color.black)
                                .cornerRadius(15)
                                .padding(.top, 25)
                                .alert(isPresented: $alert){
                                   Alert(title: Text("Error"), message: Text(self.error), dismissButton: .default(Text("Ok")))
                                }
                            }
                        Divider()
                        
                        NavigationLink(destination: SignInView()) {
                            
                            Text("Already have an Account? Login Instead")
                                .fontWeight(.light)
                                .italic()
                                .foregroundColor(.blue)
                                .edgesIgnoringSafeArea(.bottom)
                                
                        }
                     }
                     .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                     .edgesIgnoringSafeArea(.all)
                }
                .padding(.top, 20)
              .edgesIgnoringSafeArea(.all)
                 
                
            }
            .navigationBarItems(
                trailing:
                  Button(action: {
                    presentationMode.wrappedValue.dismiss()
                  }) {
                    Image(systemName: "xmark")
                  }
              )
            .padding(.bottom, 30)
            .edgesIgnoringSafeArea(.bottom)
            
        
         }
        .edgesIgnoringSafeArea(.all)
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("")
        
     
     
     }
     
    func getBioMetricStatus()->Bool{
              
              let scanner = LAContext()
        if emailObj.email.isValidEmail() == true && passObj.pass.isPassword() == true && scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none){
                  
                  return true
              }
              
              return false
          }
          
          // authenticate User...
          
          func authenticateUser(){
              
              let scanner = LAContext()
            scanner.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To Continue to Login to your account") { (status, err) in
                  if err != nil{
                      print(err!.localizedDescription)
                      return
                  }
                  else {
                    register()

                  }
            }
        }
    
    func register(){
              
        if emailObj.email != ""{
                  
            if passObj.pass == cpassObj.cpass{
                
                Auth.auth().createUser(withEmail: emailObj.email, password: passObj.pass) { (res, err) in
                
                    self.loading.toggle()
                    
                          if err != nil{
                              
                              self.error = err!.localizedDescription
                              self.alert.toggle()
                              return
                          }
//                    Auth.auth().signIn(withEmail: emailObj.email, password: passObj.pass) { (res, err) in
//
//                              if err != nil{
//
//                                error = err!.localizedDescription
//                                alert.toggle()
//                                  return
//                              }
//
//
//                              print("success")
//                              UserDefaults.standard.set(true, forKey: "status")
//                              NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
//                          }
                    
                          print("success")


                    
                      }
                  }
            
                  else{
                      
                      self.error = "Wrong Password"
                      self.alert.toggle()
                    
                  }
              }
        
              else{
                  
                  self.error = "Please fill all the contents"
                self.alert.toggle()
                self.loading.toggle()
              }
    }
    
    
}


