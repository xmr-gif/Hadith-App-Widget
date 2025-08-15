# Hadith Widget

Hadith Widget is an iOS app that displays a random Hadith (a saying of the Prophet Mohammed, peace be upon him) on your iPhone's Lock Screen and Home Screen. Built with **Swift** and **WidgetKit**, its goal is to help users easily access authentic Hadiths and spread the **Sunnah** of the Prophet Mohammed (sallallahu alayhi wa salam).

The app fetches Hadiths from the **Random Hadith API** and refreshes every five minutes to keep the content fresh. This project was developed with assistance from **Grok AI (xAI)**, which helped navigate various coding and implementation challenges.

![Hadith Widget on an iPhone Home Screen and Lock Screen](https://github.com/xmr-gif/Hadith-App-Widget/blob/main/Mockup.png)

---

### Features

* **Daily Inspiration**: Displays a random Hadith from authentic sources like Bukhari, Muslim, Abu Dawud, and others.
* **Multiple Widget Support**:
    * **Lock Screen Widgets** (iOS 16+): `accessoryInline`, `accessoryRectangular`
    * **Home Screen Widgets**: `systemSmall`, `systemMedium`, `systemLarge` (the largest size can display Hadiths up to 1200 characters long).
* **Manual Refresh**: The in-app button allows you to manually update the widget content.
* **Clean Design**: Simple and readable design focused on content clarity.

---

### Installation

1.  **Clone the repository**:
    ```bash
    git clone [https://github.com/yourusername/HadithWidget.git](https://github.com/xmr-gif/Hadith-App-Widget)
    ```
2.  Open the `HadithWidget.xcodeproj` file in **Xcode 14.2** or a later version.
3.  Build and run the app on an iOS simulator (v16.0-16.2) or a physical device.

#### How to Add the Widget

* **Home Screen**: Long-press on the screen, tap the `+` icon, search for **"Daily Hadith,"** and choose a size (Small, Medium, or Large).
* **Lock Screen**: Long-press to customize the Lock Screen, then tap to add a widget and select **"Daily Hadith."**

---

### Deployment to iOS 18.6

Since this project was built with Xcode 14.2, which targets older iOS versions (16.0–16.2), you may need a workaround to deploy to newer versions like iOS 18.6.

* **Recommended Method**: Use **Apple Configurator** to install the app.
    1.  In Xcode, go to `Product` > `Archive`.
    2.  Export the `.ipa` file using **Ad Hoc distribution**.
    3.  Use Apple Configurator to install the `.ipa` file on your device.
* **Alternative**: Upgrade to **Xcode 15+** (requires macOS Ventura 13.x or newer) for native support of iOS 18.

---

### Known Issues & Troubleshooting

#### Known Issues

* **Text Truncation**: Long Hadiths may be cut off in smaller widgets. The `systemLarge` widget is designed to minimize this issue.

#### Troubleshooting

* **"Build input files cannot be found" Error**: If you see this error after renaming the project, check the following:
    * Verify the files (`HandithWidgetAppApp.swift`, `ContentView.swift`, etc.) still exist in the project directory.
    * In Xcode, right-click the project, select `Add Files to...`, and re-add the missing files.
    * Make sure **Target Membership** is checked for the correct target in the File Inspector.
    * Clean the build folder by pressing **Command + Shift + K** and then rebuild the project.

---

### Future Improvements

* Implement **deep linking** to view the full Hadith within the app.
* Add support for **Arabic Hadiths** using a different API.
* Use `UserDefaults` for **offline storage** of Hadiths.
* Support the `.systemExtraLarge` widget size (iOS 17+, requires Xcode 15+).

---

### Acknowledgments

* **Random Hadith API**: for providing the data.
* **Grok AI (xAI)**: for its invaluable assistance with coding and debugging.
