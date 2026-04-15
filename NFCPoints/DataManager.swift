import Foundation

class DataManager: ObservableObject {
    @Published var teams: [Team] = []
    @Published var defaultPointsAmount: Int = 10
    @Published var gifts: [Gift] = []
    @Published var redemptions: [Redemption] = []
    
    private let teamsKey = "teams_data"
    private let defaultPointsKey = "default_points"
    private let giftsKey = "gifts_data"
    private let redemptionsKey = "redemptions_data"
    
    init() {
        loadTeams()
        loadDefaultPoints()
        loadGifts()
        loadRedemptions()
    }
    
    // MARK: - Teams Management
    
    func addTeam(name: String, color: String = "blue") {
        let newTeam = Team(name: name, color: color)
        teams.append(newTeam)
        saveTeams()
    }
    
    func deleteTeam(id: String) {
        teams.removeAll { $0.id == id }
        saveTeams()
    }
    
    func updateTeam(_ team: Team) {
        if let index = teams.firstIndex(where: { $0.id == team.id }) {
            teams[index] = team
            saveTeams()
        }
    }
    
    func getTeam(by id: String) -> Team? {
        return teams.first { $0.id == id }
    }
    
    func getTeam(by nfcTag: String) -> Team? {
        return teams.first { $0.nfcTag == nfcTag }
    }
    
    // MARK: - Points Management
    
    func addPoints(to teamId: String, amount: Int) {
        if let index = teams.firstIndex(where: { $0.id == teamId }) {
            teams[index].points += amount
            saveTeams()
        }
    }
    
    func subtractPoints(from teamId: String, amount: Int) {
        if let index = teams.firstIndex(where: { $0.id == teamId }) {
            teams[index].points = max(0, teams[index].points - amount)
            saveTeams()
        }
    }
    
    func resetPoints(for teamId: String) {
        if let index = teams.firstIndex(where: { $0.id == teamId }) {
            teams[index].points = 0
            saveTeams()
        }
    }
    
    func assignNFCTag(teamId: String, tag: String) {
        if let index = teams.firstIndex(where: { $0.id == teamId }) {
            teams[index].nfcTag = tag
            saveTeams()
        }
    }
    
    // MARK: - Default Points
    
    func setDefaultPoints(_ amount: Int) {
        defaultPointsAmount = amount
        UserDefaults.standard.set(amount, forKey: defaultPointsKey)
    }
    
    private func loadDefaultPoints() {
        defaultPointsAmount = UserDefaults.standard.integer(forKey: defaultPointsKey)
        if defaultPointsAmount == 0 {
            defaultPointsAmount = 10
        }
    }
    
    // MARK: - Gift Management
    
    func addGift(name: String, description: String, pointsCost: Int, emoji: String = "🎁", quantity: Int = 1) {
        let newGift = Gift(name: name, description: description, pointsCost: pointsCost, emoji: emoji, quantity: quantity)
        gifts.append(newGift)
        saveGifts()
    }
    
    func updateGift(_ gift: Gift) {
        if let index = gifts.firstIndex(where: { $0.id == gift.id }) {
            gifts[index] = gift
            saveGifts()
        }
    }
    
    func deleteGift(id: String) {
        gifts.removeAll { $0.id == id }
        saveGifts()
    }
    
    func getGift(by id: String) -> Gift? {
        return gifts.first { $0.id == id }
    }
    
    // MARK: - Redemption Management
    
    func redeemGift(teamId: String, giftId: String) -> Bool {
        guard let gift = getGift(by: giftId),
              let team = getTeam(by: teamId),
              team.points >= gift.pointsCost else {
            return false
        }
        
        // Deduct points from team
        subtractPoints(from: teamId, amount: gift.pointsCost)
        
        // Create redemption record
        let redemption = Redemption(teamId: teamId, giftId: giftId, giftName: gift.name, pointsSpent: gift.pointsCost)
        redemptions.append(redemption)
        
        // Reduce gift quantity
        var updatedGift = gift
        updatedGift.quantity = max(0, gift.quantity - 1)
        updateGift(updatedGift)
        
        saveRedemptions()
        return true
    }
    
    func getRedemptions(for teamId: String) -> [Redemption] {
        return redemptions.filter { $0.teamId == teamId }
    }
    
    func updateRedemptionStatus(redemptionId: String, status: Redemption.RedemptionStatus) {
        if let index = redemptions.firstIndex(where: { $0.id == redemptionId }) {
            redemptions[index].status = status
            saveRedemptions()
        }
    }
    
    // MARK: - Persistence
    
    private func saveTeams() {
        if let encoded = try? JSONEncoder().encode(teams) {
            UserDefaults.standard.set(encoded, forKey: teamsKey)
        }
    }
    
    private func loadTeams() {
        if let data = UserDefaults.standard.data(forKey: teamsKey),
           let decoded = try? JSONDecoder().decode([Team].self, from: data) {
            teams = decoded
        }
    }
    
    private func saveGifts() {
        if let encoded = try? JSONEncoder().encode(gifts) {
            UserDefaults.standard.set(encoded, forKey: giftsKey)
        }
    }
    
    private func loadGifts() {
        if let data = UserDefaults.standard.data(forKey: giftsKey),
           let decoded = try? JSONDecoder().decode([Gift].self, from: data) {
            gifts = decoded
        }
    }
    
    private func saveRedemptions() {
        if let encoded = try? JSONEncoder().encode(redemptions) {
            UserDefaults.standard.set(encoded, forKey: redemptionsKey)
        }
    }
    
    private func loadRedemptions() {
        if let data = UserDefaults.standard.data(forKey: redemptionsKey),
           let decoded = try? JSONDecoder().decode([Redemption].self, from: data) {
            redemptions = decoded
        }
    }
}
