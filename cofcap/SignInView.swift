//
//  SignInView.swift
//  cofcap
//
//  Created by 김유빈 on 3/4/24.
//

import SwiftUI

struct SignInView: View {
    @State var isShow : Bool = false
    @Environment(\.presentationMode) var presentationMode
    @State var loginId : String = ""
    @State var loginPw : String = ""
    @State var loginSuccess : Bool = false
    var body: some View {
      
            VStack{

                
                ZStack() {
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 25))
                            .foregroundColor(.black)
                        
                    }
                    .frame(width: 350, height: 740, alignment: .topLeading)
                    VStack{
                        //Text("ddd")
                        Image("logo")
                            .resizable()
                            .frame(width:240, height: 150)
                        
                        
                        PlaceHolderField("아이디를 입력하세요.", font: .custom("", fixedSize: 16), color: .gray, text: $loginId)
                            .padding(.leading, 20)
                            .frame(width: 300, height: 40, alignment: .leading)
                            .padding(.trailing, 50)
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                            .background() {
                                RoundedRectangle(cornerRadius: 15.0)
                                    .frame(width: 350, height: 50)
                                    .foregroundColor(Color.white)
                            }.padding(.top)
                        
                        PlaceHolderField2("비밀번호를 입력하세요.", font: .custom("", fixedSize: 16), color: .gray, text: $loginPw)
                            .padding(.leading, 20)
                            .frame(width: 350, height: 40)
                            .background() {
                                RoundedRectangle(cornerRadius: 15.0)
                                    .frame(width: 350, height: 50)
                                    .foregroundColor(Color.white)
                            }
                            .disableAutocorrection(true) //자동 수정 비활성화
                            .autocapitalization(.none)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.alphabet)
                            .textContentType(.newPassword)
                            .autocorrectionDisabled()
                            .padding(.top)
                        
                        Button(action: {
                            login()
                            
                        }) {
                            ZStack{
                                RoundedRectangle(cornerRadius: 30.0)
                                    .frame(width: 350, height: 50)
                                    .foregroundColor(Color.pink)
                                Text("로그인")
                                    .foregroundColor(Color.white)
                            }
                            
                        }
                        .padding(.top, 25)
                        .buttonStyle(.plain)
                     
                        Button {
                            self.isShow.toggle()
                        } label: {
                            ZStack{
                                Text("회원가입 하기")
                                    .font(.system(size: 15))
                                    .foregroundColor(.gray)
                                    .padding(.top, 6)
                            }
                        }
       
                        .buttonStyle(PlainButtonStyle())
                        .fullScreenCover(isPresented: $isShow) {
                            SignUpView()
                        }
                        
                        
                    }
                    
                    
                    
                    
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Color.teal.opacity(0.3)
                    .ignoresSafeArea()
            }
            .navigationBarBackButtonHidden(true)
      
        .fullScreenCover(isPresented: $loginSuccess, content: {
            HomeView()
        })
    }
    
    
    func login() {
        let id = loginId
        let password = loginPw
        var result = ""
        
        UserService.shared.login(id: id, password: password){
            responseObject, error in guard let _ = responseObject, error == nil else {
            print(error ?? "Unknown error")
            return
            }
            result = responseObject?["successLoginId"] ?? ""
            print(result)
            UserDefaults.standard.setValue(result, forKey: "loginId")
            loginSuccess = true
        }
 
    }
}

#Preview {
    SignInView()
}
