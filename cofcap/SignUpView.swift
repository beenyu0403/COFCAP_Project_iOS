//
//  SignUpView.swift
//  cofcap
//
//  Created by 김유빈 on 2/22/24.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var newMember : Member = .init(name: "", login: Login(loginId: "", loginPw: ""))
    @Environment(\.presentationMode) var presentationMode
    @State var signUpIdCheck : Bool = false
    @State var trueIdCheck : Bool = false
    @State var buttonTap : Bool = false
    @State var signUpName : String = ""
    @State var signUpId : String = ""
    @State var signUpPw : String = ""
    @State var signUpPw2 : String = ""
    @State var goHomeView : Bool = false
    @State var truePw : Bool = false
    
    var body: some View {
        ZStack{
            
            
            VStack{
                Text("이름")
                    .frame(width: 340, height: 40, alignment: .leading)
                PlaceHolderField("이름을 입력하세요.", font: .custom("", fixedSize: 16), color: .gray, text: $signUpName)
                    .padding(.leading, 20)
                    .frame(width: 350, height: 40)
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                    .background() {
                        RoundedRectangle(cornerRadius: 15.0)
                            .frame(width: 350, height: 50)
                            .foregroundColor(Color.white)
                    }
                    .onChange(of: signUpName) { newName in
                        newMember.name = signUpName
                    }
                    .padding(.bottom)
                Text("아이디")
                    .frame(width: 340, height: 40, alignment: .leading)
                ZStack{
                    
                    PlaceHolderField("아이디를 입력하세요.", font: .custom("", fixedSize: 16), color: .gray, text: $signUpId)
                        .padding(.leading, 20)
                        .frame(width: 300, height: 40, alignment: .leading)
                        .padding(.trailing, 50)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .background() {
                            RoundedRectangle(cornerRadius: 15.0)
                                .frame(width: 350, height: 50)
                                .foregroundColor(Color.white)
                        }
                        .onChange(of: signUpId) { newId in
                            trueIdCheck = false
                            idCheck(signUpId: newId)
                            buttonTap = false
                        }

                    Button(action: {
                        newMember.login.loginId = signUpId
                        print("아이디 중복 체크 버튼 클릭")
                        buttonTap = true
                        if (!signUpId.isEmpty && signUpIdCheck) {
                            print("중복되지 않음.")
                            trueIdCheck = true
                        }else if (!signUpId.isEmpty && !signUpIdCheck){
                            print("중복임.")
                            trueIdCheck = false
                        }

                    }) {
                        ZStack{

                            Image(systemName: "checkmark.bubble.fill")
                                .font(.system(size: 25, weight: .regular))
                                .foregroundColor(buttonTap && trueIdCheck ? Color.teal : Color.gray)
                              //  .frame(width: 40, height: 40)
                        }
                    }
                    .padding(.leading, 300)
                }
                .padding(.bottom)
                
                Text("비밀번호")
                    .frame(width: 340, height: 40, alignment: .leading)
                PlaceHolderField2("비밀번호를 입력하세요.", font: .custom("", fixedSize: 16), color: .gray, text: $signUpPw)
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
                    .onChange(of: signUpPw) { newPw in
                        newMember.login.loginPw = signUpPw
                    }
                    .padding(.bottom)
                
                PlaceHolderField2("비밀번호를 다시 입력하세요.", font: .custom("", fixedSize: 16), color: .gray, text: $signUpPw2)
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
                    .textContentType(.password)
                    .autocorrectionDisabled()
                    .padding(.bottom, 50)
                    .onSubmit {
                        if (signUpPw == signUpPw2) {
                            truePw = true
                        }
                    }
                    
                
                if (signUpName == "" || signUpId == "" || signUpPw == "" || signUpPw2 == "" || !truePw || !trueIdCheck) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 30.0)
                            .frame(width: 350, height: 50)
                            .foregroundColor(Color.gray)
                        Text("회원가입")
                            .foregroundColor(Color.white)
                    }
                }else{
                    Button(action: {
                        sendPostRequestMember("http://localhost:8080/api/v2/members", parameters: newMember){
                            responseObject, error in guard let _ = responseObject, error == nil else {
                            print(error ?? "Unknown error")
                            return
                        }
                        }
                        print("회원가입 완료")
                        goHomeView.toggle()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 30.0)
                                .frame(width: 350, height: 50)
                                .foregroundColor(Color.pink)
                            Text("회원가입")
                                .foregroundColor(Color.white)
                        }
                        
                    }

                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Color.teal.opacity(0.3)
                    .ignoresSafeArea()
            }
            if (buttonTap) {
                Text("이미 가입된 아이디입니다.")
                    .padding(.bottom, 40)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color.pink)
                    .opacity(trueIdCheck || signUpId.isEmpty ? 0 : 1)
                Text("가입할 수 있는 아이디입니다.")
                    .padding(.bottom, 40)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color.blue)
                    .opacity(trueIdCheck && !signUpId.isEmpty ? 1 : 0)
            }
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
                
            }) {
                Image(systemName: "xmark")
                    .font(.system(size: 25))
                    .foregroundColor(.black)
                
            }
            .frame(width: 350, height: 740, alignment: .topTrailing)
        }//z
    }
    
    func idCheck(signUpId : String)  {
        let inputIdCheck : IdCheck = .init(loginId: signUpId)
        //var result : Bool = false
        sendPostRequestCheckId("http://localhost:8080/api/v2/idcheck", parameters: inputIdCheck){
            responseObject, error in guard let _ = responseObject, error == nil else {
                print(error ?? "Unknown error")
                return
            }
                        
        }
    }
    
    func sendPostRequestCheckId(_ url: String, parameters: IdCheck, completion: @escaping ([String : Bool]?, Error?) -> Void) {
        let targetUrl = URL(string: url)
        
        let encoder = JSONEncoder()
        let encodedData = try? encoder.encode(parameters)
        
        var request = URLRequest(url: targetUrl!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = encodedData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let data = data,                              // is there data
                let response = response as? HTTPURLResponse,  // is there HTTP response
                200 ..< 300 ~= response.statusCode,           // is statusCode 2XX
                error == nil                                  // was there no error
            else {
                completion(nil, error)
                return
            }
            
            let responseObject = (try! JSONSerialization.jsonObject(with: data)) as! [String: Bool]
            completion(responseObject, nil)
            signUpIdCheck = responseObject["checkResult"] ?? false //false 이면 중복.

        }
        print(signUpIdCheck)

        task.resume()

    }
            
}


#Preview {
    SignUpView()
}
