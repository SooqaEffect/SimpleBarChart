//
//  SecondViewControllerPresenter.swift
//  Example
//
//  Created by Вячеслав Яшунин on 03.07.2020.
//  Copyright © 2020 Вячеслав Яшунин. All rights reserved.
//

import Foundation
import HealthKit

protocol SecondViewPresenterProtocol {
    var days: [BarValueData]! { get }
    var view: SecondViewProtocol! { get set }
    
    init(with view: SecondViewProtocol)
    
    func getDataFromLastWeak()
    func getDaysInWeek() -> [Date]
}


class SecondViewPresenter: SecondViewPresenterProtocol {
    unowned var view: SecondViewProtocol!
    let healthKit = HKHealthStore()
    private(set) var days: [BarValueData]!
    
    let semaphore = DispatchSemaphore(value: 1)
    
    required init(with view: SecondViewProtocol) {
        self.view = view
    }
    
    func getDataFromLastWeak() {
        getHKPermissions(onSuccess: { [unowned self] in
            self.getDatesWithsSteps()
            }, onError: { [unowned self] in
                self.view.onError(errorString: "Невозможно получить данные из Активность")
        })
        
    }
    
    
    private func getDatesWithsSteps() {
        let dates = self.getDaysInWeek()
        var arr = [BarValueData]()
        let group = DispatchGroup()
        let queue = DispatchQueue.global(qos: .userInitiated)
        queue.async(group: group) {
            for date in dates {
                group.enter()
                self.semaphore.wait()
                self.getTotalSteps(with: date) { (steps) in
                    arr.append(BarValueData(title: date.dayOfWeek()!, color: #colorLiteral(red: 0.3272460699, green: 0.6936482191, blue: 0.3788549304, alpha: 1), titleColor: .black, value: Int(steps)))
                    print(steps)
                    self.semaphore.signal()
                    group.leave()
                }
            }
            
        }
        
        group.notify(queue: .main) {
            self.days = arr
            self.view.onSuccess(data: arr.reversed())
        }
    }
    
    
    func getTotalSteps(with startDate: Date, completion: @escaping (Double) -> Void) {
        guard let stepsQuantityType = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            return
        }
        let calendar = Calendar.current
        var components = DateComponents()
        components.day = 1
        components.second = -1
        
        let startOfDay = calendar.startOfDay(for: startDate)
        let endDate = calendar.date(byAdding: components, to: startOfDay)!
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: endDate, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, _ in
            guard let result = result, let sum = result.sumQuantity() else {
                completion(0.0)
                return
            }
            completion(sum.doubleValue(for: HKUnit.count()))
        }
        healthKit.execute(query)
    }
    
    func getDaysInWeek() -> [Date] {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT:0)!
        var date = calendar.startOfDay(for: Date())
        var dateArray = [Date]()
        for _ in 1...7 {
            dateArray.append(date)
            date = calendar.date(byAdding: .day, value: -1, to: date)!
        }
        
        return dateArray
    }
    
    
    private func getHKPermissions(onSuccess: @escaping() ->(), onError: @escaping()->()) {
        guard HKHealthStore.isHealthDataAvailable() else {
            return }
        let stepsCount = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        self.healthKit.requestAuthorization(toShare: [], read: [stepsCount]) { (success, error) in
            if success {
                onSuccess()
            }
            else {
                if error != nil {
                    print(error ?? "")
                }
                onError()
            }
        }
        
    }
    
}


extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dateStr = dateFormatter.string(from: self).capitalized
        switch dateStr {
        case "Sunday": return "Вс"
        case "Monday": return "Пн"
        case "Tuesday": return "Вт"
        case "Wednesday": return "Ср"
        case "Thursday": return "Чт"
        case "Friday": return "Пт"
        case "Saturday": return "Сб"
        default: fatalError()
        }
    }
}
