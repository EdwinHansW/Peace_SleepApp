import SwiftUI
import HealthKit
import AVKit

struct AskName: View {
    let healthStore = HKHealthStore()
    let audioPlay = AVPlayer()
    @State var name : String = ""
    public var sleepAlarm: SleepAlarmSet
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                Rectangle()
                    .foregroundColor(Color("ColorRectangle"))
                VStack{
                    Image("LogoPeace")
                        .padding(.top, 80)
                    ZStack{
                        VStack (alignment: .leading){
                            Text("**What should we call you?**")
                                .foregroundColor(.white)
                                .padding(.top, 40)
                                .font(.system(size: 18))
                            HStack{
                                TextField(text: $name) {
                                    Text("e.g John Doe").foregroundColor(Color("ColorBright"))
                                        .font(.system(size: 14))
                                }
                                .padding()
                                .overlay(RoundedRectangle(cornerRadius: 10, style: .continuous).strokeBorder(Color("ColorBright"), style: StrokeStyle(lineWidth: 2)))
                            }
                            .padding(.bottom, 20)
                            
                        }
                        .foregroundColor(.white)
                    }
                    .padding(.horizontal, 32)
                    
                    HStack{
                        NavigationLink{
                            PermissionAskingView(name:$name)
//                            HomepageView(name:name)
                           // AlarmView(sleepAlarm: sleepAlarm, name:name)
                        }label:{
                            Text("Continue")
                                .padding(.vertical, 10)
                                .padding(.horizontal, 70)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color("ColorBright"))
                                        .shadow(radius: 3)
                                )
                                .cornerRadius(10)
                                .padding(.bottom, 20)
                        }
                    }
                    .padding(.horizontal, 80)
                    
                    Spacer()
                    Image("BeniSleep")
                        .resizable()
                        .frame(width: 10, height: 10)
                }
            }
            .ignoresSafeArea()
        }
    }
}
