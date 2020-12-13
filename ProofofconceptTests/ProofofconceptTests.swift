//
//  ProofofconceptTests.swift
//  ProofofconceptTests
//
//  Created by Yuvraj Sorav on 13/12/20.
//

import XCTest
@testable import Proofofconcept

class ProofofconceptTests: XCTestCase {
    
    var sut: URLSession!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = URLSession(configuration: .default)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func testValidCallToProofOfConceptAPIStatusCode200() {
        if let url = URL(string: UrlConstant.kFacts) {
            let promise = expectation(description: "Status code: 200")
            var statusCode: Int?
            var responseError: Error?
            let dataTask = sut.dataTask(with: url) { (data, response, error) in
                 statusCode = (response as? HTTPURLResponse)?.statusCode
                responseError = error
                promise.fulfill()
            }
            dataTask.resume()
            wait(for: [promise], timeout: 5)
            // then
            XCTAssertNil(responseError)
            XCTAssertEqual(statusCode, 200)
        }
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testViewModelDashboard() {
        let dashboardRowModel = DashboardRowModel(title: "Beavers", description: "Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony", imageHref: "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg")
        let dashboardModel = DashboardModel(title: "About Canada", rowsArr: [dashboardRowModel])
        
        let dashboardViewModel = DashboardViewModel(dashboardModel)
        XCTAssertEqual("Beavers", dashboardViewModel.rowsArr?.first?.title)
        XCTAssertEqual("About Canada", dashboardViewModel.titleStr)
    }
    
    func testViewModelDashboardEmptyTitleCase() {
        let dashboardRowModel = DashboardRowModel(title: "", description: "Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony", imageHref: "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg")
        let dashboardModel = DashboardModel(title: "About Canada", rowsArr: [dashboardRowModel])
        
        let dashboardViewModel = DashboardViewModel(dashboardModel)
        XCTAssertNotEqual("Beavers", dashboardViewModel.rowsArr?.first?.title)
    }
    
}
