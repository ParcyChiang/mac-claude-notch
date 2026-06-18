import Foundation

enum StatusText {
    static func from(_ event: NotchEvent) -> String {
        switch event.event {
        case .toolStart:
            return "⚙ \(event.tool ?? "Running")"
        case .toolEnd:
            return "⚙ Done"
        case .stop:
            return "✓ Idle"
        case .notification:
            switch event.level {
            case .error:
                return "✕ Error"
            case .warning:
                return "⏳ Waiting"
            default:
                return "✓ Idle"
            }
        }
    }
}
