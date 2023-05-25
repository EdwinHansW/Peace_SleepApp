import SwiftUI

struct bedTimePicker: View {
    @Environment(\.dismiss) var dismiss
    @Binding var timeBed : Date
    
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
                
                DatePicker("Start Time", selection: $timeBed)
                    .foregroundColor(.white)
                    .background(Color("ColorBright"))
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .cornerRadius(10)
                    
                    .padding(.bottom, 20)

                Button{
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
                }
            }
        }
    }
}
