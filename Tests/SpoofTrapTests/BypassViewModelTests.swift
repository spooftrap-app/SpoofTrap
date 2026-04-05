import XCTest
@testable import SpoofTrap

@MainActor
final class BypassViewModelTests: XCTestCase {

    var sut: BypassViewModel!

    override func setUp() async throws {
        // Set up the system under test before each test
        sut = BypassViewModel()
    }

    override func tearDown() async throws {
        // Clean up
        sut = nil
    }

    func testAddFavorite_AddsGameToFavoritesArray() async {
        // Arrange
        let gameName = "Test Game"
        let gamePlaceId = "123456"
        let initialCount = sut.favorites.count

        // Act
        sut.addFavorite(name: gameName, placeId: gamePlaceId)

        // Assert
        XCTAssertEqual(sut.favorites.count, initialCount + 1, "The favorites array should increase in size by 1.")

        guard let addedFavorite = sut.favorites.last else {
            XCTFail("Expected the favorites array to have at least one element.")
            return
        }

        XCTAssertEqual(addedFavorite.name, gameName, "The added favorite should have the correct name.")
        XCTAssertEqual(addedFavorite.placeId, gamePlaceId, "The added favorite should have the correct placeId.")
        XCTAssertNotNil(addedFavorite.addedAt, "The added favorite should have an addedAt date.")
    }
}
