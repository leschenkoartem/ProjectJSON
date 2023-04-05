//
//  HorizontalImagePicker.swift
//  ProjectJSON
//
//  Created by Artem Leschenko on 06.04.2023.
//

import SwiftUI

struct HorizontalImagePicker: View {
    let images: [String]
    @Binding var selectedImageIndex: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(images.indices, id: \.self) { index in
                    AsyncImage(url: URL(string: images[index])) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 80, height: 80)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(selectedImageIndex == index ? Color.blue : Color.clear, lineWidth: 2)
                    )
                    .onTapGesture {
                        selectedImageIndex = index
                    }
                }
            }
        }
    }
}

struct HorizontalImagePicker_Previews: PreviewProvider {
    @State static var select = 1
    static var previews: some View {
        HorizontalImagePicker(images: ["https://i.dummyjson.com/data/products/4/1.jpg","https://i.dummyjson.com/data/products/4/2.jpg","https://i.dummyjson.com/data/products/4/3.jpg","https://i.dummyjson.com/data/products/4/4.jpg","https://i.dummyjson.com/data/products/4/thumbnail.jpg"], selectedImageIndex: $select)
    }
}
