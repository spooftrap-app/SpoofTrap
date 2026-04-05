import XCTest
@testable import SpoofTrap

final class ModsManagerTests: XCTestCase {

    @MainActor
    func testCategoryForValidId() {
        let manager = ModsManager()

        let category = manager.category(for: "death_sound")

        XCTAssertNotNil(category, "Category should not be nil for valid ID")
        XCTAssertEqual(category?.id, "death_sound", "Category ID should match the requested ID")
        XCTAssertEqual(category?.name, "Death Sound", "Category name should be 'Death Sound'")
    }

    @MainActor
    func testCategoryForInvalidId() {
        let manager = ModsManager()

        let category = manager.category(for: "non_existent_id")

        XCTAssertNil(category, "Category should be nil for an invalid ID")
    }

    @MainActor
    func testCategoryForEmptyId() {
        let manager = ModsManager()

        let category = manager.category(for: "")

        XCTAssertNil(category, "Category should be nil for an empty ID")
    }
}
