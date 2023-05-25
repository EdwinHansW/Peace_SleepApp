import SwiftUI

struct AlarmActivate: View {
    @State public var wkSetting = false
    var body: some View {
        HStack{
            Toggle("Alarm", isOn: $wkSetting)
        
        }
        .background {
            Rectangle()
                .foregroundColor(Color("ColorBox"))
                .cornerRadius(10)
                .frame(width: 336, height: 48)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundColor(.white)
        .padding(.horizontal, 48)
    }
}

struct AlarmActivate_Previews: PreviewProvider {
    static var previews: some View {
        AlarmActivate()
            .background(Color("ColorRectangle"))
    }
}
