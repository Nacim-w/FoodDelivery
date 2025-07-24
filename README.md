# 📱 Flutter Project - Dependency Overview

This project is built using Flutter and includes a rich set of dependencies sourced from [pub.dev](https://pub.dev). Below is a summary of the package setup and configuration for the project.

---

## 📦 Project SDKs

- **Dart SDK**: `>=3.7.0-0 <4.0.0`
- **Flutter SDK**: `>=3.27.0`

---

## 📁 Dependency Types

- **Direct Dependencies (Main)**: Required in production.
- **Direct Dependencies (Dev)**: Required during development and testing.
- **Transitive Dependencies**: Installed automatically via direct dependencies.

---

## ✅ Notable Direct Dependencies

| Package                     | Version   | Description                                   |
|----------------------------|-----------|-----------------------------------------------|
| flutter                    | —         | Core Flutter SDK                              |
| animated_text_kit          | 4.2.3     | Animated text effects                         |
| animations                 | 2.0.11    | Pre-built Material animations                 |
| auto_size_text             | 3.0.0     | Auto-resizing text widget                     |
| bloc_test                  | 10.0.0    | Testing utilities for BLoC                    |
| cached_network_image       | 3.4.1     | Network image caching                         |
| carousel_slider            | 5.0.0     | Image and content sliders                     |
| dots_indicator             | 4.0.1     | Page indicators                               |
| dotted_border              | 2.1.0     | Dotted border widgets                         |
| dotted_line                | 3.2.3     | Dotted horizontal or vertical lines           |
| dropdown_button2           | 2.3.9     | Enhanced dropdown menus                       |
| equatable                  | 2.0.7     | Simplified value equality                     |
| expand                     | 1.2.0     | Expansion panel builder                       |
| firebase_auth              | 5.6.2     | Firebase Authentication                       |
| firebase_core              | 3.15.1    | Firebase Core Setup                           |
| firebase_messaging         | 15.2.9    | Push notifications with FCM                   |
| flutter_advanced_switch    | 3.1.0     | Customizable switch widget                    |
| flutter_bloc               | 9.0.0     | State management using BLoC                   |
| flutter_local_notifications| 19.3.0    | Local notifications handling                  |
| flutter_rating_bar         | 4.0.1     | Rating bar widget                             |
| flutter_secure_storage     | 9.2.4     | Encrypted local storage                       |
| flutter_svg                | 2.0.17    | SVG rendering                                 |
| fluttertoast               | 8.2.12    | Toast message notifications                   |
| gap                        | 3.0.1     | Spacer widget for layout                      |
| geocoding                  | 3.0.0     | Address lookup from coordinates               |
| geolocator                 | 14.0.0    | Device location tracking                      |
| get_it                     | 8.0.3     | Dependency injection                          |
| go_router                  | 14.8.1    | Declarative routing                           |
| google_maps_flutter        | 2.12.1    | Maps integration                              |
| google_sign_in             | 6.3.0     | Google account sign-in                        |
| http                       | 1.3.0     | HTTP client for REST APIs                     |
| iconly                     | 1.0.1     | Icon pack with minimal design                 |
| image_picker               | 1.1.2     | Image selection from gallery or camera        |
| intl_phone_field           | 3.2.0     | International phone number input              |
| lottie                     | 3.3.1     | Lottie animation support                      |
| mocktail                   | 1.0.4     | Mocking library for testing                   |
| model_viewer_plus          | 1.9.3     | 3D model viewer (GLTF/GLB/WebXR)              |
| panorama_viewer            | 2.0.4     | 360° panorama viewer                          |
| pinput                     | 5.0.1     | Customizable PIN input widget                 |
| provider                   | 6.1.4     | Lightweight state management                  |
| shared_preferences         | 2.5.2     | Simple key-value persistent storage           |
| skeletonizer               | 2.0.1     | Shimmer-style skeleton loading UI             |
| stomp_dart_client          | 2.1.3     | STOMP over WebSocket client                   |
| story_view                 | 0.16.5    | Instagram-like story display                  |
| syncfusion_flutter_sliders | 29.1.40   | Advanced sliders                              |
| toggle_switch              | 2.3.0     | Customizable toggle buttons                   |
| video_player               | 2.9.5     | Video playback                                |
| web_socket_channel         | 3.0.3     | WebSocket client abstraction                  |
| youtube_player_flutter     | 9.1.1     | YouTube video player integration              |

---

## 🔄 Transitive Dependencies

This project includes many transitive dependencies such as:

- `bloc`, `rxdart`, `async`, `collection`, `crypto`
- Platform-specific extensions for Android, iOS, web, Windows, macOS
- Plugins for maps, storage, webviews, and secure contexts

These are pulled automatically and do not require manual inclusion in your `pubspec.yaml`.

