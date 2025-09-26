//
//  PracticeAssessment1Tests.swift
//  PracticeAssessment1Tests
//
//  Created by Dhathri Bathini on 9/25/25.
//

import XCTest
@testable import IncrementCountAndPause

final class PracticeAssessment1Tests: XCTestCase {

    var counterViewModel: CounterViewModelProtocol!
    
    override func setUpWithError() throws {
      counterViewModel = CounterViewModel()
    }

    override func tearDownWithError() throws {
       counterViewModel = nil
    }
    
    func testNumberOfCounters() {
        XCTAssertEqual(counterViewModel.getNumberOfCounters(), 40)
        XCTAssertFalse(counterViewModel.getNumberOfCounters() == 0)
    }
    
    func testIncrementCount() {
        counterViewModel.increment(index: [0])
        counterViewModel.increment(index: [0])
        XCTAssertEqual(counterViewModel.getCounter(at: 0).count, 2)
    }
    
    func testTogglePause() {
        counterViewModel.togglePause(index: 0)
        XCTAssertTrue(counterViewModel.getCounter(at: 0).didPause)
        counterViewModel.togglePause(index: 0)
        XCTAssertFalse(counterViewModel.getCounter(at: 0).didPause)
    }
    
    func testGetCounter() {
        XCTAssertNotNil(counterViewModel.getCounter(at: 0))
    }

}
