import XCTest
@testable import claude_notch

final class NotchEventTests: XCTestCase {

    func testDecodeToolStart() throws {
        let json = """
        {"event":"tool_start","tool":"Bash","ts":1718700000}
        """.data(using: .utf8)!
        let event = try JSONDecoder().decode(NotchEvent.self, from: json)
        XCTAssertEqual(event.event, .toolStart)
        XCTAssertEqual(event.tool, "Bash")
        XCTAssertNil(event.message)
        XCTAssertNil(event.level)
        XCTAssertEqual(event.ts, 1718700000)
    }

    func testDecodeToolEnd() throws {
        let json = """
        {"event":"tool_end","tool":"Read","ts":1718700010}
        """.data(using: .utf8)!
        let event = try JSONDecoder().decode(NotchEvent.self, from: json)
        XCTAssertEqual(event.event, .toolEnd)
        XCTAssertEqual(event.tool, "Read")
    }

    func testDecodeStop() throws {
        let json = """
        {"event":"stop","ts":1718700020}
        """.data(using: .utf8)!
        let event = try JSONDecoder().decode(NotchEvent.self, from: json)
        XCTAssertEqual(event.event, .stop)
        XCTAssertNil(event.tool)
    }

    func testDecodeNotificationWarning() throws {
        let json = """
        {"event":"notification","message":"Waiting for confirmation","level":"warning","ts":1718700030}
        """.data(using: .utf8)!
        let event = try JSONDecoder().decode(NotchEvent.self, from: json)
        XCTAssertEqual(event.event, .notification)
        XCTAssertEqual(event.message, "Waiting for confirmation")
        XCTAssertEqual(event.level, .warning)
    }

    func testDecodeNotificationError() throws {
        let json = """
        {"event":"notification","message":"Build failed","level":"error","ts":1718700040}
        """.data(using: .utf8)!
        let event = try JSONDecoder().decode(NotchEvent.self, from: json)
        XCTAssertEqual(event.level, .error)
    }

    func testUnknownEventTypeThrows() throws {
        let json = """
        {"event":"unknown","ts":1718700050}
        """.data(using: .utf8)!
        XCTAssertThrowsError(try JSONDecoder().decode(NotchEvent.self, from: json))
    }
}
