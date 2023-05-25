//
//  AlarmSchedule.swift
//  Peace
//
//  Created by Edwin Hans Wijaya on 21/05/23.
//

import SwiftUI

struct AlarmSchedule: View {
    public var sleepAlarm: SleepAlarmSet
    
    @Binding var name: String
    @Binding var startTime: Date
    @Binding var endTime: Date
    @Binding var timeBed: Date
    
    @State var hours: Int
    @State var minutes: Int
    //@ObservedObject var timeManager : TimeStore
    
    var body: some View {
        VStack {
            Text("Alarm Schedule")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .font(.system(size: 18))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack (alignment: .center, spacing: 10){
                HStack{
                    Text("\(hours) hours \(minutes) minutes")
                        .fontWeight(.bold)
                        .foregroundColor(Color("ColorBright"))
                    
                        .font(.system(size: 14))
                    Spacer()
                    Text("ON")
                        .foregroundColor(Color("ColorBright"))
                        .font(.system(size: 14))
                        .padding(.horizontal, 16)
                } .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack{
                    VStack (alignment: .leading){
                        HStack{
                            Image("BedIcon")
                            Text("Bedtime")
                                .foregroundColor(Color("ColorGray"))
                                .font(.system(size: 14))
                                .padding(.horizontal, -2)
                        }
                        Text("\(Date.getHour(date: timeBed))")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                    }
                    Image("LineSep")
                        .padding(.horizontal, 10)
                    VStack (alignment: .leading){
                        HStack{
                            Image("AlarmIcon")
                            Text("Wake up")
                                .foregroundColor(Color("ColorGray"))
                                .font(.system(size: 14))
                                .padding(.horizontal, -2)
                        }
                        
                        Text("\(Date.getHour(date: startTime)) - \(Date.getHour(date: endTime))")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity)
            .padding(.leading, 16)
            .padding(.vertical, 24)
            .background {
                Rectangle()
                    .foregroundColor(Color("ColorBox"))
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10, corners: [.topLeft, .topRight])
            }
            .padding(.bottom, -10)
            VStack (alignment: .center, spacing: 10){
                NavigationLink {
                    AlarmView(sleepAlarm: sleepAlarm, name: name)
                }label:{
                    HStack{
//                        Image("trashDelete")
//                            .resizable()
//                            .frame(width: 18, height: 18)
//                            .scaledToFit()
//
//                        Text("Delete Alarm")
//                            .foregroundColor(.white)
//                            .fontWeight(.bold)
//                            .font(.system(size: 14))
                        
                        Text("Edit")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: 14))
                        Image("NextIcon")
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                    .padding(.vertical, 12)
                    .background {
                        Rectangle()
                            .foregroundColor(Color("ColorBright"))
                            .frame(maxWidth: .infinity)
                            .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
                    }
                }
            }
            .padding(.bottom, 20)
        }
    }
}

//struct AlarmSchedule_Previews: PreviewProvider {
//    static var previews: some View {
//        AlarmSchedule(
//            sleepAlarm: $sleepAlarm, startTime: $startTime, endTime: $endTime, timeBed: $timeBed
//        ).background(Color("ColorRectangle"))
//    }
//}
