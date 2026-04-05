import XCTest
@testable import SpoofTrap

@MainActor
final class BypassViewModelTests: XCTestCase {

    var viewModel: BypassViewModel!

    override func setUp() {
        super.setUp()
        // Note: In a real macOS environment, we might need to mock dependencies
        // like FileManager, NSWorkspace, etc., if BypassViewModel's init does too much.
        // For this logic test, we'll assume we can instantiate it.
        viewModel = BypassViewModel()
        viewModel.favorites = []
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testRemoveFavorite_RemovesExistingFavorite() {
        // Arrange
        let fav1 = FavoriteGame(id: "1", name: "Game 1", placeId: "101", addedAt: Date(), thumbnailURL: nil)
        let fav2 = FavoriteGame(id: "2", name: "Game 2", placeId: "102", addedAt: Date(), thumbnailURL: nil)
        viewModel.favorites = [fav1, fav2]

        // Act
        viewModel.removeFavorite(fav1)

        // Assert
        XCTAssertEqual(viewModel.favorites.count, 1)
        XCTAssertFalse(viewModel.favorites.contains { $0.id == "1" })
        XCTAssertTrue(viewModel.favorites.contains { $0.id == "2" })
    }

    func testRemoveFavorite_WithNonExistentFavorite_DoesNothing() {
        // Arrange
        let fav1 = FavoriteGame(id: "1", name: "Game 1", placeId: "101", addedAt: Date(), thumbnailURL: nil)
        let fav2 = FavoriteGame(id: "2", name: "Game 2", placeId: "102", addedAt: Date(), thumbnailURL: nil)
        let fav3 = FavoriteGame(id: "3", name: "Game 3", placeId: "103", addedAt: Date(), thumbnailURL: nil)
        viewModel.favorites = [fav1, fav2]

        // Act
        viewModel.removeFavorite(fav3)

        // Assert
        XCTAssertEqual(viewModel.favorites.count, 2)
        XCTAssertTrue(viewModel.favorites.contains { $0.id == "1" })
        XCTAssertTrue(viewModel.favorites.contains { $0.id == "2" })
    }

    func testRemoveFavorite_WhenListIsEmpty_DoesNothing() {
        // Arrange
        viewModel.favorites = []
        let fav1 = FavoriteGame(id: "1", name: "Game 1", placeId: "101", addedAt: Date(), thumbnailURL: nil)

        // Act
        viewModel.removeFavorite(fav1)

        // Assert
        XCTAssertTrue(viewModel.favorites.isEmpty)
    }
}
