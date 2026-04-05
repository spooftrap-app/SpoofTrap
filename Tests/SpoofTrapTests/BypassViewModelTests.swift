import XCTest
@testable import SpoofTrap

@MainActor
final class BypassViewModelTests: XCTestCase {

    var viewModel: BypassViewModel!

    override func setUp() {
        super.setUp()
        // Initialize BypassViewModel for each test
        viewModel = BypassViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testApplyPreset_Stable() {
        viewModel.applyPreset(.stable)

        XCTAssertEqual(viewModel.preset, .stable)
        XCTAssertEqual(viewModel.dnsHttpsURL, "https://1.1.1.1/dns-query")
        XCTAssertEqual(viewModel.httpsChunkSize, 1)
        XCTAssertEqual(viewModel.httpsDisorder, true)
        XCTAssertEqual(viewModel.appLaunchDelay, 0)
    }

    func testApplyPreset_Balanced() {
        viewModel.applyPreset(.balanced)

        XCTAssertEqual(viewModel.preset, .balanced)
        XCTAssertEqual(viewModel.dnsHttpsURL, "https://1.1.1.1/dns-query")
        XCTAssertEqual(viewModel.httpsChunkSize, 2)
        XCTAssertEqual(viewModel.httpsDisorder, true)
        XCTAssertEqual(viewModel.appLaunchDelay, 0)
    }

    func testApplyPreset_Fast() {
        viewModel.applyPreset(.fast)

        XCTAssertEqual(viewModel.preset, .fast)
        XCTAssertEqual(viewModel.dnsHttpsURL, "https://1.1.1.1/dns-query")
        XCTAssertEqual(viewModel.httpsChunkSize, 4)
        XCTAssertEqual(viewModel.httpsDisorder, false)
        XCTAssertEqual(viewModel.appLaunchDelay, 0)
    }

    func testApplyPreset_Custom() {
        // Set to fast to ensure starting state
        viewModel.applyPreset(.fast)

        // Applying custom should not alter the current configuration values
        viewModel.applyPreset(.custom)

        XCTAssertEqual(viewModel.preset, .custom)
        XCTAssertEqual(viewModel.dnsHttpsURL, "https://1.1.1.1/dns-query")
        XCTAssertEqual(viewModel.httpsChunkSize, 4)
        XCTAssertEqual(viewModel.httpsDisorder, false)
        XCTAssertEqual(viewModel.appLaunchDelay, 0)
    }
}
