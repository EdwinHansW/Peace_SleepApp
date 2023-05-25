import SwiftUI
import HealthKit
import AVKit

struct PermissionAskingView: View {
    let healthStore = HKHealthStore()
    let audioPlay = AVPlayer()
    
    @Binding var name : String
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color("ColorRectangle"))
            VStack {
                Image("LogoPeace")
                    .padding(.top, 80)
                
                AskingHeader(name: $name)
                
                Image("AppleHealth")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                    .frame(width: 300)
                    .offset(y: 10)
                
                ConnectHealthBar(name:$name)
                }
            }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
}


//struct PermissionAskingView_Previews: PreviewProvider {
//    static var previews: some View {
//        PermissionAskingView(name: "Ed")
//    }
//}
