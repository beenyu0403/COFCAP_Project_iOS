//
//  ContentView.swift
//  cofcap
//
//  Created by 김유빈 on 2/22/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack {
                // MARK: 회원 기능
                Text("회원 기능")
                    .foregroundColor(Color.gray)
                
                NavigationLink(destination: SignUpView()) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.yellow)
                            .frame(width: 150, height: 30)
                        Text("회원 가입")
                    }
                }
                .padding(.top, 10.0)
                .buttonStyle(PlainButtonStyle())
                NavigationLink(destination: MemberView()) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.orange)
                            .frame(width: 150, height: 30)
                        Text("회원 목록")
                            
                    }
                }
                .padding(.bottom)
                .buttonStyle(PlainButtonStyle())
                
                // MARK: 상품 기능
                
                Text("상품 기능")
                    .foregroundColor(Color.gray)
                
                NavigationLink(destination: SignUpView()) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.yellow)
                            .frame(width: 150, height: 30)
                        Text("상품 등록")
                    }
                }
                .padding(.top, 10.0)
                .buttonStyle(PlainButtonStyle())
                NavigationLink(destination: MemberView()) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.orange)
                            .frame(width: 150, height: 30)
                        Text("상품 목록")
                            
                    }
                }
                .padding(.bottom)
                .buttonStyle(PlainButtonStyle())
                
                // MARK: 주문 기능
                
                Text("주문 기능")
                    .foregroundColor(Color.gray)
                
                NavigationLink(destination: SignUpView()) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.yellow)
                            .frame(width: 150, height: 30)
                        Text("상품 주문")
                    }
                }
                .padding(.top, 10.0)
                .buttonStyle(PlainButtonStyle())
                NavigationLink(destination: MemberView()) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.orange)
                            .frame(width: 150, height: 30)
                        Text("주문 내역")
                            
                    }
                }
                .padding(.bottom)
                .buttonStyle(PlainButtonStyle())
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
