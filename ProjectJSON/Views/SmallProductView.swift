//
//  SmallProductView.swift
//  ProjectJSON
//
//  Created by Artem Leschenko on 06.04.2023.
//

import SwiftUI

struct SmallProductView: View {
    var product: Product
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Spacer()
                AsyncImage(url: URL(string: product.thumbnail)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                Spacer()
            }
            
            HStack{
                Spacer()
                Text(product.title).bold()
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            HStack {
                Text("  \(String(format: "%.2f", Double(product.price) - product.discountPercentage))$ ").bold()
                    .foregroundColor(.red)
                +
                Text("\(String(format: "%.2f", Double(product.price)))$ ").strikethrough()
            }.padding(.leading, 7)
            
            Text("Оцінка: \(String(format: "%.1f", product.rating)) \(Image(systemName: "star.fill"))").padding(.leading)
            
        }.frame(width: 180, height: 170, alignment: .leading)
            .background(Color(.systemGray6))
            .cornerRadius(12)
    }
}

struct SmallProductView_Previews: PreviewProvider {
    static var previews: some View {
        SmallProductView(product: Product(id: 12, title: "OPPOF19", description: "OPPO F19 is officially announced on April 2021.", price: 280, discountPercentage: 17.91, rating: 4.5, stock: 123, brand: "Samsung", category: "smartphones", thumbnail: "https://i.dummyjson.com/data/products/4/thumbnail.jpg", images: [
            "https://i.dummyjson.com/data/products/4/1.jpg",
            "https://i.dummyjson.com/data/products/4/2.jpg",
            "https://i.dummyjson.com/data/products/4/3.jpg",
            "https://i.dummyjson.com/data/products/4/4.jpg",
            "https://i.dummyjson.com/data/products/4/thumbnail.jpg"
         ]))
    }
}
