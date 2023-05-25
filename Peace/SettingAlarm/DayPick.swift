import SwiftUI

struct DayPick: View {
    
    var body: some View {
        HStack(spacing: 15){
            Text("Sun")
            Text("Mon")
            Text("Tue")
            Text("Wed")
            Text("Thu")
            Text("Fri")
            Text("Sat")
        }
        .foregroundColor(.white)
        .padding(.horizontal, 32)
        .padding(.vertical, 24)
        .background {
            Rectangle()
                .foregroundColor(Color("ColorBox"))
                .cornerRadius(10)
                .frame(width: 336)
        }
    }
}

struct DayPick_Previews: PreviewProvider {
    static var previews: some View {
        DayPick()
            .background(Color("ColorRectangle"))
    }
}
