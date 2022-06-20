import 'package:flutter/cupertino.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:fluttermap_markerpopup/src/marker_tap_behavior.dart';
import 'package:fluttermap_markerpopup/src/markerdata.dart';
import 'package:fluttermap_markerpopup/src/popup_animation.dart';
import 'package:fluttermap_markerpopup/src/popup_builder.dart';
import 'package:fluttermap_markerpopup/src/popup_controller.dart';
import 'package:fluttermap_markerpopup/src/popup_snap.dart';

import 'marker_center_animation.dart';
import 'popup_event.dart';

class PopupMarkerLayerOptions extends MarkerLayerOptions {
  /// Used to construct the popup.
  final PopupBuilder popupBuilder;
  final Function(MarkerData)? onTap;

  /// If a PopupController is provided it can be used to programmatically show
  /// and hide the popup.
  final PopupController? popupController;

  /// Controls the position of the popup relative to the marker or popup.
  final PopupSnap popupSnap;

  /// Allows the use of an animation for showing/hiding popups. Defaults to no
  /// animation.
  final PopupAnimation? popupAnimation;

  /// Setting a [MarkerCenterAnimation] will cause the map to be centered on
  /// a marker when it is tapped. Defaults to not centering on the marker.
  final MarkerCenterAnimation? markerCenterAnimation;

  final MarkerTapBehavior markerTapBehavior;

  final Function(PopupEvent event, List<MarkerData> selectedMarkers)? onPopupEvent;

  List<MarkerData> markersData = const [];
  PopupMarkerLayerOptions({
    required this.popupBuilder,
    AlignmentGeometry? markerRotateAlignment,
    MarkerTapBehavior? markerTapBehavior,
    Offset? markerRotateOrigin,
    bool? markerRotate = true,
    Stream<void>? rebuild,
    this.popupSnap = PopupSnap.markerTop,
    this.markersData = const [],
    this.markerCenterAnimation,
    this.popupController,
    this.popupAnimation,
    this.onPopupEvent,
    this.onTap,
  })  : markerTapBehavior = markerTapBehavior ?? MarkerTapBehavior.togglePopupAndHideRest(),
        super(
          markers: markersData.map((e) => e.marker).toList(),
          rotate: markerRotate,
          rotateAlignment: markerRotateAlignment,
          rotateOrigin: markerRotateOrigin,
          rebuild: rebuild,
        );

  static AlignmentGeometry rotationAlignmentFor(AnchorAlign anchorAlign) {
    switch (anchorAlign) {
      case AnchorAlign.left:
        return Alignment.centerRight;
      case AnchorAlign.top:
        return Alignment.bottomCenter;
      case AnchorAlign.right:
        return Alignment.centerLeft;
      case AnchorAlign.bottom:
        return Alignment.topCenter;
      case AnchorAlign.center:
      case AnchorAlign.none:
        return Alignment.center;
    }
  }
}
