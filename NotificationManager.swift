import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    @Published private(set) var authorizationStatus: UNAuthorizationStatus?

    init() {
        requestAuth()
    }

    func requestAuth() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]){ isGranted, _ in
            DispatchQueue.main.async {
                self.authorizationStatus = isGranted ? .authorized : .denied
            }
            
        }
    }

    func scheduleNotification(at date: Date) {

        let content = UNMutableNotificationContent()
        content.title = "Wakey-wakey~"
        content.body = "It's time to wake up"
        content.sound = UNNotificationSound(named: UNNotificationSoundName("BalineseGamelan"))
        
        //set notif based on date
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: date)

        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)

        let request = UNNotificationRequest(identifier: "notificationId", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled success")
            }
        }
    }
}

