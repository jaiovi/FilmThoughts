# 🎬 **FilmThoughts**

![Preview](deliverable_preview.png)

FilmThoughts is a simple and elegant iOS iPhone SwiftUI app that allows users to capture their thoughts about movies they love. Whether it’s a review, quick note, or your personal reflections, you can add a movie title, attach an image, and save a note. FilmThoughts also provides a **Daily Note Widget**, which displays a random note each day directly on your home screen.

---

## 📱 **Features**

- **Movie Notes**: Add personalized notes with a movie title, image, and custom text.
- **Image Attachment**: Attach movie posters or screenshots using a direct image URL.
- **Daily Widget**: A beautiful WidgetKit-powered widget that shows a random note daily.
- **Persistence**: Notes are saved locally and persist between app launches.

---

## 🚀 **Setup and Installation**

Follow these steps to set up and run **FilmThoughts**:

1. **Requirements**:
- Xcode 14 or later
- iOS 16 or later
- Swift 5.7+

2. **Clone the Repository**:
Open your terminal and clone the project:
```bash
git clone https://github.com/yourusername/FilmThoughts.git
cd FilmThoughts
```

3. **Open the Project**:
Open the project in Xcode:
```bash
open FilmThoughts.xcodeproj
```

4. **Configure App Groups**:
To enable the app and widget to share data:
- Go to Xcode Project Settings > Signing & Capabilities.
- Enable App Groups for both the app target and widget target.
- Add a group identifier, e.g., "group.com.yourcompany.FilmThoughts"

5. Run the App:
Select the appropriate simulator or physical device. Build and run the app (⌘R).
