Hadith Widget

Overview

Hadith Widget is an iOS app that displays a random Hadith (saying of Prophet Mohammed, peace be upon him) on your iPhone’s Lock Screen and Home Screen. The goal is to spread the Sunnah of Prophet Mohammed (sallallahu alayhi wa salam) by providing daily inspiration through authentic Hadiths, accessible directly from your device’s interface.

Built with Swift and WidgetKit, the app fetches Hadiths from the Random Hadith API and updates every 5 minutes. It supports Lock Screen widgets (accessoryInline, accessoryRectangular) and Home Screen widgets (systemSmall, systemMedium, systemLarge).

This is my first Swift project, developed with assistance from Grok AI (created by xAI) to navigate coding challenges and refine the implementation.

Features





Displays a random Hadith from sources like Bukhari, Muslim, Abu Dawud, Ibn Majah, and Tirmidhi.



Supports Lock Screen widgets (iOS 16+) for quick glances.



Supports Home Screen widgets in multiple sizes, with the largest (systemLarge) showing up to 1200 characters.



Refresh button in the app to update the widget manually.



Simple, clean design with a focus on readability.

Goal

The primary goal of Hadith Widget is to spread the Sunnah of Prophet Mohammed (sallallahu alayhi wa salam) by making authentic Hadiths easily accessible to users, encouraging daily reflection and connection with Islamic teachings.

Mockup



Screenshot of the Hadith Widget on an iPhone Home Screen (systemLarge) and Lock Screen (accessoryRectangular).

Installation





Clone the repository:

git clone https://github.com/yourusername/HadithWidget.git



Open HadithWidget.xcodeproj in Xcode 14.2 or later.



Build and run on a simulator (iOS 16.0–16.2) or device (see deployment notes for iOS 18.6).



Add the widget to your Home Screen or Lock Screen:





Home Screen: Long-press > + > Daily Hadith > Choose size (Small, Medium, Large).



Lock Screen: Long-press > Customize > Lock Screen > Add Daily Hadith.

Deployment to iOS 18.6

Since Xcode 14.2 targets iOS 16.0–16.2, deploying to iOS 18.6 requires workarounds:





Recommended: Archive the app and install via Apple Configurator (free):





In Xcode, select Product > Archive.



Export the .ipa (Ad Hoc distribution).



Use Apple Configurator to install the .ipa on your iOS 18.6 device.



Alternatively, upgrade to Xcode 15+ (requires macOS Ventura 13.x) for native iOS 18 support.

Known Issues





Long Hadiths may truncate in smaller widgets (accessoryInline, accessoryRectangular). The systemLarge widget supports up to 1200 characters to minimize this.



If you encounter build errors after renaming the project, ensure file references and target memberships are correct in Xcode (see Troubleshooting).

Troubleshooting





Build Error: "Build input files cannot be found" for HandithWidgetAppApp.swift or ContentView.swift:





Verify files exist in the project folder (/Users/oussama/Documents/HadithWidgetApp/HandithWidgetApp/).



Re-add files in Xcode: Right-click the project group > Add Files > Select files > Ensure HandithWidgetApp target is checked.



Check Target Membership in File Inspector.



Clean Build Folder (Command + Shift + K) and rebuild.

Future Improvements





Add deep linking to view full Hadiths in the app.



Support Arabic Hadiths using a different API.



Offline storage for Hadiths using UserDefaults.



Support for .systemExtraLarge widget (iOS 17+, requires Xcode 15+).

Contributing

Feedback and contributions are welcome! Please open an issue or submit a pull request.

Acknowledgments





Random Hadith API for providing Hadith data.



Grok AI by xAI for coding assistance and debugging.
