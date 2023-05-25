import SwiftUI

struct AlarmCard: View {
    @Binding public var startTime: Date
    @Binding public var endTime: Date
    @Binding public var timeBed: Date
    
    @State public var sleepDuration: Date = Date()
    
    public var sleepAlarm: SleepAlarmSet
    public var isEditing: Bool
    
    var body: some View {
        ZStack {
            VStack (alignment: .leading, spacing: 10){
                HStack{
                    Image("SleepIcon")
                    Text("Optimal sleep goal")
                        .foregroundColor(Color("ColorGray"))
                        .font(.system(size: 18))
                        .padding(.horizontal, -2)
                }
                Text("8 hours")
                    .fontWeight(.bold)
                    .foregroundColor(Color("ColorGray"))
                    .font(.system(size: 27))
                
                
                Image("LineHorizontal")
                
                HStack{
                    Image("BedIcon")
                    Text("Bedtime")
                        .foregroundColor(Color("ColorGray"))
                        .font(.system(size: 18))
                        .padding(.horizontal, -2)
                }
                NavigationLink{
                    bedTimePicker(
                        timeBed : $timeBed
                    )
                }label:{
                    Text("\(Date.getHour(date: timeBed))")
                        .fontWeight(.bold)
                        .foregroundColor(Color("ColorBright"))
                        .font(.system(size: 27))
                }
                
                Image("LineHorizontal")
                
                HStack{
                    Image("AlarmIcon")
                    Text("Wake up")
                        .foregroundColor(Color("ColorGray"))
                        .font(.system(size: 18))
                        .padding(.horizontal, -2)
                }
                NavigationLink{
                    wakeUpPicker(
                        startTime: $startTime,
                        endTime: $endTime
                    )
                }label:{
                    Text("\(Date.getHour(date: startTime)) - \(Date.getHour(date: endTime))")
                        .fontWeight(.bold)
                        .foregroundColor(Color("ColorBright"))
                        .font(.system(size: 27))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 24)
            .background {
                Rectangle()
                    .foregroundColor(Color("ColorBox"))
                    .cornerRadius(10)
                    .frame(width: 336, height: 255)
            }
        .padding(.horizontal, 32)
        }
    }
}

extension Date{
    static func getHour(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let hour = dateFormatter.string(from: date)
        
        return hour
    }
}

struct AlarmCard_Previews: PreviewProvider {
    static var previews: some View {
        AlarmCard(
            startTime: .constant(.now),
            endTime: .constant(.now),
            timeBed: .constant(.now),
            sleepDuration: Date(),
            sleepAlarm: ViewModelAlarm.example, isEditing: false
        )
            .background(Color("ColorRectangle"))
    }
}
