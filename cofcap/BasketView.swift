//
//  BasketView.swift
//  cofcap
//
//  Created by 김유빈 on 2/28/24.
//

import SwiftUI

struct BasketView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var isShownFull = false
    @State var userId = UserDefaults.standard.string(forKey: "loginId")
    
    var body: some View {
        ZStack{
           
                VStack{
                    if (userId == nil){
                        
                        Image(systemName: "cart.fill")
                            .padding(.bottom, 10)
                        Text("로그인 후,\n카트에 담긴 상품을\n확인하세요.")
                            .multilineTextAlignment(.center)
        
                        NavigationLink(destination: SignInView()) {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color.teal.opacity(0.3))
                                    .frame(width: 150, height: 30)
                                Text("회원 가입/로그인")
                            }
                        }
                        .toolbar(.hidden, for: .tabBar)
                        .buttonStyle(PlainButtonStyle())
                        
                        
                       
                        
                    }else{
                        Text("장바구니가 비어있습니다.")
                    }
                    
                    
                }
                
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 25))
                    .foregroundColor(.black)
            }
            .frame(width: 350, height: 740, alignment: .topLeading)
            
        }
        .navigationBarBackButtonHidden(true)
        .onAppear(){
            userId = UserDefaults.standard.string(forKey: "loginId")
        }
    }
}

#Preview {
    BasketView()
}
