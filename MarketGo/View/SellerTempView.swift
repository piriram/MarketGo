
import SwiftUI
struct SellerTempView: View {
    @EnvironmentObject var userViewModel: UserModel
    @EnvironmentObject var marketModel: MarketModel
    @State var move1 = false
    @State var move2 = false
    @State var move3 = false
    @State var move4 = false
    @State var move5 = false
    
    var body: some View {
        NavigationView {
            VStack {
                Button {
                    move1 = true
                } label: {
                    Text("정보수정창")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .sheet(isPresented: $move1) {
                    if let storeElement = userViewModel.currentUser?.storeID {
                        EditStoreView(obse: ObservableStoreElement(storeElement: storeElement))
                    } else {
                        // Provide a view for when storeElement is nil
                        Text("No store data available")
                    }
                }
                
                Button {
                    move2 = true
                } label: {
                    Text("상품 등록 창")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .sheet(isPresented: $move2) {
                    PostGoodsView()
                }
                
                Button {
                    move3 = true
                } label: {
                    Text("상품 리스트 창")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .sheet(isPresented: $move3) {
                    GoodsListSellerView()
                }
                NavigationLink(destination: QRCodeView()) {
                    Text("QR 생성")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                //                Button {
                //                    move4 = true
                //                } label: {
                //                    Text("qr 생성")
                //                        .frame(maxWidth: .infinity)
                //                        .padding()
                //                        .background(Color.accentColor)
                //                        .foregroundColor(.white)
                //                        .cornerRadius(8)
                //                }
                //                .sheet(isPresented: $move4) {
                //                    QRCodeView()
                //                }
                NavigationLink(destination: QRCodeReaderView()) {
                    Text("QR 인식")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                //                Button {
                //                    move5 = true
                //                } label: {
                //                    Text("qr 인식")
                //                        .frame(maxWidth: .infinity)
                //                        .padding()
                //                        .background(Color.accentColor)
                //                        .foregroundColor(.white)
                //                        .cornerRadius(8)
                //                }
                //                .fullScreenCover(isPresented: $move5) {
                //                    QRCodeReaderView()
                //                }
                
            }
        }
    }
}
