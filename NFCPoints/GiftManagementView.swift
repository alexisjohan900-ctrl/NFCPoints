import SwiftUI

struct GiftManagementView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var showAddGift = false
    @State private var selectedGift: Gift?
    @State private var showGiftActions = false
    
    @State private var newGiftName = ""
    @State private var newGiftDescription = ""
    @State private var newGiftPointsCost = "25"
    @State private var newGiftEmoji = "🎁"
    @State private var newGiftQuantity = "1"
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.orange.opacity(0.1),
                        Color.red.opacity(0.1)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    VStack(spacing: 8) {
                        Text("Manage Gifts")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.primary)
                        
                        Text("\(dataManager.gifts.count) gift\(dataManager.gifts.count != 1 ? "s" : "")")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20)
                    .background(Color(.systemBackground))
                    .shadow(radius: 2)
                    
                    if dataManager.gifts.isEmpty {
                        // Empty State
                        Spacer()
                        VStack(spacing: 16) {
                            Image(systemName: "gift.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.gray)
                            
                            Text("No Gifts Yet")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Text("Create gifts that teams can redeem with points")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(32)
                        Spacer()
                    } else {
                        // Gifts List
                        ScrollView {
                            VStack(spacing: 12) {
                                ForEach(dataManager.gifts) { gift in
                                    GiftCardView(gift: gift)
                                        .onTapGesture {
                                            selectedGift = gift
                                            showGiftActions = true
                                        }
                                }
                            }
                            .padding(16)
                        }
                    }
                    
                    // Add Gift Button
                    Button(action: { showAddGift = true }) {
                        HStack(spacing: 12) {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 18))
                            
                            Text("Add Gift")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(14)
                        .foregroundColor(.white)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.orange, Color.red]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(10)
                        .padding(16)
                    }
                }
            }
            .sheet(isPresented: $showAddGift) {
                NavigationStack {
                    VStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Gift Emoji")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            HStack(spacing: 12) {
                                Text(newGiftEmoji)
                                    .font(.system(size: 36))
                                
                                VStack(alignment: .leading) {
                                    TextField("Enter emoji", text: $newGiftEmoji)
                                        .font(.headline)
                                    Text("Copy/paste emoji here")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(12)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        }
                        .padding(16)
                        
                        TextField("Gift Name", text: $newGiftName)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal, 16)
                        
                        TextField("Description", text: $newGiftDescription)
                            .textFieldStyle(.roundedBorder)
                            .lineLimit(3)
                            .padding(.horizontal, 16)
                        
                        HStack(spacing: 12) {
                            VStack(alignment: .leading) {
                                Text("Points Cost")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                TextField("25", text: $newGiftPointsCost)
                                    .textFieldStyle(.roundedBorder)
                                    .keyboardType(.numberPad)
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Quantity")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                TextField("1", text: $newGiftQuantity)
                                    .textFieldStyle(.roundedBorder)
                                    .keyboardType(.numberPad)
                            }
                        }
                        .padding(.horizontal, 16)
                        
                        Spacer()
                        
                        Button(action: addGift) {
                            Text("Create Gift")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding(12)
                                .foregroundColor(.white)
                                .background(Color.orange)
                                .cornerRadius(10)
                        }
                        .padding(16)
                        .disabled(newGiftName.isEmpty || newGiftPointsCost.isEmpty)
                    }
                    .navigationTitle("New Gift")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Cancel") {
                                showAddGift = false
                                resetForm()
                            }
                        }
                    }
                }
            }
            .confirmationDialog(
                "Gift Options",
                isPresented: $showGiftActions,
                presenting: selectedGift
            ) { gift in
                Button("Edit Quantity") { }
                
                Button("Delete Gift", role: .destructive) {
                    dataManager.deleteGift(id: gift.id)
                    selectedGift = nil
                }
                
                Button("Cancel", role: .cancel) { }
            } message: { gift in
                Text("What would you like to do with \(gift.name)?")
            }
        }
    }
    
    private func addGift() {
        let pointsCost = Int(newGiftPointsCost) ?? 25
        let quantity = Int(newGiftQuantity) ?? 1
        dataManager.addGift(name: newGiftName, description: newGiftDescription, pointsCost: pointsCost, emoji: newGiftEmoji, quantity: quantity)
        showAddGift = false
        resetForm()
    }
    
    private func resetForm() {
        newGiftName = ""
        newGiftDescription = ""
        newGiftPointsCost = "25"
        newGiftEmoji = "🎁"
        newGiftQuantity = "1"
    }
}

struct GiftCardView: View {
    let gift: Gift
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                Text(gift.emoji)
                    .font(.system(size: 36))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(gift.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(gift.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.caption)
                            .foregroundColor(.orange)
                        
                        Text("\(gift.pointsCost)")
                            .font(.headline)
                            .foregroundColor(.orange)
                    }
                    
                    Text("Left: \(gift.quantity)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Divider()
            
            HStack(spacing: 8) {
                Label("Available for redemption", systemImage: "checkmark.circle.fill")
                    .font(.caption2)
                    .foregroundColor(.green)
                
                Spacer()
                
                Text("Qty: \(gift.quantity)")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(6)
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(4)
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

#Preview {
    GiftManagementView()
        .environmentObject(DataManager())
}
