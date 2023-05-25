import SwiftUI
import HealthKit
import AVKit

@main
struct PeaceApp: App {
    @StateObject private var viewModelAlarm = ViewModelAlarm()
    let healthStore = HKHealthStore()
    let audioPlay = AVPlayer()
    
    init() {
        let notificationManager = NotificationManager()
        notificationManager.requestAuth()
    }
    
    var body: some Scene {
        WindowGroup {
            AskName(sleepAlarm: ViewModelAlarm.example)
                .environment(\.managedObjectContext, viewModelAlarm.container.viewContext)
        }
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
