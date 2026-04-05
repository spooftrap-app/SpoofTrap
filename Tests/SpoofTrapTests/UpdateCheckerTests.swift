import XCTest
@testable import SpoofTrap

final class UpdateCheckerTests: XCTestCase {

    @MainActor
    func testIsNewer() {
        let checker = UpdateChecker()

        // Equal versions
        XCTAssertFalse(checker.isNewer(remote: "1.0.0", current: "1.0.0"))
        XCTAssertFalse(checker.isNewer(remote: "1.0", current: "1.0"))
        XCTAssertFalse(checker.isNewer(remote: "2.1.3", current: "2.1.3"))

        // Remote is newer
        XCTAssertTrue(checker.isNewer(remote: "1.0.1", current: "1.0.0"))
        XCTAssertTrue(checker.isNewer(remote: "1.1.0", current: "1.0.0"))
        XCTAssertTrue(checker.isNewer(remote: "2.0.0", current: "1.0.0"))
        XCTAssertTrue(checker.isNewer(remote: "2.0", current: "1.9.9"))
        XCTAssertTrue(checker.isNewer(remote: "1.0.0.1", current: "1.0.0"))

        // Remote is older
        XCTAssertFalse(checker.isNewer(remote: "1.0.0", current: "1.0.1"))
        XCTAssertFalse(checker.isNewer(remote: "1.0.0", current: "1.1.0"))
        XCTAssertFalse(checker.isNewer(remote: "1.0.0", current: "2.0.0"))
        XCTAssertFalse(checker.isNewer(remote: "1.9.9", current: "2.0"))

        // Different segment lengths but logically equal or older/newer
        XCTAssertFalse(checker.isNewer(remote: "1.0", current: "1.0.0"))
        XCTAssertFalse(checker.isNewer(remote: "1.0.0", current: "1.0"))
        XCTAssertFalse(checker.isNewer(remote: "1.1", current: "1.1.0"))
        XCTAssertTrue(checker.isNewer(remote: "1.1.1", current: "1.1"))
        XCTAssertFalse(checker.isNewer(remote: "1.1", current: "1.1.1"))

        // Invalid or unexpected formats (should fallback gracefully via compactMap)
        // non-numeric parts are ignored
        XCTAssertFalse(checker.isNewer(remote: "1.0.a", current: "1.0.0")) // remote parsed as [1, 0] vs [1, 0, 0], 0 <= 0 -> false
        XCTAssertFalse(checker.isNewer(remote: "1.0.0", current: "1.0.a")) // current parsed as [1, 0] vs [1, 0, 0], 0 <= 0 -> false
    }
}
