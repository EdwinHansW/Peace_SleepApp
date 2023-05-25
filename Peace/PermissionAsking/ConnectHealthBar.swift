//
//  ConnectHealthBar.swift
//  Peace
//
//  Created by Edwin Hans Wijaya on 21/05/23.
//

import SwiftUI

struct ConnectHealthBar: View {
    @Environment(\.managedObjectContext) var context
    @Binding var name: String
    
    @State var isChangePage = false
//    @State var tempSample = sample
    
    var body: some View {
        if isChangePage {
            AlarmView(sleepAlarm: SleepAlarmSet(context: context), name: name).frame(width: 390, height: 1100)
        } else {
            VStack (alignment: .center, spacing: 10){
                Button {
                    HealthKitManager.shared.requestSleepAuthorization { isAuthorized in
                        if isAuthorized {
                            print("Authorization Success")
                            HealthKitManager.shared.readSleep { sample in
                                // sample = sample
                                DispatchQueue.main.async {
                                    isChangePage = true
                                }
                            }
                        } else {
                            print("Authorization failed")
                        }
                    }
                } label: {
                    Text("Connect to Health")
                        .padding(.vertical, 10)
                        .padding(.horizontal, 70)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("ColorBright"))
                        )
                        .cornerRadius(10)
                }
                VStack(spacing: 5) {
                    Text("Your health data will never leave this device")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                    
                    Text("Peace is not a substitute for your professional medical advice. It is recommended to consult with your physician first.")
                        .fontWeight(.ultraLight)
                        .foregroundColor(.white)
                        .font(.system(size: 12))
                        .multilineTextAlignment(.center)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .padding(.vertical, 24)
            .background {
                Rectangle()
                    .foregroundColor(Color("ColorBox"))
                    .frame(maxWidth: .infinity)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
        
    }
}

//struct ConnectHealthBar_Previews: PreviewProvider {
//    static var previews: some View {
//        ConnectHealthBar(name:name)
//            .background(Color("ColorRectangle"))
//    }
//}
