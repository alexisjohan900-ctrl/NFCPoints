# NFCPoints - NFC Team Points Manager

A beautiful iOS app for managing team points using NFC card scanning. Scan cards to automatically add or subtract points from your teams with an intuitive, modern interface.

## Features

✨ **NFC Card Scanning**
- Scan NFC cards to instantly add/subtract points
- Automatic team assignment for new cards
- Real-time feedback on scan actions

👥 **Team Management**
- Create and manage multiple teams
- Assign custom colors to teams for easy identification
- Track team statistics and rankings
- Quick point adjustments for each team

🎨 **Beautiful UI**
- Modern SwiftUI design with smooth animations
- Gradient backgrounds and card-based layouts
- Responsive design for all device sizes
- Intuitive tab-based navigation

⚙️ **Customization**
- Customize default points per scan (1-100 points)
- Flexible team color selection
- Team statistics dashboard
- Point history tracking

💾 **Data Persistence**
- All team data and points automatically saved
- Persists between app sessions
- No cloud account required

## Supported Devices

- iPhone SE 2nd generation and later
- iPad (5th generation and later)
- iOS 15.0 or later
- Requires NFC capability

## Installation & Setup

### Prerequisites
- Mac with Xcode 13.0 or later
- iOS 15.0 or later device with NFC support
- Apple Developer account (for testing on device)

### Steps to Build and Run

1. **Open the Project**
   - Launch Xcode
   - Select "Open Existing Project"
   - Navigate to and select the NFCPoints folder

2. **Configure Signing**
   - Select the project in the navigator
   - Choose the "NFCPoints" target
   - Go to "Signing & Capabilities"
   - Select your Apple Developer team
   - Update the bundle identifier if needed

3. **Enable NFC Capability**
   - Still in "Signing & Capabilities"
   - Click "+ Capability"
   - Search for "NFC Tag Reading"
   - This will add the required entitlements

4. **Connect Your Device**
   - Connect your iPhone/iPad with a USB cable
   - Select it as the build destination
   - Press Cmd+R to build and run

5. **Grant Permissions**
   - When prompted, grant NFC access permission
   - The app is now ready to use!

## Project Structure

```
NFCPoints/
├── NFCPointsApp.swift          # App entry point
├── ContentView.swift           # Main navigation (TabView)
├── Models.swift               # Data models (Team, ColorOption)
├── DataManager.swift          # Data persistence layer
├── NFCManager.swift           # NFC scanning logic
├── ScanView.swift             # Main scanning interface
├── TeamListView.swift         # Teams management view
├── PointsModalView.swift      # Points adjustment modal
├── SettingsView.swift         # Settings and statistics
├── Info.plist                 # App configuration
└── Preview Content            # SwiftUI previews
```

## How to Use

### 1. Create Teams
- Go to the "Teams" tab
- Tap "Add Team"
- Enter team name and select a color
- Tap "Create Team"

### 2. Assign NFC Cards
- Go to the "Scan" tab
- Select a team to assign the card to
- Tap "Scan Card"
- Hold your NFC card to the top of your device
- The card will be automatically assigned to the team

### 3. Scan for Points
- Select a team in the "Scan" tab
- Tap "Scan Card"
- When you scan a previously assigned card, points are automatically added
- The amount added is based on the "Default Points per Scan" setting

### 4. Manage Points Manually
- Go to "Teams" tab
- Tap on any team card
- Use the quick action buttons or tap "Edit" for more options
- Adjust points using the slider

### 5. Customize Settings
- Go to the "Settings" tab
- Adjust the "Default Points per Scan" value
- View team statistics and rankings
- Check device requirements

## Technical Details

### NFC Implementation
- Uses `CoreNFC` framework for NDEF message reading
- Supports both NDEF-formatted and raw NFC tags
- Automatic fallback for unsupported tag formats

### Data Storage
- Uses `UserDefaults` for data persistence
- Teams data encoded/decoded using `JSONEncoder/JSONDecoder`
- No external dependencies required

### Architecture
- MVVM pattern with SwiftUI
- Observable data management using `@StateObject`
- Environment objects for dependency injection
- Protocol delegation for NFC operations

## Troubleshooting

### NFC Not Working
- Ensure your device supports NFC
- Check that NFC capability is enabled in Xcode
- Verify permissions are granted when prompted
- Try restarting the app

### Teams Not Saving
- Check device storage space
- Verify app is running with proper permissions
- Check Console for any error messages

### Cards Not Being Scanned
- Ensure card is placed at the top of the device
- Keep card still until scan completes
- Try scanning with a slight circular motion
- Check if card is damaged

## Development Notes

### Adding New Features
1. Define new data models in `Models.swift`
2. Add data management methods in `DataManager.swift`
3. Create UI components in separate view files
4. Update `ContentView.swift` for navigation if needed

### Extending NFC Functionality
- Modify `NFCManager.swift` to add custom tag parsing
- Implement custom NDEF message handling
- Add support for additional tag types

### Styling Customization
- Colors defined in `ColorOption` enum
- Gradients and shadows in individual views
- Easily modifiable font sizes and spacing

## Future Enhancements

- 📊 Advanced statistics and charts
- 🌐 Cloud sync across devices
- 📱 Widgets for quick point adjustment
- 🔊 Sound effects and haptic feedback
- 📈 Point history and trends
- 🎯 Leaderboards and achievements
- 🔽 Export statistics as CSV

## Requirements

- iOS 15.0+
- Swift 5.5+
- Xcode 13.0+
- NFC-capable device

## License

This project is available for personal and commercial use.

## Support

For issues or questions:
1. Check the troubleshooting section
2. Review the Technical Details section
3. Consult Apple's CoreNFC documentation
4. Check Xcode's build output for specific errors

---

**Version**: 1.0  
**Last Updated**: April 2026  
**Status**: Production Ready
