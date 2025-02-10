//
//  FetchCategoryUseCaseImplTests.swift
//  MealAppTests
//


import XCTest
import Combine
@testable import MealApp

final class FetchCategoryUseCaseImplTests: XCTestCase {
    
    private var mockRepository: MockCategoryRepository!
    private var useCase: FetchCategoryUseCaseImpl!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        mockRepository = MockCategoryRepository()
        useCase = FetchCategoryUseCaseImpl(repository: mockRepository)
        cancellables = []
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cancellables = nil
        mockRepository = nil
        useCase = nil
        super.tearDown()
    }
    
    func test_execute_withValidCategories_shouldReturnCategories() {
        // Given
        let expectedCategories = [Categories(idCategory: "1", strCategory: "Category 1"), Categories(idCategory: "2", strCategory: "Category 2")]
        mockRepository.mockCategories = expectedCategories
        
        mockRepository.mockCategories = expectedCategories
        
        let expectation = expectation(description: "Fetching categories should complete")
        
        // When
        let publisher = useCase.execute()
        
        // Then
        publisher.sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                XCTFail("Expected success, but got error: \(error)")
            case .finished:
                expectation.fulfill()
            }
        }, receiveValue: { categories in
            XCTAssertEqual(categories.count, 2, "Expected 2 categories, but found \(categories.count).")
            XCTAssertEqual(categories.first?.strCategory, "Category 1", "Expected the first category to be 'Category 1', but got \(categories.first?.strCategory ?? "nil").")
            XCTAssertEqual(categories.last?.strCategory, "Category 2", "Expected the last category to be 'Category 2', but got \(categories.last?.strCategory ?? "nil").")
            
        }).store(in: &cancellables)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_execute_withError_shouldReturnError() {
           // Given
           mockRepository.mockError = .invalidResponse

           // When
           let expectation = XCTestExpectation(description: "Fetch categories with error")
           useCase.execute()
               .sink(receiveCompletion: { completion in
                   // Then
                   if case let .failure(error) = completion {
                       XCTAssertEqual(error, .invalidResponse, "Expected error to be .invalidResponse, but got \(error).")
                       expectation.fulfill()
                   }
               }, receiveValue: { _ in
                   XCTFail("Expected failure, but got success.")
               })
               .store(in: &cancellables)

           wait(for: [expectation], timeout: 1.0)
       }
}
