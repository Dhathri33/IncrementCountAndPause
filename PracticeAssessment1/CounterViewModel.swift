//
//  CounterViewModel.swift
//  PracticeAssessment1
//
//  Created by Dhathri Bathini on 9/25/25.
//
protocol CounterViewModelProtocol {
    func increment(index: [Int])
    func togglePause(index: Int)
    func getNumberOfCounters() -> Int
    func getCounter(at index: Int) -> Counter
}

class CounterViewModel : CounterViewModelProtocol {
    
    var countArray: [Counter] = Array(repeating: Counter(), count: 40)
    
    func increment(index: [Int]) {
        for index in index where !countArray[index].didPause {
            countArray[index].count += 1
        }
    }
    
    func togglePause(index: Int) {
        countArray[index].didPause.toggle()
    }
    
    func getNumberOfCounters() -> Int {
        return countArray.count
    }
    
    func getCounter(at index: Int) -> Counter {
        return countArray[index]
    }
}
