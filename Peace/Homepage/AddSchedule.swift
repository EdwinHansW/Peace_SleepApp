import SwiftUI

struct AddSchedule: View {
    @Binding var name : String
    public var sleepAlarm: SleepAlarmSet
    
    private let isEditing: Bool = false

    var body: some View {
        NavigationLink{
            AlarmView(
                sleepAlarm: sleepAlarm,
                isEditing: isEditing,
                name:name
            )
        }label:{
            HStack{
                Image("AddIcon")
                Text("Add Schedule")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 14))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 16)
        .padding(.vertical, 12)
        .background {
            Rectangle()
                .foregroundColor(Color("ColorBright"))
                .frame(maxWidth: .infinity)
                .cornerRadius(10)
        }
    }
}

//struct AddSchedule_Previews: PreviewProvider {
//    static var previews: some View {
//        AddSchedule(sleepAlarm: ViewModelAlarm.example)
//            .background(Color("ColorRectangle"))
//    }
//}
