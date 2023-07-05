import SwiftUI

struct wakeUpPicker: View {
    @Environment(\.dismiss) var dismiss
    @Binding var startTime : Date
    @Binding var endTime : Date
    
    var notifManager = NotificationManager()
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("ColorRectangle"))
                .ignoresSafeArea()
            VStack (alignment:.leading){
                Text("Start Time")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .font(.system(size: 28))
                
                DatePicker("Start Time", selection: $startTime)
                    .foregroundColor(.white)
                    .background(Color("ColorBright"))
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .cornerRadius(10)
                
                    .padding(.bottom, 20)
                
                Text("End Time")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .font(.system(size: 28))
                
                DatePicker("End Time", selection: $endTime)
                    .foregroundColor(.white)
                    .background(Color("ColorBright"))
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .cornerRadius(10)
                    
                    .padding(.bottom, 20)

                Button{
                    let alarmTime = startTime
                    notifManager.scheduleNotificationWakeUp(at: alarmTime)

                    
                    dismiss()
                }label:{
                    Rectangle()
                        .frame(width: 336, height: 50)
                        .foregroundColor(Color("ColorBright"))
                        .cornerRadius(10)
                        .overlay{
                            Text("Save changes")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .font(.system(size: 14))
                        }
                }.onAppear {
                    notifManager.registerNotificationCategories()
                }
            }
        }
    }
}
