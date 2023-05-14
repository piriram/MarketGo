//
//  MenuItemRow.swift
//  MarketGo
//
//  Created by 김주현 on 2023/04/09.
//

import SwiftUI


struct MenuItemRow: View {
    var goods: Good
    
    var body: some View {
        
        HStack {
            Spacer().frame(width:20)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("\(goods.goodsName ?? "")")
                    .font(.system(size: 17))
                
                HStack {
                    Text("\(goods.goodsPrice ?? 0) 원")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            Image(systemName: "heart.fill")
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .foregroundColor(.gray)
                
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
}

//struct MenuItemRow_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuItemRow()
//    }
//}
