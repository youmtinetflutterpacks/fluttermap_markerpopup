import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

import 'popup_layout.dart';

abstract class SnapToMapLayout {
  static PopupLayout left(MapCamera mapState) {
    return _layoutWith(
      contentAlignment: Alignment.centerLeft,
      mapRotationRad: mapState.rotationRad,
      translateX: _sizeChangeDueToRotation(mapState).dx / 2,
    );
  }

  static PopupLayout top(MapCamera mapState) {
    return _layoutWith(
      contentAlignment: Alignment.topCenter,
      mapRotationRad: mapState.rotationRad,
      translateY: _sizeChangeDueToRotation(mapState).dy / 2,
    );
  }

  static PopupLayout right(MapCamera mapState) {
    return _layoutWith(
      contentAlignment: Alignment.centerRight,
      mapRotationRad: mapState.rotationRad,
      translateX: -_sizeChangeDueToRotation(mapState).dx / 2,
    );
  }

  static PopupLayout bottom(MapCamera mapState) {
    return _layoutWith(
      contentAlignment: Alignment.bottomCenter,
      mapRotationRad: mapState.rotationRad,
      translateY: -_sizeChangeDueToRotation(mapState).dy / 2,
    );
  }

  static PopupLayout center(MapCamera mapState) {
    return _layoutWith(
      contentAlignment: Alignment.center,
      mapRotationRad: mapState.rotationRad,
    );
  }

  static Offset _sizeChangeDueToRotation(MapCamera mapState) {
    return Offset(
      mapState.size.width - mapState.nonRotatedSize.width,
      mapState.size.height - mapState.nonRotatedSize.height,
    );
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
        ..translateByVector3(Vector3(translateX, translateY, 0.0)),
    );
  }
}
