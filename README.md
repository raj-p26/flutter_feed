# FlutterFeed

FlutterFeed is a simple Flutter app designed to fetch news using the NewsAPI and display them in cards. Clicking on a card opens the corresponding article in the browser.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

To use FlutterFeed, you'll need to obtain an API key from NewsAPI. Follow these steps:

1. Go to [NewsAPI website](https://newsapi.org/).
2. Sign up for an account or log in if you already have one.
3. Once logged in, navigate to your dashboard or API keys section.
4. Generate a new API key for your FlutterFeed project.
5. Copy the generated API key.

## How to Use

To use FlutterFeed, follow these steps:

1. Clone or download the [FlutterFeed](https://github.com/raj-p26/flutter_feed.git) project from the repository.
2. Open the project in your preferred Flutter development environment.
3. Create a `.env` file at the root of your project directory.
4. Add your NewsAPI key to the `.env` file in the following format:
   ```
   NEWS_API_KEY=YOUR_API_KEY_HERE
   ```
   
5. Save the `.env` file.
6. Run the project on an emulator or physical device.

## Dependencies

FlutterFeed relies on the following libraries:

- `http`: Used for making HTTP requests to the NewsAPI.
- `url_launcher`: Used for launching URLs in the device's browser.
- `flutter_dotenv`: Used for loading environment variables from the .env file.