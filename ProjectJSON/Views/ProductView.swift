//
//  PostView.swift
//  ProjectJSON
//
//  Created by Artem Leschenko on 05.04.2023.
//

import SwiftUI

struct ProductView: View {
    var product: Product
    @State var select = 0
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ScrollView {
            Text(product.title)
                .multilineTextAlignment(.center)
                .font(.title)
                .bold()
                .opacity(0.75)
            
            ZStack{
                AsyncImage(url: URL(string: product.images[select])) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 470, maxHeight: 470)
                        .background(Color(.systemGray3).opacity(0.7))
                        .cornerRadius(12)
                } placeholder: {
                    ProgressView()
                }
                VStack{
                    HStack{
                        Text("\(select+1) / \(product.images.count)")
                            .padding(.vertical, 3)
                            .padding(.horizontal)
                            .background(Color(.systemGray5).opacity(0.7))
                            .cornerRadius(12)
                            .padding()
                        Spacer()
                    }
                    Spacer()
                }
            }.padding(.vertical)
            
            HorizontalImagePicker(images: product.images, selectedImageIndex: $select).padding(.bottom, 20)
            
            Text(product.description).padding(10)
                .padding(.vertical, 30)
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray6))
            
            VStack {
                Text("Ціна: ")
                + Text("\(String(format: "%.2f", Double(product.price)))$ ").strikethrough()
                + Text("  \(String(format: "%.2f", Double(product.price) - product.discountPercentage))$").bold()
            }.padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
            .padding(.top, 60)
            
            VStack(alignment: .leading) {
                Text("Cередній рейтинг:  \(String(format: "%.1f", product.rating)) \(Image(systemName: "star"))")
                Text("Кількість на складі: \(product.stock)")
                
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .padding()
            
            Spacer().frame(height: 60)
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(product: Product(id: 12, title: "OPPOF19", description: "OPPO F19 is officially announced on April 2021.", price: 280, discountPercentage: 17.91, rating: 4.5, stock: 123, brand: "Samsung", category: "smartphones", thumbnail: "https://i.dummyjson.com/data/products/4/thumbnail.jpg", images: [
            "https://i.dummyjson.com/data/products/4/1.jpg",
            "https://i.dummyjson.com/data/products/4/2.jpg",
            "https://i.dummyjson.com/data/products/4/3.jpg",
            "https://i.dummyjson.com/data/products/4/4.jpg",
            "https://i.dummyjson.com/data/products/4/thumbnail.jpg"
         ]))
    }
}



