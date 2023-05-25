import SwiftUI

struct AskingHeader: View {
    @Binding var name : String
    
    var body: some View {
        VStack {
            VStack (alignment: .leading){
                HStack {
                    Text("Nice to meet you, **\(name.capitalized)**")
                        .foregroundColor(.white)
                        .padding(.top, 20)
                        .font(.system(size: 18))
                    Spacer()
                }
                HStack{
                    Text("Peace requires access to your Health data to know your sleep schedule and waking you gently during your ")
                        .fontWeight(.thin)
                    +
                    Text("REM Sleep Phase")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
                .foregroundColor(.white)
            }
            .padding(.horizontal, 32)
        }
    }
}

//struct AskingHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        AskingHeader(name: "Ed")
//            .background(Color("ColorRectangle"))
//    }
//}
