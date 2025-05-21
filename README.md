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

| Package                      | Version  | Description                              |
|-----------------------------|----------|------------------------------------------|
| flutter                     | 0.0.0    | Core Flutter SDK                         |
| auto_size_text              | 3.0.0    | Auto-resizing text widget                |
| cached_network_image        | 3.4.1    | Efficient image caching                  |
| carousel_slider             | 5.0.0    | Image carousels                          |
| dots_indicator              | 4.0.1    | Page indicators                          |
| dotted_border               | 2.1.0    | Dotted border widget                     |
| dropdown_button2            | 2.3.9    | Enhanced dropdown                        |
| equatable                   | 2.0.7    | Value equality utilities                 |
| expand                      | 1.2.0    | Expansion panel builder                  |
| flutter_advanced_switch     | 3.1.0    | Advanced toggle switch                   |
| flutter_bloc                | 9.1.0    | Bloc state management                    |
| flutter_lints               | 5.0.0    | Lint rules                               |
| flutter_rating              | 2.0.2    | Rating widgets                           |
| flutter_screenutil          | 5.9.3    | Responsive design utilities              |
| flutter_secure_storage      | 9.2.4    | Secure local storage                     |
| flutter_svg                 | 2.0.17   | SVG rendering                            |
| fluttertoast                | 8.2.12   | Toast messages                           |
| gap                         | 3.0.1    | Spacer widget                            |
| geocoding                   | 3.0.0    | Address lookup from coordinates          |
| geolocator                  | 14.0.0   | Geolocation                              |
| get_it                      | 8.0.3    | Dependency injection                     |
| go_router                   | 14.8.1   | Declarative routing                      |
| google_maps_flutter         | 2.12.1   | Maps integration                         |
| http                        | 1.3.0    | Networking                               |
| iconly                      | 1.0.1    | Icon package                             |
| lottie                      | 3.3.1    | Lottie animations                        |
| model_viewer_plus           | 1.9.3    | 3D model viewer                          |
| pinput                      | 5.0.1    | PIN code input                           |
| provider                    | 6.1.4    | State management                         |
| shared_preferences          | 2.5.3    | Simple key-value storage                 |
| syncfusion_flutter_sliders  | 29.1.40  | Advanced sliders                         |
| toggle_switch               | 2.3.0    | Toggle button UI                         |
| video_player                | 2.9.5    | Video playback                           |
| youtube_player_flutter      | 9.1.1    | YouTube video player widget              |

---

## 🔄 Transitive Dependencies

This project includes many transitive dependencies such as:

- `bloc`, `rxdart`, `async`, `collection`, `crypto`
- Platform-specific extensions for Android, iOS, web, Windows, macOS
- Plugins for maps, storage, webviews, and secure contexts

These are pulled automatically and do not require manual inclusion in your `pubspec.yaml`.

