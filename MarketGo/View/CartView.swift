import SwiftUI
import Alamofire

struct CartItem: Identifiable {
    var id: UUID
    var product: GoodsOne
    var count: Int
    
    init(product: GoodsOne, count: Int) {
        self.id = UUID()
        self.product = product
        self.count = count
    }
}

class cart: ObservableObject {
    @Published var cart: Cart?
    @Published var cartItems: [CartItem] = []
    
    func fetchCart(forUserId cartId: Int) {
        let url = "http://3.34.33.15:8080/cart/\(cartId)"
        
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let cart = try decoder.decode(Cart.self, from: data)
                    DispatchQueue.main.async {
                        self.cart = cart
                        self.updateCartItems()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func updateCartItems() {
        guard let cart = self.cart else {
            self.cartItems = []
            return
        }
        
        var items: [CartItem] = []
        
        if let goodsId1 = cart.goodsId1, let unit1 = cart.unit1, goodsId1.goodsID != 0 {
            let cartItem = CartItem(product: goodsId1, count: unit1)
            items.append(cartItem)
        }
        
        if let goodsId2 = cart.goodsId2, let unit2 = cart.unit2, goodsId2.goodsID != 0 {
            let cartItem = CartItem(product: goodsId2, count: unit2)
            items.append(cartItem)
        }
        
        if let goodsId3 = cart.goodsId3, let unit3 = cart.unit3, goodsId3.goodsID != 0 {
            let cartItem = CartItem(product: goodsId3, count: unit3)
            items.append(cartItem)
        }
        
        if let goodsId4 = cart.goodsId4, let unit4 = cart.unit4, goodsId4.goodsID != 0 {
            let cartItem = CartItem(product: goodsId4, count: unit4)
            items.append(cartItem)
        }
        
        if let goodsId5 = cart.goodsId5, let unit5 = cart.unit5, goodsId5.goodsID != 0 {
            let cartItem = CartItem(product: goodsId5, count: unit5)
            items.append(cartItem)
        }
        
        if let goodsId6 = cart.goodsId6, let unit6 = cart.unit6, goodsId6.goodsID != 0 {
            let cartItem = CartItem(product: goodsId6, count: unit6)
            items.append(cartItem)
        }

        if let goodsId7 = cart.goodsId7, let unit7 = cart.unit7, goodsId7.goodsID != 0 {
            let cartItem = CartItem(product: goodsId7, count: unit7)
            items.append(cartItem)
        }

        if let goodsId8 = cart.goodsId8, let unit8 = cart.unit8, goodsId8.goodsID != 0 {
            let cartItem = CartItem(product: goodsId8, count: unit8)
            items.append(cartItem)
        }

        if let goodsId9 = cart.goodsId9, let unit9 = cart.unit9, goodsId9.goodsID != 0 {
            let cartItem = CartItem(product: goodsId9, count: unit9)
            items.append(cartItem)
        }

        if let goodsId10 = cart.goodsId10, let unit10 = cart.unit10, goodsId10.goodsID != 0 {
            let cartItem = CartItem(product: goodsId10, count: unit10)
            items.append(cartItem)
        }
        
        self.cartItems = items
    }
}

struct CartView: View {
    @EnvironmentObject var userModel: UserModel
    @EnvironmentObject var cart: cart

   var body: some View {

       List($cart.cartItems) { $cartItem in
          NavigationLink(destination: CartItemDetail(cartItem: $cartItem)) {
             CartItemRow(cartItem:  $cartItem)}
       }
       .onAppear{
           cart.fetchCart(forUserId: userModel.currentUser?.cartID?.cartID ?? 0)
       }
}}



struct CartItemRow: View {
   @Binding var cartItem: CartItem
   var body: some View {
   HStack {
       GoodsImage(url: URL(string: cartItem.product.goodsFile?.uploadFileURL ?? ""), placeholder: Image(systemName: "photo")).frame(width: 100, height: 100).clipShape(Circle())
       
      VStack(alignment: .leading) {
          Text(cartItem.product.goodsName ?? "").fontWeight(.semibold)
          Text("\(cartItem.product.goodsPrice ?? 0) | \(cartItem.product.goodsMarket?.marketName ?? "") | \(cartItem.product.goodsStore?.storeName ?? "")")
         Button("Show details"){}.foregroundColor(.gray)
      }
      Spacer()
      Text("\(cartItem.count)")
   }
}}


struct CartItemDetail: View {
   @Binding var cartItem: CartItem
   var body: some View {
   VStack {
       Text(cartItem.product.goodsName ?? "").font(.largeTitle)
       GoodsImage(url: URL(string: cartItem.product.goodsFile?.uploadFileURL ?? ""), placeholder: Image(systemName: "photo")).frame(width: 200, height: 200).clipShape(Circle())
      Text("\(cartItem.product.goodsPrice ?? 0) | \(cartItem.product.goodsMarket?.marketName ?? "")")
       Text(cartItem.product.goodsInfo ?? "")
.multilineTextAlignment(.center).padding(.all, 20.0)
   }
}}
