//
//  ParkingLotListView.swift
//  MarketGo
//
//  Created by ram on 2023/04/12.
//

import SwiftUI
struct ParkingLotListView: View {
    let parkingLots: [Document]
    
    var body: some View {
        List(parkingLots, id: \.id) { parkingLot in
            VStack(alignment: .leading) {
                Text(parkingLot.placeName)
                    .font(.headline)
                Text(parkingLot.roadAddressName)
                    .font(.subheadline)
                Text("\(parkingLot.distance)m")
                    .font(.subheadline)
            }
        }
    }
}
