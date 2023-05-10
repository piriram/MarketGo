//
//  StoreListView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/05.
//

import SwiftUI

struct StoreListView: View {
    @State var stores: [Store] = []
    @State private var searchText = ""
    @StateObject var viewModel = FileDataViewModel() //이미지파일 구조체


    var body: some View {
        NavigationView {
            ScrollView {
                HStack {
                    TextField("시장 이름으로 검색", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Image(systemName: "magnifyingglass")
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)

                Divider()

                LazyVStack {
                    ForEach(stores.sorted { $0.ratings > $1.ratings }.filter {
                        searchText.isEmpty ? true : $0.name.contains(searchText)
                    }, id: \.id) { store in
                        NavigationLink(destination: EmptyView()) {
                            HStack {
                                
                                VStack {
                                    if let fileData = viewModel.fileData {

                                        //Text("Original File Name: \(fileData.originalFileName)")
                                        //Text("Upload File Name: \(fileData.uploadFileName)")
                                        
                                        Image(fileData.originalFileName)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 70, height: 70)
                                            .cornerRadius(4)
                                
                                    } else {
                                        Text("Loading...")
                                    }
                                }
                                .onAppear {
                                    viewModel.getFileData(fileId: store.file)
                                }
                                                                

                                VStack(alignment: .leading, spacing: 10) {
                                    Text(store.name)
                                        .font(.headline)
                                        .foregroundColor(.black)

                                    Text("작성된 리뷰 \(store.ratings)개 > ")
                                        .font(.subheadline)
                                        .foregroundColor(.black)
                                }
                                Spacer()
                                HStack {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                    Text(String(format: "%.1f", store.ratings))
                                        .font(.subheadline)
                                        .foregroundColor(.black)
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
            .onAppear(perform: loadData)
            
        }    }
    
    func loadData() {
        guard let url = URL(string: "http://3.34.33.15:8080/store/all") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([Store].self, from: data) {
                    DispatchQueue.main.async {
                        self.stores = decodedResponse
                    }
                    return
                }
            }
            
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}



struct StoreListView_Previews: PreviewProvider {
    static var previews: some View {
        StoreListView()
    }
}




