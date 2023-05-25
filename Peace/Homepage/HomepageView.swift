//
//  ContentView.swift
//  Peace
//
//  Created by Edwin Hans Wijaya on 17/05/23.
//

import SwiftUI
import HealthKit
import AVKit

struct HomepageView: View {
    @Binding var name : String
    let healthStore = HKHealthStore()
    let audioPlay = AVPlayer()
    
    @Binding var startTime: Date
    @Binding var endTime: Date
    @Binding var timeBed: Date
    
    public var sleepAlarm: SleepAlarmSet
    
    @FetchRequest(
        entity: SleepAlarmSet.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \SleepAlarmSet.id, ascending: true)
        ]
    ) var sleepAlarms: FetchedResults<SleepAlarmSet>
    
    var body: some View {
        NavigationView {
            ZStack{
                Rectangle()
                    .foregroundColor(Color("ColorRectangle"))
                
                VStack {
                    Image("LogoPeace")
                        .padding(.bottom, 40)
                    Text("Hello, **\(name.capitalized)**")
                        .foregroundColor(.white)
                        .font(.system(size: 28))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 5)
                    
                    let dur = getDuration()
                    
                        
                    if dur.hours >= 8 {
                        Text("Well done! your schedule has met optimal sleep duration")
                            .foregroundColor(Color("ColorGreen"))
                            .font(.system(size: 14))
                            .fontWeight(.light)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 16)
                        
                    }
                    else {
                        Text("Take an earlier bedtime! your schedule has not met optimal sleep duration")
                            .foregroundColor(Color("ColorYellow"))
                            .font(.system(size: 14))
                            .fontWeight(.light)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 16)
                    }
                        AlarmSchedule(sleepAlarm: sleepAlarm, name: $name, startTime: $startTime, endTime: $endTime, timeBed
                                      :$timeBed, hours: dur.hours, minutes: dur.minutes)
                        
                        
                        
                        //                    AddSchedule(name:$name, sleepAlarm: sleepAlarm)
                        
                        Spacer()
                    
                }
                .padding(.top, 80)
                .padding(.horizontal, 32)
            }
            .ignoresSafeArea()
            
        }
        .navigationBarBackButtonHidden(true)
        
        
    }
    func getDuration() -> (hours: Int, minutes: Int) {
        let sleepDuration = Calendar.current.dateComponents([.day, .hour, .minute], from: timeBed, to: startTime)
        
        let day = sleepDuration.day ?? 0
        var hours = sleepDuration.hour ?? 0
        let minutes = sleepDuration.minute ?? 0
        
        if day > 0 {
            hours += (24 * day)
        }
        
        return (hours, minutes)
    }
}

//struct HomepageView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        HomepageView(name: "Edwin", startTime: Date(), endTime: Date(), timeBed: Date(), sleepAlarm: sleep)
//    }
//}
