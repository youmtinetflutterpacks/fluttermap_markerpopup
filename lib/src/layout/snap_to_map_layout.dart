import 'package:flutter/widgets.dart';
import 'package:flutter_map/plugin_api.dart';

import 'popup_layout.dart';

abstract class SnapToMapLayout {
  static PopupLayout left(FlutterMapState mapState) {
    return _layoutWith(
      contentAlignment: Alignment.centerLeft,
      mapRotationRad: mapState.rotationRad,
      translateX: _sizeChangeDueToRotation(mapState).x / 2,
    );
  }

  static PopupLayout top(FlutterMapState mapState) {
    return _layoutWith(
      contentAlignment: Alignment.topCenter,
      mapRotationRad: mapState.rotationRad,
      translateY: _sizeChangeDueToRotation(mapState).y / 2,
    );
  }

  static PopupLayout right(FlutterMapState mapState) {
    return _layoutWith(
      contentAlignment: Alignment.centerRight,
      mapRotationRad: mapState.rotationRad,
      translateX: -_sizeChangeDueToRotation(mapState).x / 2,
    );
  }

  static PopupLayout bottom(FlutterMapState mapState) {
    return _layoutWith(
      contentAlignment: Alignment.bottomCenter,
      mapRotationRad: mapState.rotationRad,
      translateY: -_sizeChangeDueToRotation(mapState).y / 2,
    );
  }

  static PopupLayout center(FlutterMapState mapState) {
    return _layoutWith(
      contentAlignment: Alignment.center,
      mapRotationRad: mapState.rotationRad,
    );
  }

  static CustomPoint<num> _sizeChangeDueToRotation(FlutterMapState mapState) {
    final CustomPoint<num> size = mapState.size;
    return size - (mapState.size);
  }

  static PopupLayout _layoutWith({
    required Alignment contentAlignment,
    required double mapRotationRad,
    double translateX = 0.0,
    double translateY = 0.0,
  }) {
    return PopupLayout(
      contentAlignment: contentAlignment,
      rotationAlignment: Alignment.center,
      transformationMatrix: Matrix4.identity()
        ..rotateZ(-mapRotationRad)
        ..translate(translateX, translateY),
    );
  }
}
