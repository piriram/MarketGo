//
//  MarketTableWrapper.swift
//  MarketGo
//
//  Created by ram on 2023/05/11.
//
import SwiftUI
import Alamofire
struct MarketSearchTableWrapper: View {
    var data: [Document]
    @Binding var selected: Document?
    
    @State private var isLoading = false // indicator 추가
    @State private var isLinkActive = false //버튼위해서사용
    @State var selectedMarket: MarketOne?
    @EnvironmentObject var marketModel: MarketModel
    @EnvironmentObject var userModel: UserModel
    @ObservedObject var vm:MarketSearchViewModel
    
    var body: some View {
        List(selection: $vm.selectedID) {
            ForEach(data) { market in
                HStack {
                    Text("\(market.placeName)   \(market.distance)m")
                        .tag(market.id)  // 각 항목에 ID 태그를 추가합니다.
                        .onTapGesture {
                            selected = market
                            vm.selectedID = market.id
                        }
                    Spacer()
                    Button(action: {
                        userModel.NMap = market
                        vm.fetchMarketData(marketName: market.placeName)
                        selected = market
                        isLinkActive = true
                        
                        
                        
                    }) {
                        Image(systemName: "arrowtriangle.forward")
                            .foregroundColor(.black)
                    }
                    .background(
                        NavigationLink(destination: MarketInfoView(selectedMarket: $vm.selectedMarket), isActive: $isLinkActive) {
                            EmptyView()
                        }
                        .hidden()
                    )
                }
            }
        }


    }
}
