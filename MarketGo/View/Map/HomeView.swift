//
//  HomeView.swift
//  MarketGo
//
//  Created by ram on 2023/05/15.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userViewModel: UserModel
    var body: some View {
        Text("\(userViewModel.currentUser?.memberName ?? "")")
    }
}

