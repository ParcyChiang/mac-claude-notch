import Foundation

struct NotchEvent: Decodable {
    enum EventType: String, Decodable {
        case toolStart    = "tool_start"
        case toolEnd      = "tool_end"
        case stop         = "stop"
        case notification = "notification"
    }

    enum Level: String, Decodable {
        case info, warning, error
    }

    let event: EventType
    let tool: String?     // present for toolStart / toolEnd
    let message: String?  // present for notification
    let level: Level?     // present for notification
    let ts: Int64

    init(event: EventType, tool: String? = nil, message: String? = nil, level: Level? = nil, ts: Int64) {
        self.event = event
        self.tool = tool
        self.message = message
        self.level = level
        self.ts = ts
    }
}
