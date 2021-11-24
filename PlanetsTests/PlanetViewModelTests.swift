import XCTest
@testable import Planets
class PlanetsViewModelTests: XCTestCase {
    
    func testGetNumberOfRows() {
        let mockRepository = NetworkManagerMock(result: .success)
        let viewModel = PlanetViewModel(networkManager: mockRepository)
        viewModel.getPlanetsList()
        XCTAssertEqual(viewModel.getNumberOfRows(), 2)
    }
    
    func testGetPlanetSucceed() {
        let mockRepository = NetworkManagerMock(result: .success)
        let viewModel = PlanetViewModel(networkManager: mockRepository)
        viewModel.getPlanetsList()
        XCTAssertNotNil(viewModel.getPlanet(for: 0))
    }
    
    func testGetPlanetFailed() {
        let mockRepository = NetworkManagerMock(result: .failure("No Planet Found."))
        let viewModel = PlanetViewModel(networkManager: mockRepository)
        viewModel.getPlanetsList()
        XCTAssertNil(viewModel.getPlanet(for: 0))
    }
    
    func testGetPlanetsList() {
        // Create an expectation
        let expectation = expectation(description: "Planets")
        let repository = NetworkManager()
        let viewModel = PlanetViewModel(networkManager: repository)
        repository.getPlanets(completion: {(planets, error) in
            // Fullfil the expectation to let the test runner
            viewModel.planets = planets
            expectation.fulfill()
        })
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNotNil(viewModel.planets)
    }
    
    func testGetTitle() {
        let viewModel = PlanetViewModel()
        XCTAssertEqual(viewModel.getTitle(), "Planets")
    }
}
