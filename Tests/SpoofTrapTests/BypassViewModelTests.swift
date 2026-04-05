import XCTest
@testable import SpoofTrap

@MainActor
final class BypassViewModelTests: XCTestCase {
    var viewModel: BypassViewModel!

    override func setUp() {
        super.setUp()
        viewModel = BypassViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testToggleBypass_WhenStopped_StartsBypass() {
        // Arrange
        // We need to set paths so that `robloxInstalled` and `binaryAvailable` pass.
        // Even if they fail, startBypass() modifies state first or appends logs,
        // but `state` remains `.stopped` if it fails immediately.
        // To actually transition to `.starting` or `.running` we mock paths:
        let tempDir = FileManager.default.temporaryDirectory
        let robloxPath = tempDir.appendingPathComponent("MockRoblox.app").path
        let spoofdpiPath = tempDir.appendingPathComponent("mock_spoofdpi").path

        try? FileManager.default.createDirectory(atPath: robloxPath, withIntermediateDirectories: true)
        FileManager.default.createFile(atPath: spoofdpiPath, contents: nil)
        // Make it executable
        try? FileManager.default.setAttributes([.posixPermissions: 0o755], ofItemAtPath: spoofdpiPath)

        viewModel.setRobloxAppPath(robloxPath)
        viewModel.setCustomSpoofdpiPath(spoofdpiPath)

        XCTAssertEqual(viewModel.state, .stopped)
        XCTAssertFalse(viewModel.isRunning)

        // Act
        viewModel.toggleBypass()

        // Assert
        // After startBypass, state becomes .starting or .running (or .stopped if fail)
        // In our case it should try to run or at least transition out of stopped momentarily
        XCTAssertTrue(viewModel.isRunning)

        // Cleanup
        try? FileManager.default.removeItem(atPath: robloxPath)
        try? FileManager.default.removeItem(atPath: spoofdpiPath)
    }

    func testToggleBypass_WhenRunning_StopsBypass() {
        // Arrange
        // Force the state to be running (if possible) or call startBypass first
        let tempDir = FileManager.default.temporaryDirectory
        let robloxPath = tempDir.appendingPathComponent("MockRoblox.app").path
        let spoofdpiPath = tempDir.appendingPathComponent("mock_spoofdpi").path

        try? FileManager.default.createDirectory(atPath: robloxPath, withIntermediateDirectories: true)
        FileManager.default.createFile(atPath: spoofdpiPath, contents: nil)
        try? FileManager.default.setAttributes([.posixPermissions: 0o755], ofItemAtPath: spoofdpiPath)

        viewModel.setRobloxAppPath(robloxPath)
        viewModel.setCustomSpoofdpiPath(spoofdpiPath)

        viewModel.startBypass()
        XCTAssertTrue(viewModel.isRunning)

        // Act
        viewModel.toggleBypass()

        // Assert
        XCTAssertEqual(viewModel.state, .stopping)
        XCTAssertFalse(viewModel.isRunning)

        // Cleanup
        try? FileManager.default.removeItem(atPath: robloxPath)
        try? FileManager.default.removeItem(atPath: spoofdpiPath)
    }
}
