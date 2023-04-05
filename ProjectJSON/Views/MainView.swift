//
//  ContentView.swift
//  ProjectJSON
//
//  Created by Artem Leschenko on 28.03.2023.
//

import SwiftUI

struct MainView: View {
    var categories = ["smartphones","laptops","fragrances","skincare","groceries","home-decoration","furniture"]
    
    @State var categ = "all"
    @State var posts = [Product]()
    //Fullscreen
    @State var product = Product(id: 1, title: "", description: "", price: 1, discountPercentage: 1.1, rating: 1.1, stock: 1, brand: "", category: "", thumbnail: "", images: ["https://i.dummyjson.com/data/products/4/3.jpg","https://i.dummyjson.com/data/products/4/4.jpg"])
    
    @State var isFullScreen = false
    var body: some View {
        NavigationView {
            ScrollView {
                Picker("Категорія: ", selection: $categ) {
                    Text("all").tag("all")
                    ForEach(categories, id: \.self) { cat in
                        Text(cat).tag(cat)
                    }
                }
                
                ForEach(posts, id: \.id) { post in
                    if post.category == categ || categ == "all"{
                        VStack() {
                            NavigationLink {
                                ProductView(product: post)
                            } label: {
                                AsyncImage(url: URL(string: post.thumbnail)) { image in
                                    image.padding()
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                    }
                }
            }.onAppear {
                ManagerCompletions.shared.fetchData { result in
                    switch result{
                    case .success(let data):
                        posts = data.products
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
