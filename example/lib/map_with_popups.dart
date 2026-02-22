import 'package:longpress_popup/extension_api.dart';
import 'package:longpress_popup_example/example_popup_with_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:longpress_popup/fluttermap_markerpopup.dart';
import 'package:latlong2/latlong.dart';

import 'example_popup.dart';

class MapWithPopups extends StatefulWidget {
  final PopupSnap snap;
  final bool rotate;
  final bool fade;
  final Alignment? markerAnchorPoint;
  final bool showMultiplePopups;

  const MapWithPopups({
    required this.snap,
    required this.rotate,
    required this.fade,
    this.markerAnchorPoint,
    required this.showMultiplePopups,
    Key? key,
  }) : super(key: key);

  @override
  State<MapWithPopups> createState() => _MapWithPopupsState();
}

class _MapWithPopupsState extends State<MapWithPopups> {
  late List<MarkerData> _markers;

  /// Used to trigger showing/hiding of popups.
  final PopupController _popupLayerController = PopupController();

  @override
  void initState() {
    super.initState();

    _markers = _buildMarkers();
  }

  @override
  void didUpdateWidget(covariant MapWithPopups oldWidget) {
    super.didUpdateWidget(oldWidget);

    final List<MarkerData> selectedMarkers =
        _popupLayerController.selectedMarkers;
    if (widget.markerAnchorPoint != oldWidget.markerAnchorPoint) {
      setState(() {
        _markers = _buildMarkers();
      });

      /// When changing the Markers we should hide the old popup if the Markers
      /// might have changed in such a way that the popup should change (e.g.
      /// anchor point change). If we can match one of the new Markers to the
      /// old Marker that had the popup then we can show the popup for that
      /// Marker.
      final Iterable<MarkerData> matchingMarkers = _markers.where(
        (MarkerData marker) => selectedMarkers.any(
          (MarkerData selectedMarker) =>
              marker.marker.point == selectedMarker.marker.point,
        ),
      );

      if (matchingMarkers.isNotEmpty) {
        _popupLayerController.showPopupsOnlyFor(
          matchingMarkers.toList(),
          disableAnimation: true,
        );
      } else {
        _popupLayerController.hideAllPopups(disableAnimation: true);
      }
    }

    /// If we change to show only one popup at a time we should hide all popups
    /// apart from the first one.
    if (!widget.showMultiplePopups && oldWidget.showMultiplePopups) {
      final Iterable<MarkerData> matchingMarkers = _markers.where(
        (MarkerData marker) => selectedMarkers.any(
          (MarkerData selectedMarker) =>
              marker.marker.point == selectedMarker.marker.point,
        ),
      );

      if (matchingMarkers.length > 1) {
        _popupLayerController.showPopupsOnlyFor(<MarkerData>[
          matchingMarkers.first,
        ]);
      }
    }
  }

  List<MarkerData> _buildMarkers() {
    return <Marker>[
      Marker(
        point: LatLng(44.421, 10.404),
        width: 52,
        height: 52,
        child: const _ImageMarker(assetPath: 'assets/branding/logo.jpg'),
        alignment: widget.markerAnchorPoint,
      ),
      Marker(
        point: LatLng(45.683, 10.839),
        width: 52,
        height: 52,
        child: const _ImageMarker(assetPath: 'assets/branding/logo-mono.jpg'),
        alignment: widget.markerAnchorPoint,
      ),
      Marker(
        point: LatLng(45.246, 5.783),
        width: 52,
        height: 52,
        child: const _ImageMarker(assetPath: 'assets/branding/logo-simple.jpg'),
        alignment: widget.markerAnchorPoint,
      ),
    ].map((Marker e) => DataMarker(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialZoom: 5.0,
        initialCenter: LatLng(44.421, 10.404),
        onTap: (_, __) => _popupLayerController.hideAllPopups(),
      ),
      children: <Widget>[
        //https://{s}.basemaps.cartocdn.com/dark_nolabels/{z}/{x}/{y}{r}.png
        TileLayer(
          urlTemplate:
              'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}@2x.png',
          subdomains: <String>['a', 'b', 'c'],
          retinaMode: true,
        ),
        PopupMarkerLayerWidget(
          options: PopupMarkerLayerOptions(
            markerCenterAnimation: const MarkerCenterAnimation(),
            markersData: _markers,
            popupSnap: widget.snap,
            popupController: _popupLayerController,
            popupBuilder: (BuildContext context, MarkerData marker) =>
                ExamplePopup(marker),
            markerRotate: widget.rotate,
            markerRotateAlignment: widget.markerAnchorPoint,
            popupAnimation: widget.fade
                ? const PopupAnimation.fade(
                    duration: Duration(milliseconds: 700),
                  )
                : null,
            markerLongPressBehavior: widget.showMultiplePopups
                ? MarkerLongPressBehavior.togglePopup()
                : MarkerLongPressBehavior.togglePopupAndHideRest(),
            onPopupEvent: (PopupEvent event, List<MarkerData> selectedMarkers) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(event.runtimeType.toString()),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ImageMarker extends StatelessWidget {
  const _ImageMarker({required this.assetPath});

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(assetPath, fit: BoxFit.cover),
      ),
    );
  }
}
