import XCTest
@testable import SpoofTrap

@MainActor
final class MockHotkeyViewModel: GlobalHotkeyActionDelegate {
    var proManager = ProManager()
    var perfOverlay = PerformanceOverlayManager()
    var logWatcher = RobloxLogWatcher()

    var toggleBypassCallCount = 0
    var serverHopCallCount = 0
    var exportLogsCallCount = 0

    func toggleBypass() {
        toggleBypassCallCount += 1
    }

    func serverHop() {
        serverHopCallCount += 1
    }

    func exportLogs() {
        exportLogsCallCount += 1
    }
}

@MainActor
final class GlobalHotkeyManagerTests: XCTestCase {
    var sut: GlobalHotkeyManager!
    var mockViewModel: MockHotkeyViewModel!

    override func setUp() {
        super.setUp()
        sut = GlobalHotkeyManager()
        mockViewModel = MockHotkeyViewModel()
        sut.viewModel = mockViewModel
    }

    override func tearDown() {
        sut = nil
        mockViewModel = nil
        super.tearDown()
    }

    func testHandleHotkey_ToggleSession_CallsToggleBypass() {
        sut.handleHotkey(id: GlobalHotkeyManager.Hotkey.toggleSession.rawValue)

        XCTAssertEqual(mockViewModel.toggleBypassCallCount, 1)
        XCTAssertEqual(mockViewModel.serverHopCallCount, 0)
        XCTAssertEqual(mockViewModel.exportLogsCallCount, 0)
    }

    func testHandleHotkey_ServerHop_CallsServerHop() {
        sut.handleHotkey(id: GlobalHotkeyManager.Hotkey.serverHop.rawValue)

        XCTAssertEqual(mockViewModel.serverHopCallCount, 1)
        XCTAssertEqual(mockViewModel.toggleBypassCallCount, 0)
        XCTAssertEqual(mockViewModel.exportLogsCallCount, 0)
    }

    func testHandleHotkey_ExportLog_CallsExportLogs() {
        sut.handleHotkey(id: GlobalHotkeyManager.Hotkey.exportLog.rawValue)

        XCTAssertEqual(mockViewModel.exportLogsCallCount, 1)
        XCTAssertEqual(mockViewModel.toggleBypassCallCount, 0)
        XCTAssertEqual(mockViewModel.serverHopCallCount, 0)
    }

    func testHandleHotkey_ToggleOverlay_WhenPro_TogglesOverlay() {
        // Setup pro features
        mockViewModel.proManager.isPro = true
        XCTAssertTrue(mockViewModel.proManager.canUsePerformanceOverlay)

        let initialVisible = mockViewModel.perfOverlay.isVisible

        sut.handleHotkey(id: GlobalHotkeyManager.Hotkey.toggleOverlay.rawValue)

        // Assert toggle was called (observable state change on perfOverlay)
        XCTAssertNotEqual(mockViewModel.perfOverlay.isVisible, initialVisible)
    }

    func testHandleHotkey_ToggleOverlay_WhenNotPro_DoesNothing() {
        // Setup free features
        mockViewModel.proManager.isPro = false
        XCTAssertFalse(mockViewModel.proManager.canUsePerformanceOverlay)

        let initialVisible = mockViewModel.perfOverlay.isVisible

        sut.handleHotkey(id: GlobalHotkeyManager.Hotkey.toggleOverlay.rawValue)

        // Assert toggle was NOT called
        XCTAssertEqual(mockViewModel.perfOverlay.isVisible, initialVisible)
    }

    func testHandleHotkey_InvalidId_DoesNothing() {
        sut.handleHotkey(id: 999)

        XCTAssertEqual(mockViewModel.toggleBypassCallCount, 0)
        XCTAssertEqual(mockViewModel.serverHopCallCount, 0)
        XCTAssertEqual(mockViewModel.exportLogsCallCount, 0)
    }

    func testHandleHotkey_NoViewModel_DoesNothing() {
        sut.viewModel = nil

        sut.handleHotkey(id: GlobalHotkeyManager.Hotkey.toggleSession.rawValue)

        // Assuming mockViewModel shouldn't be touched since it's disconnected
        XCTAssertEqual(mockViewModel.toggleBypassCallCount, 0)
    }
}
