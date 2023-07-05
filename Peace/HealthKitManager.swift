import SwiftUI
import HealthKit
import AVFoundation
import Foundation
import UserNotifications

public class HealthKitManager: NSObject, ObservableObject {
    static let shared = HealthKitManager()
    
    let healthStore = HKHealthStore()
    let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
    var audioPlayer: AVAudioPlayer?
    var isPlaying = false
    
    
    override init() {
        super.init()
        authorizeHealthKit()
    }
    
    private func authorizeHealthKit() {
        let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        
        healthStore.requestAuthorization(toShare: nil, read: [sleepType]) { success, error in
            if let error = error {
                print("Failed to authorize sleep tracking: \(error.localizedDescription)")
            } else {
                print("Sleep tracking authorized.")
            }
        }
    }
    
    func requestSleepAuthorization(completion: @escaping (Bool) -> Void) {
        healthStore.requestAuthorization(toShare: nil, read: [sleepType]) { success, error in
            completion(success)
        }
    }
    
    func readSleep(onComplete: @escaping ([HKSample]) -> Void) {
        let calendar = Calendar(identifier: .gregorian)
        let timeZone = TimeZone(identifier: "Asia/Jakarta")!
        
        var startDateComponents = DateComponents(year: 2023, month: 5, day: 17)
        startDateComponents.hour = 0
        startDateComponents.minute = 0
        startDateComponents.second = 0
        let startDate = calendar.date(from: startDateComponents)?.addingTimeInterval(TimeInterval(timeZone.secondsFromGMT()))
        
        var endDateComponents = DateComponents(year: 2023, month: 5, day: 19)
        endDateComponents.hour = 0
        endDateComponents.minute = 0
        endDateComponents.second = 0
        let endDate = calendar.date(from: endDateComponents)?.addingTimeInterval(TimeInterval(timeZone.secondsFromGMT()))
        
        print(startDate, endDate)
        
        // Create a predicate to filter our data
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        
        // Create a sort descriptor to get the most recent data first
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        // Create the query to fetch sleep data within the specified date range
        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: 100, sortDescriptors: [sortDescriptor]) { query, samples, error in
            if let error = error {
                print("Failed to fetch sleep data: \(error.localizedDescription)")
                return
            }
            
            
            onComplete(samples ?? [])
            
            samples?.forEach({ sample in
                if let samples = samples, let latestSample = samples.first as? HKCategorySample {
                    if latestSample.value == HKCategoryValueSleepAnalysis.asleepREM.rawValue {
                        print("User in REM: \(latestSample.startDate)")
                        print("User in REM end date: \(latestSample.endDate)")
                    } else {
                        print("User not in REM: \(latestSample.value)")
                    }
                } else {
                    print("No Sleep data available")
                }
            })
        }
        healthStore.execute(query)
    }
}
    /*
     private func startSleepTracking() {
     let query = HKObserverQuery(sampleType: sleepType, predicate: nil) { query, completionHandler, error in
     if let error = error {
     print("Sleep query failed: \(error.localizedDescription)")
     completionHandler()
     return
     }
     
     self.processSleepData(completionHandler: completionHandler)
     }
     
     healthStore.execute(query)
     healthStore.enableBackgroundDelivery(for: sleepType, frequency: .immediate) { success, error in
     if success {
     print("Sleep tracking enabled.")
     } else {
     print("Failed to enable sleep tracking.")
     }
     }
     }
     */
    
    //    private func processSleepData(completionHandler: @escaping () -> Void) {
    //        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
    //        let query = HKSampleQuery(sampleType: sleepType, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { query, samples, error in
    //            guard let sleepSample = samples?.first as? HKCategorySample else {
    //                print("Failed to fetch sleep sample: \(error?.localizedDescription ?? "Unknown error")")
    //                completionHandler()
    //                return
    //            }
    //
    //            let sleepStartDate = sleepSample.startDate
    //            let currentTime = Date().timeIntervalSince(sleepStartDate)
    //
    //            if currentTime >= self.desiredStartTime && currentTime <= self.desiredEndTime {
    //                if sleepSample.value == HKCategoryValueSleepAnalysis.inBed.rawValue {
    //                    self.playMusic()
    //                } else {
    //                    self.stopMusic()
    //                }
    //            } else {
    //                self.stopMusic()
    //            }
    //
    //            completionHandler()
    //        }
    //
    //        healthStore.execute(query)
    //    }
    //
    //    private func playMusic() {
    //        guard !isPlaying else {
    //            return
    //        }
    //
    //        guard let musicURL = Bundle.main.url(forResource: "BalineseGamelan", withExtension: "mp3") else {
    //            print("Failed to locate music file.")
    //            return
    //        }
    //
    //        do {
    //            audioPlayer = try AVAudioPlayer(contentsOf: musicURL)
    //            audioPlayer?.play()
    //            isPlaying = true
    //            print("Playing music.")
    //        } catch {
    //            print("Failed to play music: \(error.localizedDescription)")
    //        }
    //    }
    //
    //    private func stopMusic() {
    //        guard isPlaying else {
    //            return
    //        }
    //
    //        audioPlayer?.stop()
    //        audioPlayer = nil
    //        isPlaying = false
    //        print("Stopping music.")
    //    }
    //
    //    func trackSleepAndPlayMusic() {
    //        startSleepTracking()
    //    }


//    func readSleep() {
//        let calendar = Calendar.current
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM/dd/yyyy, HH:mm:ss"
//        dateFormatter.timeZone = TimeZone(identifier: "Asia/Jakarta")
//
//        let specificDate1 = dateFormatter.date(from: "05/17/2023, 00:00:00")
//
//        let oneMonthAgo = calendar.date(byAdding: .month, value: -1, to: Date())
//
//        dateFormatter.timeZone = TimeZone.current
//        let formattedDate = dateFormatter.string(from: specificDate1 ?? Date())
//
//        print(formattedDate, "here")
//        //        print(specificDate1)
//
//        // first, we define the object type we want
//        let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
//
//        // we create a predicate to filter our data
//        let predicate = HKQuery.predicateForSamples(withStart: oneMonthAgo, end: Date(), options: .strictStartDate)
//
//        // I had a sortDescriptor to get the recent data first
//        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
//
//        // we create our query with a block completion to execute
//        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: 30, sortDescriptors: [sortDescriptor]) { (query, result, error) in
//            print("test query")
//            if error != nil {
//                // handle error
//                print(error)
//                return
//            }
//
//            if let result = result as? [HKCategorySample] {
//                for sample in result {
//                    print(sample.value)
//                    print(sample.startDate)
//                    print(sample.endDate)
//                }
//            }
//            // if let result = result {
//            //
//            //    // do something with those data
//            //    result
//            //        .compactMap({ $0 as? HKCategorySample })
//            //        .forEach({ sample in
//            //            guard let sleepValue = HKCategoryValueSleepAnalysis(rawValue: sample.value) else {
//            //                return
//            //            }
//            //            print(sleepValue)
//            //
//            //            let isAsleep = sleepValue == .asleepUnspecified
//            //
//            //            print("HealthKit sleep \(sample.startDate) \(sample.endDate) - source \(sample.sourceRevision.source.name) - isAsleep \(isAsleep)")
//            //        })
//            //}
//        }
//        // finally, we execute our query
//        healthStore.execute(query)
//    }
//1. Coba






