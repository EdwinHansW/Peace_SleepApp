import Foundation
import CoreData
import SwiftUI

class ViewModelAlarm : ObservableObject{
    let container: NSPersistentContainer
    @Published var savedEntities: [SleepAlarmSet] = []
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "SleepingAlarm")

        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores{(description, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error) ")
            }
        }
    }
    
    
    func registerProfile(bedTime: Date, startWakeUpTime: Date, endWakeUpTime: Date, context: NSManagedObjectContext){
        let newData = SleepAlarmSet(context: context)
        newData.sleepGoal = 1
        newData.bedTime = bedTime
        newData.startWakeUpTime = startWakeUpTime
        newData.endWakeUpTime = endWakeUpTime
        saveData(context: context)
    }
    
    func saveData(context: NSManagedObjectContext){
        do{
            try context.save()
        }catch let error{
            print("Error fetching. \(error)")
        }
    }
}

extension ViewModelAlarm {
    static var preview: ViewModelAlarm = {
        let viewModelAlarm = ViewModelAlarm(inMemory: true)

        let alarm = SleepAlarmSet(context: viewModelAlarm.container.viewContext)

        let startWakeUpTime = Date()
        let endWakeUpTime = Date()
        let calendar = Calendar.current

        calendar.date(byAdding: .hour, value: 3, to: startWakeUpTime)!
        calendar.date(byAdding: .hour, value: 5, to: endWakeUpTime)!

        alarm.id = UUID()
        alarm.sleepGoal = 8
        alarm.bedTime = .now
        alarm.startWakeUpTime = startWakeUpTime
        alarm.endWakeUpTime = endWakeUpTime

        do {
            try viewModelAlarm.container.viewContext.save()
        } catch {
            print("Failed to save test sleep alarm: \(error)")
        }

        return viewModelAlarm
    }()
    
    static var example: SleepAlarmSet {
        let context = ViewModelAlarm.preview.container.viewContext
        
        let fetchRequest: NSFetchRequest<SleepAlarmSet> = SleepAlarmSet.fetchRequest()
        fetchRequest.fetchLimit = 1
        
        let results = try? context.fetch(fetchRequest)
        
        return (results?.first!)!
    }
}
