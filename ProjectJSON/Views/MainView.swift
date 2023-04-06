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
    @State var mark = "Всі"
    @State var posts = [Product]()
    //Fullscreen
    @State var product = Product(id: 1, title: "", description: "", price: 1, discountPercentage: 1.1, rating: 1.1, stock: 1, brand: "", category: "", thumbnail: "", images: ["https://i.dummyjson.com/data/products/4/3.jpg","https://i.dummyjson.com/data/products/4/4.jpg"])
    
    @State var isFullScreen = false
    var body: some View {
        NavigationView {
            VStack{
                HStack{
                    Text("Категорія: ")
                    Picker("", selection: $categ) {
                        Text("all").tag("all")
                        ForEach(categories, id: \.self) { cat in
                            Text(cat).tag(cat)
                        }
                    }
                    
                    Text("Оцінка: ")
                    Picker("", selection: $mark) {
                        Text("Всі").tag("Всі")
                        Text("Вище або 4.5").tag("Вище або 4.5")
                        Text("Нижче 4.5").tag("Нижче 4.5")
                    }
                }.padding()
                    .frame(maxWidth: .infinity)
                .background(Color(.systemGray6))
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(posts, id: \.id) { post in
                            if (post.category == categ || categ == "all")
                                && (mark == "Вище або 4.5" ? post.rating >= 4.5 : true)
                                && (mark == "Нижче 4.5" ? post.rating <= 4.5 : true) {
                                    NavigationLink(destination: ProductView(product: post)) {
                                        SmallProductView(product: post)
                                    }
                            }
                        }
                    }
                    Spacer().frame(height: 60)
                }.onAppear {
//                    ManagerAsync.shared.fetchData { result in
//                        switch result{
//                        case .success(let data):
//                            posts = data.products
//                        case .failure(let error):
//                            print(error.localizedDescription)
//                        }
//                    }
                    Task {
                        posts = try await ManagerAsync.shared.fetchData().products
                    }
                }
                .ignoresSafeArea(.all)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
