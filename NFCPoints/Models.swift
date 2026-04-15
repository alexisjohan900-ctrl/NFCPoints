import Foundation

struct Team: Identifiable, Codable {
    var id: String
    var name: String
    var points: Int
    var nfcTag: String? // NFC tag identifier
    var color: String // Color name for UI
    var createdDate: Date
    
    init(id: String = UUID().uuidString, name: String, points: Int = 0, nfcTag: String? = nil, color: String = "blue") {
        self.id = id
        self.name = name
        self.points = points
        self.nfcTag = nfcTag
        self.color = color
        self.createdDate = Date()
    }
}

struct PointsAction: Identifiable {
    var id: String = UUID().uuidString
    var teamId: String
    var amount: Int
    var timestamp: Date
    var actionType: ActionType
    
    enum ActionType: String {
        case add = "Added"
        case subtract = "Subtracted"
        case reset = "Reset"
    }
}

struct Gift: Identifiable, Codable {
    var id: String
    var name: String
    var description: String
    var pointsCost: Int
    var emoji: String
    var createdDate: Date
    var quantity: Int // Available quantity
    
    init(id: String = UUID().uuidString, name: String, description: String, pointsCost: Int, emoji: String = "🎁", quantity: Int = 1) {
        self.id = id
        self.name = name
        self.description = description
        self.pointsCost = pointsCost
        self.emoji = emoji
        self.quantity = quantity
        self.createdDate = Date()
    }
}

struct Redemption: Identifiable, Codable {
    var id: String
    var teamId: String
    var giftId: String
    var giftName: String
    var pointsSpent: Int
    var timestamp: Date
    var status: RedemptionStatus
    
    enum RedemptionStatus: String, Codable {
        case pending = "Pending"
        case claimed = "Claimed"
        case cancelled = "Cancelled"
    }
    
    init(teamId: String, giftId: String, giftName: String, pointsSpent: Int, status: RedemptionStatus = .pending) {
        self.id = UUID().uuidString
        self.teamId = teamId
        self.giftId = giftId
        self.giftName = giftName
        self.pointsSpent = pointsSpent
        self.timestamp = Date()
        self.status = status
    }
}

enum ColorOption: String, CaseIterable {
    case red = "red"
    case blue = "blue"
    case green = "green"
    case yellow = "yellow"
    case purple = "purple"
    case orange = "orange"
    case pink = "pink"
    case teal = "teal"
    
    var uiColor: Color {
        switch self {
        case .red:
            return .red
        case .blue:
            return .blue
        case .green:
            return .green
        case .yellow:
            return .yellow
        case .purple:
            return .purple
        case .orange:
            return .orange
        case .pink:
            return .pink
        case .teal:
            return .teal
        }
    }
}
