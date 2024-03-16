//
//  ProductRow.swift
//  cofcap
//
//  Created by 김유빈 on 2/28/24.
//

import SwiftUI

struct ProductRow: View {
    let coffee: CoffeeElement
   // let product: Product
        var body: some View {
 
            
            HStack {
                productImage
                productDescription
            }
            .frame(height:150)
            .background(Color.primary.colorInvert())
            .cornerRadius(6)
            //.shadow(color: Color.primaryShadow, radius: 1, x: 2, y: 2)
            .padding(.vertical, 8)
            
        }
}

private extension ProductRow {
    var productImage: some View {
        Image(coffee.imageName)
            .resizable()
            .scaledToFill()
            .frame(width: 140)
            .clipped()
    }
    
    var productDescription: some View {
        VStack(alignment: .leading) {
            Text(coffee.name)
                .font(.headline)
                .fontWeight(.medium)
                .padding(.bottom, 6)
            HStack{
                Text("Tasting Notes :")
                    .font(.footnote)
                Text(coffee.description.tastingNotes)
                    .font(.footnote)
                
            }
            HStack{
                Text ("Drinks Per Box :")
                    .font(.footnote)
                Text("\(coffee.description.drinksPerBox) 캡슐")
                    .font(.footnote)
            }
            HStack{
                Text ("suggested Cup Size :")
                    .font(.footnote)
                Text("\(coffee.description.suggestedCupSize)ml")
                    .font(.footnote)
            }
            HStack{
                Text ("Roast :")
                    .font(.footnote)
                Text("\(coffee.description.roast)")
                    .font(.footnote)
            }
            HStack{
                Text ("Intensity :")
                    .font(.footnote)
                Text("\(coffee.description.intensity)")
                    .font(.footnote)
            }
            
            
            Spacer()
            footerView
            
        }
        .padding([.leading, .bottom], 12)
        .padding([.top, .trailing])
    }
    
    var footerView: some View {
        HStack(spacing: 0) {
            Text("₩").font(.footnote)
                + Text("\(coffee.price)").font(.headline)
            
            Spacer()
            
            Image(systemName: "heart")
                .imageScale(.large)
          //      .foregroundColor(Color.peach)
                .frame(width: 32, height: 32)
            
            Image(systemName: "cart")
                .imageScale(.medium)
         //       .foregroundColor(Color.peach)
                .frame(width: 32, height: 32)
        }
    }
}

//#Preview {
//    ProductRow()
//}
