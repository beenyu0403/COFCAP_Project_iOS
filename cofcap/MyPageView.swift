//
//  MyPageView.swift
//  cofcap
//
//  Created by 김유빈 on 2/28/24.
//

import SwiftUI

struct MyPageView: View {
    @State var userId = UserDefaults.standard.string(forKey: "loginId")
    var body: some View {
        ZStack{
            ZStack{
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .frame(width: 350, height: 200)
                    .foregroundColor(Color.teal.opacity(0.3))
                
                
                Text("마이페이지")
                    .frame(width: 300, height: 150, alignment: .top)
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                if (userId == nil) {
                    VStack{
                        Text("로그인하지 않았습니다.")
                            .frame(width: 300, height: 150)
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                        NavigationLink(destination: SignInView()) {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color.pink)
                                    .frame(width: 150, height: 30)
                                Text("회원 가입/로그인")
                                    .foregroundColor(.white)
                            }
                        }
                      //  .toolbar(.hidden, for: .tabBar)
                        .buttonStyle(PlainButtonStyle())
                    }
                }else{
                    Text(userId ?? "")
                        .frame(width: 300, height: 150)
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                }
                
                
            }.padding(.bottom, 450)
            if (userId != nil){
                VStack{
                    Button(action: {
                        UserDefaults.standard.removeObject(forKey: "loginId")
                    }) {
                        Text("로그아웃")
                    }
                    NavigationLink(destination: PurchaseRecordView()) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 25)
                                .frame(width: 350, height: 70)
                                .foregroundColor(Color.teal.opacity(0.3))
                            
                            Text("구매 기록")
                                .frame(width: 300, height: 70)
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }

            
        }
    }
}

#Preview {
    MyPageView()
}
