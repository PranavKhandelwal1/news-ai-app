# News Assistant AI

An AI-powered Flutter news application that delivers personalized news, intelligent summaries, voice-assisted reading, and smart recommendations.

---

##  Features

### Authentication

* Email & Password Login
* Google Sign-In
* Forgot Password
* User Profile Management

### News Feed

* Trending News
* Category-wise News

    * Technology
    * Science
    * Business
    * Health
    * Sports
    * Entertainment
* Personalized "For You" Feed

### AI Features

* AI Generated Article Summaries
* Smart News Recommendations
* AI Voice Assistant
* Text-to-Speech News Reading
* Voice Commands

### User Features

* Bookmark Articles
* Reading History
* Search News
* Region Selection
* Multi-Language Support
* Voice Accent Selection

### Premium Features

* Ad-Free Experience
* Unlimited AI Summaries
* Personalized Recommendations
* Voice Reading
* AI Assistant Access

---

## Tech Stack

### Frontend

* Flutter
* Dart
* Riverpod
* Go Router

### Backend

* Firebase Authentication
* Cloud Firestore
* Firebase Storage
* Firebase Cloud Messaging

### AI

* Gemini API
* OpenAI API

### Local Storage

* Hive

### Networking

* Dio

### Voice

* flutter_tts
* speech_to_text

---

## Project Structure

```text
lib/

├── core/
│   ├── constants/
│   ├── routes/
│   ├── services/
│   ├── theme/
│   └── utils/
│
├── features/
│
│   ├── auth/
│   │   ├── data/
│   │   ├── providers/
│   │   └── presentation/
│
│   ├── news/
│   │   ├── data/
│   │   ├── providers/
│   │   └── presentation/
│
│   ├── bookmarks/
│   ├── history/
│   ├── assistant/
│   ├── profile/
│   └── subscription/
│
├── shared/
│   ├── widgets/
│   ├── models/
│   └── providers/
│
└── main.dart
```

---

## Firebase Setup

### Enable Authentication

Providers:

* Email/Password
* Google Sign-In

### Create Firestore Collections

#### Users

```json
{
  "uid": "",
  "name": "",
  "email": "",
  "photoUrl": "",
  "region": "India",
  "language": "English",
  "selectedTopics": [],
  "isPremium": false,
  "createdAt": ""
}
```

#### Bookmarks

```json
{
  "userId": "",
  "articleId": "",
  "title": "",
  "imageUrl": "",
  "savedAt": ""
}
```

#### History

```json
{
  "userId": "",
  "articleId": "",
  "viewedAt": ""
}
```

---

## Application Flow

```text
Splash Screen
      ↓
Login / Signup
      ↓
Select Topics
      ↓
Home Screen
      ↓
Article Details
      ↓
AI Summary
```

---

## Screens

* Splash Screen
* Login Screen
* Register Screen
* Forgot Password
* Home Screen
* Search Screen
* Article Detail Screen
* AI Summary Screen
* Bookmarks Screen
* Reading History Screen
* Assistant Screen
* Profile Screen
* Display Settings Screen
* Subscription Screen
* Contact & Support Screen

---

## Future Roadmap

### Version 2

* Daily AI News Digest
* News Sentiment Analysis
* Smart Recommendation Engine
* Offline Reading
* Podcast Style News
* AI News Chatbot
* Multi-language Summaries

### Version 3

* Flutter Web Support
* Admin Dashboard
* Publisher Panel
* Real-time News Alerts
* Community Discussions

---

## Developer

**Pranav Khandelwal**

MCA Student | Flutter Developer | AI Enthusiast

### Skills

* Flutter
* Firebase
* Android Development
* UI/UX Design
* REST APIs
* AI Integration

---

## License

This project is licensed under the MIT License.
