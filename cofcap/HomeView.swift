//
//  HomeView.swift
//  cofcap
//
//  Created by 김유빈 on 2/28/24.
//

import SwiftUI

struct HomeView: View {
    @State private var selection = 0
   
    var body: some View {
        NavigationView{
            
            TabView(selection: $selection) {
                MainView()
                    .tabItem {
                        Image(systemName: "square.fill")
                        Text("홈")
                    }
                    .tag(0)
                ListView()
                    .tabItem {
                        Image(systemName: "book.fill")
                        Text("상품리스트")
                    }
                    .tag(1)
                MyPageView()
                    .tabItem {
                        Image(systemName: "rectangle.fill")
                        Text("마이페이지")
                    }
                    .tag(2)
                
            }
            .accentColor(Color.teal)
            .toolbar(.visible, for: .tabBar)
            .onAppear(){
                UITabBar.appearance().backgroundColor = UIColor.white
            }
            
            
        }
        
    }
}

#Preview {
    HomeView()
}

struct MainView: View {
    @State var firstNaviLinkActive = false
    @State var coffeeItems : [CoffeeElement] = []
    var body: some View {
        //NavigationView{
            VStack{
                ZStack {
                    RoundedRectangle(cornerRadius: 0)
                        .foregroundColor(.white)
                        .frame(width: 400, height: 40)
                    
                    NavigationLink(destination: BasketView()) {
                        Image(systemName: "basket.fill")
                            .foregroundColor(Color.brown)
                            .frame(width: 350, height: 40, alignment: .trailing)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    .navigationBarHidden(true)
                    .buttonStyle(PlainButtonStyle())
                    Image("logo")
                        .resizable()
                        .frame(width:80, height: 50)
                    
                }
                ScrollView{
                    
                    
                    GeometryReader { geo in
                        let w = geo.size.width
                        let h = w/4*3

                        TabView {
                            ForEach(1..<4) { index in
                                Image("banner_0\(index)")
                                    .resizable()
                                    .frame(width: w, height: h)
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                        .tabViewStyle(.page)
                        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                        .frame(width: w, height: h)
                    }
                    Text("상품")
                        .foregroundColor(Color.white)
                        .padding(.top, 300)

                    ForEach(0..<coffeeItems.count, id: \.self) { index in
                        NavigationLink(destination: ItemView()) {
                            ProductRow(coffee: coffeeItems[index])
                        }
                        .padding(.top, 10.0)
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    
                    
                }
                .onTapGesture {
                    
                }
                .background {
                    Color.brown
                }
            }
            .onAppear() {
                sendPostRequestCoffee(keyword: ""){
                    responseObject, error in guard let _ = responseObject, error == nil else {
                    print(error ?? "Unknown error")
                    return
                    }
                    
                   
                   coffeeItems = responseObject ?? []
                   
                }
            }
       // }
    }
}
