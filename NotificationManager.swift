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

    func scheduleNotificationWakeUp(at date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Rise and shine!"
        content.body = "It's time to wake up and have a wonderful day!"
        content.sound = UNNotificationSound(named: UNNotificationSoundName("BalineseGamelan"))
        content.categoryIdentifier = "wakeupCategory"

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

    func scheduleNotificationGoToBed(at date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Your bed misses you!"
        content.body = "It's time to sleep and have an amazing dream!"
        content.sound = UNNotificationSound(named: UNNotificationSoundName("BalineseGamelan"))
        content.categoryIdentifier = "sleepCategory"

        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: date)

        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)

        let request = UNNotificationRequest(identifier: "notificationId2", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled success")
            }
        }
    }

    func registerNotificationCategories() {
        let wakeUpCategory = UNNotificationCategory(
            identifier: "wakeupCategory",
            actions: [],
            intentIdentifiers: [],
            hiddenPreviewsBodyPlaceholder: "",
            options: .customDismissAction
        )

        let sleepCategory = UNNotificationCategory(
            identifier: "sleepCategory",
            actions: [],
            intentIdentifiers: [],
            hiddenPreviewsBodyPlaceholder: "",
            options: .customDismissAction
        )

        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.setNotificationCategories([wakeUpCategory, sleepCategory])
    }
}
