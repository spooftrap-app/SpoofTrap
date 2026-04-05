import XCTest
@testable import SpoofTrap

@MainActor
final class GlobalHotkeyManagerTests: XCTestCase {

    var hotkeyManager: GlobalHotkeyManager!
    var viewModel: BypassViewModel!

    override func setUp() {
        super.setUp()
        hotkeyManager = GlobalHotkeyManager()
        viewModel = BypassViewModel()
    }

    override func tearDown() {
        hotkeyManager.teardown()
        hotkeyManager = nil
        viewModel = nil
        super.tearDown()
    }

    func testSetupAssignsViewModelAndRegistersHotkeys() {
        // Initially view model is nil (we test this indirectly by calling setup)

        // Act
        hotkeyManager.setup(viewModel: viewModel)

        // Assert
        // Since viewModel is private, we can't assert on it directly without Mirror or modifying the access level.
        // Let's use Mirror to verify if it was assigned properly
        let mirror = Mirror(reflecting: hotkeyManager!)
        let mirroredViewModel = mirror.children.first { $0.label == "viewModel" }?.value as? BypassViewModel

        XCTAssertNotNil(mirroredViewModel, "viewModel should be assigned during setup")
        XCTAssertTrue(mirroredViewModel === viewModel, "viewModel should be the exact instance passed to setup")

        // To verify registerHotkeys was called, we can check if hotkeyRefs is not empty
        let hotkeyRefs = mirror.children.first { $0.label == "hotkeyRefs" }?.value as? [Any?]
        XCTAssertNotNil(hotkeyRefs)
        XCTAssertEqual(hotkeyRefs?.count, 4, "Should register 4 hotkeys: toggleSession, serverHop, toggleOverlay, exportLog")
    }
}
