import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' hide LatLngTween;
import 'package:latlong2/latlong.dart';

import '../fluttermap_markerpopup.dart';
import 'lat_lng_tween.dart';
import 'popup_controller_impl.dart';

class MarkerLayer extends StatefulWidget {
  final PopupMarkerLayerOptions layerOptions;
  final MapCamera map;
  final MapController mapController;
  final Stream<void>? stream;
  final PopupControllerImpl popupController;

  const MarkerLayer(
    //
    this.layerOptions,
    this.map,
    this.stream,
    this.popupController, {
    required this.mapController,
    Key? key,
  }) : super(key: key);

  @override
  State<MarkerLayer> createState() => _MarkerLayerState();
}

class _MarkerLayerState extends State<MarkerLayer> with SingleTickerProviderStateMixin {
  double lastZoom = -1.0;

  /// List containing cached pixel positions of markers
  /// Should be discarded when zoom changes
  // Has a fixed length of markerOpts.markers.length - better performance:
  // https://stackoverflow.com/questions/15943890/is-there-a-performance-benefit-in-using-fixed-length-lists-in-dart
  List<Offset> _pxCache = <Offset>[];

  late AnimationController _centerMarkerController;
  void Function()? _animationListener;

  // Calling this every time markerOpts change should guarantee proper length
  List<Offset> generatePxCache() => List<Offset>.generate(widget.layerOptions.markers.length, (int i) => widget.map.projectAtZoom(widget.layerOptions.markers[i].point, widget.map.zoom));

  @override
  void initState() {
    super.initState();
    _pxCache = generatePxCache();
    _centerMarkerController = AnimationController(vsync: this, duration: widget.layerOptions.markerCenterAnimation?.duration);
  }

  @override
  void didUpdateWidget(covariant MarkerLayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    lastZoom = -1.0;
    _pxCache = generatePxCache();
    _centerMarkerController.duration = widget.layerOptions.markerCenterAnimation?.duration;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<void>(
      stream: widget.stream,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        List<Widget> markers = <Widget>[];
        final bool sameZoom = widget.map.zoom == lastZoom;
        PopupMarkerLayerOptions layerOptions = widget.layerOptions;
        List<MarkerData> pins = layerOptions.markersData;
        for (int i = 0; i < pins.length; i++) {
          MarkerData pin = pins[i];

          final double left = 0.5 * pin.marker.width * ((pin.marker.alignment ?? Alignment.center).x + 1);
          final double top = 0.5 * pin.marker.height * ((pin.marker.alignment ?? Alignment.center).y + 1);
          final double right = pin.marker.width - left;
          final double bottom = pin.marker.height - top;
          // Decide whether to use cached point or calculate it
          Offset pxPoint = sameZoom ? _pxCache[i] : widget.map.projectAtZoom(pin.marker.point, widget.map.zoom);
          if (!sameZoom) {
            _pxCache[i] = pxPoint;
          }

          final double width = pin.marker.width - pin.marker.width;
          final double height = pin.marker.height - pin.marker.height;
          /* var sw = Offset(pxPoint.dx + width, pxPoint.dy - height);
          var ne = Offset(pxPoint.dx - width, pxPoint.dy + height);

          TODO var rect = Rect.fromPoints(
                sw,
                ne,
              ); */
          if (!widget.map.pixelBounds.overlaps(Rect.fromPoints(Offset(pxPoint.dx + left, pxPoint.dy - bottom), Offset(pxPoint.dx - right, pxPoint.dy + top)))) {
            continue;
          }

          final Offset pos = pxPoint - widget.map.getNewPixelOrigin(widget.map.center, widget.map.zoom);

          final InkWell interactiveMarker = InkWell(
            onLongPress: () {
              List<MarkerData> seleers2 = widget.popupController.selectedMarkers;
              if (!seleers2.contains(pin)) {
                _centerMarker(pin.marker);
              }

              widget.layerOptions.markerLongPressBehavior.apply(pin, widget.popupController);
            },
            onTap: () {
              Function(MarkerData)? onTap2 = widget.layerOptions.onTap;
              if (onTap2 != null) {
                onTap2(pin);
              }
            },
            child: pin.marker.child,
          );

          final bool markerRotate = widget.layerOptions.rotate;

          Widget markerWidget;
          if (pin.marker.rotate ?? markerRotate) {
            final Offset markerRotateOrigin = Offset(pin.marker.width / 2, pin.marker.height / 2);

            // Counter rotated marker to the map rotation
            markerWidget = Transform.rotate(
              //
              angle: -widget.map.rotationRad,
              origin: markerRotateOrigin,
              alignment: pin.marker.alignment ?? widget.layerOptions.alignment,
              child: interactiveMarker,
            );
          } else {
            markerWidget = interactiveMarker;
          }

          markers.add(
            //
            Positioned(
              //
              key: pin.marker.key,
              width: pin.marker.width,
              height: pin.marker.height,
              left: pos.dx - width,
              top: pos.dy - height,
              child: markerWidget,
            ),
          );
        }
        lastZoom = widget.map.zoom;

        return Stack(children: markers);
      },
    );
  }

  void _centerMarker(Marker marker) {
    final MarkerCenterAnimation? markerLayerAnimation = widget.layerOptions.markerCenterAnimation;
    if (markerLayerAnimation == null) return;

    final LatLng center = widget.map.center;
    final LatLngTween tween = LatLngTween(begin: center, end: marker.point);

    Animation<double> animation = CurvedAnimation(parent: _centerMarkerController, curve: markerLayerAnimation.curve);

    void listener() {
      widget.mapController.move(tween.evaluate(animation), widget.map.zoom);
    }

    _centerMarkerController.removeListener(_animationListener ?? () {});
    _centerMarkerController.reset();
    _animationListener = listener;

    _centerMarkerController.addListener(listener);
    _centerMarkerController.forward().then((_) {
      _centerMarkerController
        ..removeListener(listener)
        ..reset();
      _animationListener = null;
    });
  }

  @override
  void dispose() {
    _centerMarkerController.dispose();
    super.dispose();
  }
}
