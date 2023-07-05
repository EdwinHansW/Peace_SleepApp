import SwiftUI

struct AlarmView: View {
    let calendar = Calendar.current
    public var sleepAlarm: SleepAlarmSet
    public var isEditing: Bool = false
    
    @State var startTime: Date = Date()
    @State var endTime: Date = Date()
    @State var timeBed: Date = Date()
    @State var name : String
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("ColorRectangle"))
                .ignoresSafeArea()
            VStack {
                AlarmHeader(
                    name: $name,
                    sleepAlarm: ViewModelAlarm.example,
                    startTime: $startTime,
                    endTime: $endTime,
                    timeBed: $timeBed
                )
                
                let dur = getDuration()
                
                Text("\(dur.hours) H \(dur.minutes) M")
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .font(.system(size: 54))
                    .padding(.bottom, 5)
                
                
                if dur.hours < 8 {
                    Text("You have not met optimal sleep time")
                        .foregroundColor(Color("ColorYellow"))
                        .font(.system(size: 14))
                        .padding(.bottom, -5)
                    
                    Text("Try to have an earlier bedtime")
                        .foregroundColor(Color("ColorYellow"))
                        .font(.system(size: 14))
                        .padding(.bottom, 5)
                    
                } else {
                    Text("You have met optimal sleep time")
                        .foregroundColor(Color("ColorGreen"))
                        .font(.system(size: 14))
                        .padding(.bottom, -5)
                    
                    Text("Have a wonderful rest")
                        .foregroundColor(Color("ColorGreen"))
                        .font(.system(size: 14))
                        .padding(.bottom, 5)
                }
                
//                DayPick()
                
                AlarmCard(
                    startTime: $startTime,
                    endTime: $endTime,
                    timeBed: $timeBed,
                    sleepAlarm: sleepAlarm,
                    isEditing: isEditing
                )
                Image("BeniSleep")
                    .resizable()
                    .frame(width: 10, height: 10)
                Spacer()
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func getDuration() -> (hours: Int, minutes: Int) {
        let sleepDuration = calendar.dateComponents([.day, .hour, .minute], from: timeBed, to: startTime)
        
        let day = sleepDuration.day ?? 0
        var hours = sleepDuration.hour ?? 0
        let minutes = sleepDuration.minute ?? 0
        
        if day > 0 {
            hours += (24 * day)
        }
        
        return (hours, minutes)
    }
    
//    func createAlarm() {
//        notificationManager.scheduleNotification(trigger: <#T##TimeInterval#>)
//    }
    
//    func changeToMinutes() -> (hours: Int, minutes: Int){
//        let sleepDuration = calendar.dateComponents([.day, .hour, .minute], from: timeBed, to: startTime)
//        
//        let minutesChange = sleepDuration.minute ?? 0
//        
//        return (minutes)
//    }
}

//struct AlarmView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlarmView(
//            name: "Bob",
//            sleepAlarm: ViewModelAlarm.example,
//            isEditing: false
//        )
//    }
//}
