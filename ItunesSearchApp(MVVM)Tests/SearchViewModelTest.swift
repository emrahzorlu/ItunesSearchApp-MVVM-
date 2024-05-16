//
//  SearchViewModelTest.swift
//  ItunesSearchApp(MVVM)Tests
//
//  Created by Emrah Zorlu on 16.05.2024.
//

//
//  SearchViewModelTest.swift
//  ItunesSearchApp(MVVM)Tests
//
//  Created by Emrah Zorlu on 16.05.2024.
//

import XCTest
@testable import ItunesSearchApp_MVVM_

class SearchViewModelTest: XCTestCase {
    private let service = MockNetworkingApi()
    private let mockDataSource = DataSource()
    
    private func buildViewModel() -> SearchViewModel {
        return SearchViewModel(networkingService: service, dataSource: mockDataSource)
    }
    
    func testSearchFunction_Success() {
        let viewModel = buildViewModel()
        
        let serviceResponse: [SearchResult] = [.fake(
            artworkUrl100: "test.url",
            trackName: "Test Track Name"
        )]
        
        service.mockResult = .success(serviceResponse)
        
        let expectation = XCTestExpectation(description: "Search API called")
        
        viewModel.search(query: "Test Query", mediaType: "Test Media Type") {
            expectation.fulfill()
        }
        
        let timeout: TimeInterval = 1
        
        wait(for: [expectation], timeout: timeout)
        
        XCTAssertEqual(service.invocations.count, 1)
        XCTAssertEqual(service.invocations, [.searchItunesAPI(query: "Test Query", mediaType: "Test Media Type")])

        XCTAssertEqual(
            (mockDataSource.sections[0] as? SearchListSection)?.cellModels.map(\.trackName),
            serviceResponse.map(\.trackName)
        )
    }
    
    
    func testLoadMoreResults_Success() {
        let viewModel = buildViewModel()
        
        let initialResults: [SearchResult] = [.fake(
            artworkUrl100: "test1.url",
            trackName: "Test Track 1"
        )]
        
        let newResults: [SearchResult] = [.fake(
            artworkUrl100: "test2.url",
            trackName: "Test Track 2"
        )]
        
        service.mockResult = .success(initialResults)
        let searchExpectation = expectation(description: "Search API called")
        
        viewModel.search(query: "Test Query", mediaType: "Test Media Type") {
            searchExpectation.fulfill()
        }
        
        wait(for: [searchExpectation], timeout: 1)
        
        service.mockResult = .success(newResults)
        let loadMoreExpectation = expectation(description: "Load more results called")
        
        let atIndexPath = IndexPath(row: initialResults.count, section: 0)
        
        viewModel.loadMoreResults(query: "Test Query", mediaType: "Test Media Type", at: atIndexPath) {
            loadMoreExpectation.fulfill()
        }
        
        wait(for: [loadMoreExpectation], timeout: 1)
        
        XCTAssertEqual(service.invocations.count, 2)
        
        if let section = mockDataSource.sections.first as? SearchListSection {
            let trackNames = section.cellModels.map { $0.trackName }
            let expectedTrackNames = (initialResults + newResults).map { $0.trackName }
            XCTAssertEqual(trackNames, expectedTrackNames)
        } else {
            XCTFail("Section type mismatch or missing section")
        }
    }
}
