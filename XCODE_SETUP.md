# NFCPoints - Xcode Setup Guide

## Step-by-Step Setup Instructions

### 1. Prerequisites
Before you begin, ensure you have:
- Xcode 13.0 or later installed
- An Apple Developer account
- A Mac running macOS 12 or later
- An iPhone/iPad with iOS 15+ and NFC support

### 2. Opening the Project

1. Open Xcode
2. Select **File** → **Open**
3. Navigate to the NFCPoints folder
4. Select the **NFCPoints.xcodeproj** file (or folder)
5. Click **Open**

Xcode will now load the project and its files.

### 3. Critical Configuration Steps

#### Step 3.1: Configure Team & Bundle Identifier
1. In the Project Navigator, select **NFCPoints** (the top-level item)
2. Select the **NFCPoints** target
3. Go to **Signing & Capabilities**
4. Select your Apple Developer **Team** from the dropdown
5. Update **Bundle Identifier** if needed (default: `com.nfcpoints.app`)

#### Step 3.2: Enable NFC Capability
⚠️ *This is essential for NFC scanning to work*

1. Still in the **Signing & Capabilities** tab
2. Click the **"+ Capability"** button (top-left)
3. Search for **"NFC Tag Reading"**
4. Click it to add the capability
5. Xcode will add the NFC entitlements automatically

#### Step 3.3: Verify Code Signing
1. Go to **Build Settings**
2. Search for "Code Sign"
3. Verify **Code Sign Identity** is set correctly for your target
4. Development identity should be selected

### 4. Build Requirements

The project should build without errors if:
- ✅ iOS Deployment Target is set to **15.0** or later
- ✅ Swift Language is set to **Swift 5.5** or later
- ✅ NFC Tag Reading capability is enabled
- ✅ Team is properly configured

### 5. Running on Device

1. Connect your iPhone/iPad via USB
2. Select your device as the build destination (top of Xcode toolbar)
3. Press **Cmd + R** or click the **Run** button
4. Wait for app to build and install
5. If prompted on device, grant NFC permissions

**First Run Notes:**
- The app may need a moment to install
- You'll see a security prompt - tap **Trust** to allow app execution
- Grant NFC access when prompted

### 6. Troubleshooting Common Issues

#### "NFC capability not available"
- ✅ Ensure team is selected
- ✅ Check device is NFC-capable
- ✅ Verify iOS deployment target is 15.0+

#### "Code signing failure"
- ✅ Select valid development team
- ✅ Check Apple ID is signed in to Xcode
- ✅ Go to Xcode Preferences → Accounts → Manage Certificates

#### "App won't run on device"
- ✅ Unlock device and trust computer
- ✅ Disconnect and reconnect device
- ✅ Clean build folder (Cmd + Shift + K)
- ✅ Delete app from device and rebuild

#### "NFC Not Working"
- ✅ Verify NFC Tag Reading capability is enabled
- ✅ Check Info.plist has NFCReaderUsageDescription
- ✅ Ensure device supports NFC (iPhone XS+, iPad Pro 11"+)

### 7. File Structure Once in Xcode

```
NFCPoints/
├── NFCPoints.xcodeproj
│   └── project.pbxproj         # Project configuration
├── NFCPoints/                   # Main app folder
│   ├── NFCPointsApp.swift      # App entry point
│   ├── ContentView.swift       # Main navigation
│   ├── Models.swift            # Data structures
│   ├── DataManager.swift       # Data persistence
│   ├── NFCManager.swift        # NFC handling
│   ├── ScanView.swift          # Scanning interface
│   ├── TeamListView.swift      # Teams management
│   ├── PointsModalView.swift   # Points dialog
│   ├── SettingsView.swift      # Settings & stats
│   ├── Info.plist              # App configuration
│   └── Preview Content/        # SwiftUI previews
├── README.md                   # User guide
├── XCODE_SETUP.md             # This file
└── .gitignore                 # Git exclusions
```

### 8. Build and Run Checklist

- [ ] Xcode 13.0+ installed
- [ ] Apple Developer Team configured
- [ ] Bundle Identifier set
- [ ] NFC Tag Reading capability enabled
- [ ] iOS Deployment Target ≥ 15.0
- [ ] Device connected and trusted
- [ ] Build succeeds without errors
- [ ] App installs and runs on device

### 9. Next Steps

Once the app is running:

1. **Test Basic Functionality**
   - Create a test team
   - Try the Scan tab (it will generate fake NFC data for testing)
   - Verify points are added/subtracted

2. **Test with Real NFC Cards**
   - Get NFC-enabled cards or tags
   - Scan them through the app
   - Cards will be automatically assigned to teams

3. **Customize Settings**
   - Adjust default points in Settings tab
   - Create multiple teams with different colors
   - View team rankings

### 10. Development Tips

#### Using Preview/Simulator
- SwiftUI provides live previews for faster development
- However, NFC requires a real device
- Use the Preview window to test UI changes

#### Debugging
- View console output: **View** → **Debug Area** → **Show Console**
- Set breakpoints by clicking line numbers
- Use **Cmd + K** to open console output

#### Efficient Workflow
1. Edit code files
2. Press **Cmd + R** to rebuild and deploy to device
3. iOS app rebuilds only changed portions
4. Great for iterative development

### 11. Important Notes

⚠️ **NFC Requirements:**
- Only works on real devices (not simulator)
- Requires iOS 15.0 or later
- Device must support NFC (iPhone XS and later, newer iPads)

⚠️ **Code Signing:**
- Must have valid Apple Developer account
- Free accounts can develop but with limitations
- Paid accounts have no app installation limits

⚠️ **Permissions:**
- App requests NFC permission at first use
- User can deny permission in Settings app
- Permission required for any NFC scanning

### 12. Getting Help

If you encounter issues:
1. Read the error message carefully in Xcode
2. Check the Troubleshooting section above
3. Review Apple's CoreNFC documentation
4. Clean build folder (Cmd + Shift + K) and rebuild
5. Disconnect/reconnect your device

---

**Last Updated**: April 2026  
**Compatible With**: Xcode 13.0+, macOS 12+, iOS 15.0+
