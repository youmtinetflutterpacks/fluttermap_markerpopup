# longpress_popup
<div align="center">
    <img src="https://raw.githubusercontent.com/ymrabti/fluttermap_markerpopup/refs/heads/main/assets/logo.png" alt="longpress_popup logo" width="120" height="120" style="border-radius: 50%;" />
</div>


# This is a Fork of [flutter_map_marker_popup](https://github.com/rorystephenson/flutter_map_marker_popup) by [@rorystephenson](https://github.com/rorystephenson).

[![pub package](https://img.shields.io/pub/v/longpress_popup.svg)](https://pub.dev/packages/longpress_popup)
[![pub likes](https://img.shields.io/pub/likes/longpress_popup.svg)](https://pub.dev/packages/longpress_popup/score)
[![pub points](https://img.shields.io/pub/points/longpress_popup.svg?color=blue)](https://pub.dev/packages/longpress_popup/score)
[![platform](https://img.shields.io/badge/platform-flutter-blue)](https://flutter.dev)

[![GitHub stars](https://img.shields.io/github/stars/ymrabti/fluttermap_markerpopup.svg?style=flat&logo=github&colorB=&label=Stars)](https://github.com/ymrabti/fluttermap_markerpopup/stargazers)
[![GitHub issues](https://img.shields.io/github/issues/ymrabti/fluttermap_markerpopup.svg?style=flat&logo=github&colorB=&label=Issues)](https://github.com/ymrabti/fluttermap_markerpopup/issues)
[![GitHub license](https://img.shields.io/github/license/ymrabti/fluttermap_markerpopup.svg?style=flat&logo=github&colorB=&label=License)](https://github.com/ymrabti/fluttermap_markerpopup/blob/main/LICENSE)
[![GitHub last commit](https://img.shields.io/github/last-commit/ymrabti/fluttermap_markerpopup.svg?style=flat&logo=github&colorB=&label=Last%20Commit)](https://github.com/ymrabti/fluttermap_markerpopup/commits/main)


[![Build status](https://github.com/ymrabti/fluttermap_markerpopup/workflows/publish_pub.dev/badge.svg?style=flat&logo=github&colorB=&label=Build)](https://github.com/ymrabti/fluttermap_markerpopup)


Flutter Map Custom Marker Popups is an extension for the popular Flutter Map package. It allows you to create custom markers that, when long-pressed, open customizable popups containing additional data associated with the marker. This package enhances the interactivity and visual appeal of maps in your Flutter applications.

## Features

- **Customizable Markers**: Create custom markers with images, icons, or other widgets.
- **Interactive Popups**: Popups open on long-press and can contain rich data.
- **Data Integration**: Associate custom data with each marker and display it in the popup.
- **Styling Options**: Customize marker and popup appearance to match your app's design.
- **Easy Integration**: Seamlessly integrate with Flutter Map for powerful map displays.

## Installation

To use this package, add `longpress_popup` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  longpress_popup: ^1.0.0
```

If you have any suggestions/problems please don't hesitate to open an issue.

## Getting Started

For a minimal code example have a look at [SimpleMapWithPopups](https://github.com/ymrabti/fluttermap_markerpopup/blob/master/example/lib/simple_map_with_popups.dart).
## Usage

Import the package:
```dart
import 'package:flutter_map_custom_marker_popups/flutter_map_custom_marker_popups.dart';

```
Create a `FlutterMap` widget and add a `MarkerLayer`:


```dart
FlutterMap(
  options: MapOptions(
    // set your map options here
  ),
  layers: [
    TileLayerOptions(
      // set your tile layer options here
    ),
    MarkerLayer(
      markers: [
        CustomMarker(
          // Customize your marker here
          point: LatLng(51.5, -0.09), // Marker position
          builder: (BuildContext context) {
            return MarkerWidget(); // Your custom marker widget
          },
          popupBuilder: (BuildContext context, CustomMarker marker) {
            return MyCustomPopup(marker.data); // Your custom popup widget
          },
          data: MyMarkerData(/* Your data here */),
        ),
        // Add more markers as needed
      ],
    ),
  ],
)

```

For a complete example which demonstrates all of the various options available try running the demo app in the `example/` directory which results in the following:

![Example](https://raw.githubusercontent.com/ymrabti/fluttermap_markerpopup/main/screenshot.png)

## FAQ

* Why is the popup not showing when I long press the marker?

  Make sure you don't have a GestureDetector in your Marker's builder which is preventing this plugin from detecting the Marker long press.

"# longpress_popup"

## Contributing
Contributions to this package are welcome! Feel free to open issues or pull requests to suggest improvements or report bugs.

## License
This project is licensed under the MIT License - see the [LICENSE.md](/LICENSE) file for details.

## Acknowledgments
- Mention any contributors or libraries used in this package.
- Provide links to relevant resources or tutorials.


Please make sure to customize this Markdown text with your specific package details and replace placeholders accordingly.

## 🔗 More Packages

- [Power Geojson](https://pub.dev/packages/power_geojson)
- [Popup Menu 2](https://pub.dev/packages/popup_menu_2)
- [Flutter Azimuth](https://pub.dev/packages/flutter_azimuth)
- [Simple Logger](https://pub.dev/packages/console_tools)

---

## 👨‍💻 Developer Card

<div align="center">
    <img src="https://avatars.githubusercontent.com/u/47449165?v=4" alt="Younes M'rabti avatar" width="120" height="120" style="border-radius: 50%;" />

### Younes M'rabti

📧 Email: [admin@youmti.net](mailto:admin@youmti.net)  
🌐 Website: [youmti.net](https://www.youmti.net/)  
💼 LinkedIn: [younesmrabti1996](https://www.linkedin.com/in/younesmrabti1996/)
</div>
