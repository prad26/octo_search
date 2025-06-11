# OctoSearch - GitHub User Search Client

This README provides a comprehensive guide to understanding, setting up, and running the OctoSearch application.


## Project Overview

OctoSearch is a Flutter-based client application designed to allow users to search for GitHub users by keyword, view a list of the results, and explore user profiles along with their repositories.

## Why 'OctoSearch'?

The name 'OctoSearch' is derived from GitHub's mascot, the "Octocat". You can find more about [GitHub's mascots and brand elements](https://brand.github.com/graphic-elements/mascots).

## Features

The application implements the following features:

**1. User Search View:**
-   **Persistent Search Box:** A search input field is fixed at the top of the screen for easy access.
-   **Debounced Search:** API calls are debounced to prevent excessive requests while typing.
-   **User List Display:** Search results are displayed as a list, showing each user's profile picture and username.
-   **Infinite Scrolling:** User search results are paginated and support infinite scrolling for a seamless browsing experience.
-   **Navigation:** Tapping on a user in the list navigates to their detailed profile view.
-   **State Handling:** Clear indicators for loading, no results, and error states.

**2. User Profile & Repository View:**
-   **Detailed User Information:** Displays comprehensive information about the selected user at the top.
-   **User Repositories List:** Displays a list of the user's public repositories, filterable by all, non-forked (default), and forked.
-   **Open Repository URL:** Users can tap on a repository to open its URL in the browser.
-   **State Handling:** Clear indicators for loading, no results, and error states.

**3. API Interaction & Authentication:**
-   **GitHub API v3 Integration:** All data is fetched from the official GitHub API.
-   **Personal Access Token (PAT) Management:**
    -   Prompts users to enter a GitHub Personal Access Token when API rate limits are hit for unauthenticated requests or if authentication is required.
    -   Securely stores the PAT using `flutter_secure_storage`.
-   **Error Handling:** Robust error handling for API requests, guiding the user when issues like rate limiting or unauthorized access occur.

## Demo

### Video 
<video controls src="OctoSearch - screen recording.mp4" title="OctoSearch Demo" style="max-width: 320px;">
  Your browser does not support the video tag. You can <a href="OctoSearch - screen recording.mp4">watch the video here</a>.
</video>

### Web
Why not try it out directly? You can access the live demo of OctoSearch on GitHub Pages:
[OctoSearch Web Demo](https://prad26.github.io/octo_search/)

## API Usage

-   **GitHub API v3:** The application exclusively uses the official [GitHub REST API v3](https://docs.github.com/en/rest).
-   **Endpoints Used:**
    -   `GET /search/users`: For [searching users](https://docs.github.com/en/rest/search/search#search-users).
    -   `GET /users/{username}`: For [fetching user profile details](https://docs.github.com/en/rest/users/users#get-a-user).
    -   `GET /search/repositories`: For [searching repositories](https://docs.github.com/en/rest/search/search#search-repositories) (used to fetch user repositories, filtering out forks).
-   **Authentication:** As mentioned, Personal Access Tokens are used to overcome rate limits. 


## Prerequisites

Before you begin, ensure you have the following installed:
-   **Flutter SDK:** Make sure you have Flutter installed and configured correctly. For installation instructions, please refer to the official Flutter documentation:
    -   [Install Flutter](https://docs.flutter.dev/get-started/install)
    -   Select your operating system and follow the guide.
-   **Git:** For cloning the repository.

## Getting Started

Follow these steps to get the project up and running on your local machine.

**1. Clone the Repository:**
```bash
git clone https://github.com/prad26/octo_search
cd octo_search
```

**2. Install Flutter SDK:**
If you haven't already, install Flutter by following the guide mentioned in the Prerequisites section. Ensure the `flutter` command is available in your PATH.

**3. Get Dependencies:**
Open your terminal in the project's root directory (`octo_search`) and run the following command to fetch the project dependencies:
```bash
flutter pub get
```

**4. Set up GitHub Personal Access Token (Recommended):**
While the app can perform some searches anonymously, the GitHub API has a strict rate limit for unauthenticated requests (60 requests per hour). To avoid this and ensure full functionality, it's highly recommended to use a GitHub Personal Access Token.

-   **Create a Token:**
    1.  Go to your GitHub account settings: [Personal access tokens](https://github.com/settings/personal-access-tokens).
    2.  Click "Generate new token".
    3.  Give your token a descriptive name (e.g., "OctoSearch App").
    4.  Set an expiration period.
    5.  Under "Repository access," select "Public repositories" (this is sufficient for the app's functionality).
    6.  Click "Generate token."
    7.  **Important:** Copy the generated token immediately. You won't be able to see it again.

-   **Using the Token in the App:**
    The app will automatically prompt you to enter your token if it encounters API rate limits or requires authentication. An input dialog will appear where you can paste your token. The token is stored securely on your device.

## Running the App

**1. Development Mode (with Hot Reload & Debugging):**
Ensure an emulator is running or a device is connected. Then, run the following command from the project root:
```bash
flutter run
```

**2. Watch for Code Generation Changes:**
This project uses `build_runner` for code generation (e.g., for data models). If you make changes to files that require code generation (like models annotated with `@freezed` or `@JsonSerializable`), you need to run the build runner.

To automatically watch for changes and regenerate code, use the provided script:
-   On Windows:
    ```cmd
    .\watch_changes.bat
    ```
    This script executes `dart run build_runner watch -d`. Keep this running in a separate terminal while developing.

## Building the App

### Build Release APK
To build a release version of the Android APK, you can use the provided batch script.

-   On Windows:
    ```cmd
    .\build_apk.bat
    ```
    This script will clean the project, fetch dependencies, and build the release APKs.
    The output APKs will be located in the `build\app\outputs\flutter-apk\` directory.

### Build Web
To build a release version of the Web application, you can use the provided batch script.

-   On Windows:
    ```cmd
    .\build_web.bat
    ```
    This script will clean the project, fetch dependencies, and build the Web application.
    The output will be located in the `web-release\` directory which is served by GitHub Pages.

## Project Structure Overview

The project follows a standard Flutter feature-first project structure:

```
octo_search/
├── android/              # Android specific files
├── build/                # Build artifacts
├── ios/                  # iOS specific files
├── lib/                  # Dart source code
│   ├── core/             # Core utilities, widgets, enums, helpers
│   │   ├── enums/
│   │   ├── helpers/
│   │   └── widgets/      # Common reusable widgets (e.g., InfiniteScrollList)
│   ├── data/             # Data layer (API services, models)
│   │   ├── api/          # GitHub API service, error handling, exceptions
│   │   └── models/       # Data models (User, Repository, etc.)
│   ├── features/         # Feature-specific modules
│   │   ├── user_profile/ # User profile screen and related widgets
│   │   └── user_search/  # User search screen
│   ├── main.dart         # Main application entry point
├── web/                  # Web specific files
├── analysis_options.yaml # Dart static analysis options
├── build_apk.bat         # Batch script to build release APK
├── build_web.bat         # Batch script to build release Web app
├── pubspec.yaml          # Project dependencies and metadata
├── README.md             # This file
└── watch_changes.bat     # Batch script to run build_runner in watch mode
```
