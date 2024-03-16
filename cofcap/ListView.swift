//
//  ListView.swift
//  cofcap
//
//  Created by 김유빈 on 3/3/24.
//

import SwiftUI

struct ListView: View {
    @State var itemName : String = ""
    @State var coffeeItems : [CoffeeElement] = []
    var body: some View {
        //Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        NavigationView{
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
                    Image("logo")
                        .resizable()
                        .frame(width:80, height: 50)
                }
                
                ScrollView{
                    
                    TextField("검색할 상품 이름을 입력하세요.", text: $itemName)
                        .padding(.leading, 20)
                        .frame(width: 350, height: 40)
                        .background() {
                            RoundedRectangle(cornerRadius: 15.0)
                                .frame(width: 350, height: 40)
                                .foregroundColor(Color.white)
                        }
                        .padding(.top)

                    
                    if itemName == "" {
                        ForEach(0..<coffeeItems.count, id: \.self) { index in
                            NavigationLink(destination: ItemView()) {
                                ProductRow(coffee: coffeeItems[index])
                            }
                            .padding(.top, 10.0)
                            .buttonStyle(PlainButtonStyle())
                            //ProductRow(product: productSamples[index])
                        }
                    }else{
                        ForEach(0..<coffeeItems.count, id: \.self) { index in
                            
                            NavigationLink(destination: ItemView()) {
                                
                                if coffeeItems[index].name.contains(itemName) {
                                    ProductRow(coffee: coffeeItems[index])
                                }
   
                            }
                            .padding(.top, 10.0)
                            .buttonStyle(PlainButtonStyle())

                        }
                    }
        
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background {
                    Color.brown
                }
            }

            
        }
        .onAppear() {
            sendPostRequestCoffee(keyword: ""){
                responseObject, error in guard let _ = responseObject, error == nil else {
                print(error ?? "Unknown error")
                return
                }
                coffeeItems = responseObject!
               
            }
        }
    }
}

#Preview {
    ListView()
}
