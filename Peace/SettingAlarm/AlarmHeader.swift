//
//  AlarmHeader.swift
//  Peace
//
//  Created by Edwin Hans Wijaya on 21/05/23.
//

import SwiftUI

struct AlarmHeader: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var name : String
    public var sleepAlarm: SleepAlarmSet
    
    @Binding var startTime : Date
    @Binding var endTime : Date
    @Binding var timeBed: Date
    
    var body: some View {
        VStack{
            HStack{
                NavigationLink(destination: HomepageView(name:$name, startTime: $startTime, endTime: $endTime, timeBed: $timeBed, sleepAlarm: sleepAlarm)) {
                    Text("Done")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                }
            }
            .padding(.horizontal, 32)
            .padding()
            .padding(.top, 40)
            Image("SleepingIcon")
                .padding(.bottom, 20)
            
            Text("Estimated sleep duration")
                .fontWeight(.ultraLight)
                .foregroundColor(.white)
                .font(.system(size: 28))
                .padding(.bottom, -10)
            
        }
    }
}

//struct AlarmHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        AlarmHeader(
//
//            name: $name,
//            sleepAlarm: ViewModelAlarm.example,
//            startTime: .constant(.now),
//            endTime: .constant(.now),
//            timeBed: .constant(.now)
//        )
//        .background(Color("ColorRectangle"))
//    }
//}
