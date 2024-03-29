//
//  MypageView.swift
//  MarketGo
//
//  Created by 김주현 on 2023/05/05.
//

import SwiftUI


struct UserMyPageView: View {
    @EnvironmentObject var userModel: UserModel
    @State var isLinkActive = false
    var body: some View {
        VStack(spacing: 20) {
            Spacer().frame(height: 20)
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width:100, height:100)
            
            Spacer().frame(height: 20)
            
            HStack {
                Text("이름")
                Spacer()
                Text("\(userModel.currentUser?.memberName ?? "")")
                
                
            }
            HStack {
                Text("관심 시장")
                Spacer()
                Text("\(userModel.currentUser?.interestMarket?.marketName ?? "")")
            }
            HStack {
                Text("장바구니")
                Spacer()
                //Text("\(userModel.currentUser?.cartID ?? 0)")
            }
            HStack {
                Text("member id")
                Spacer()
                Text("\(userModel.currentUser?.memberID ?? 0)")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
           
            HStack {
                Text("cart id")
                Spacer()
                Text("\(userModel.currentUser?.cartID?.cartID ?? 0)")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            Spacer()
            
            NavigationLink(destination: MemberProfileEditView(), isActive: $isLinkActive) {
                Text("회원정보 수정")
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10.0)
                    .onTapGesture {
//                        self.marketModel.currentMarket = selectedMarket
                        self.isLinkActive = true
                        
                    }
                
            }}
        .padding()
        .navigationBarTitle("My Page", displayMode: .inline)
    }
}
