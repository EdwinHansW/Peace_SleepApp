//
//  AlarmPop.swift
//  Peace
//
//  Created by Edwin Hans Wijaya on 23/05/23.
//

import SwiftUI

struct AlarmPop: View {
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color("ColorRectangle"))
            VStack {
                Image("LogoPeace")
                    .padding(.top, 80)
                Text("Edwin")
                    .foregroundColor(.white)
                    .font(.system(size: 38))
                
                Spacer()
            }
        }
        .ignoresSafeArea()
    }
}

struct AlarmPop_Previews: PreviewProvider {
    static var previews: some View {
        AlarmPop()
    }
}
