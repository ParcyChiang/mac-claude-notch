import XCTest
@testable import claude_notch

final class StatusTextTests: XCTestCase {

    func testToolStartShowsToolName() {
        let event = NotchEvent(event: .toolStart, tool: "Bash", ts: 0)
        XCTAssertEqual(StatusText.from(event), "⚙ Bash")
    }

    func testToolStartUnknownTool() {
        let event = NotchEvent(event: .toolStart, tool: nil, ts: 0)
        XCTAssertEqual(StatusText.from(event), "⚙ Running")
    }

    func testToolEndShowsDone() {
        let event = NotchEvent(event: .toolEnd, tool: "Bash", ts: 0)
        XCTAssertEqual(StatusText.from(event), "⚙ Done")
    }

    func testStopShowsIdle() {
        let event = NotchEvent(event: .stop, ts: 0)
        XCTAssertEqual(StatusText.from(event), "✓ Idle")
    }

    func testNotificationErrorShowsError() {
        let event = NotchEvent(event: .notification, level: .error, ts: 0)
        XCTAssertEqual(StatusText.from(event), "✕ Error")
    }

    func testNotificationWarningShowsWaiting() {
        let event = NotchEvent(event: .notification, level: .warning, ts: 0)
        XCTAssertEqual(StatusText.from(event), "⏳ Waiting")
    }

    func testNotificationInfoShowsIdle() {
        let event = NotchEvent(event: .notification, level: .info, ts: 0)
        XCTAssertEqual(StatusText.from(event), "✓ Idle")
    }
}
