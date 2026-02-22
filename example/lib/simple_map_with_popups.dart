import 'package:longpress_popup/extension_api.dart';
import 'package:longpress_popup_example/example_popup_with_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:longpress_popup/fluttermap_markerpopup.dart';
import 'package:latlong2/latlong.dart';

import 'example_popup.dart';

class SimpleMapWithPopups extends StatelessWidget {
  final List<LatLng> _markerPositions = <LatLng>[
    LatLng(44.421, 10.404),
    LatLng(45.683, 10.839),
    LatLng(45.246, 5.783),
  ];

  /// Used to trigger showing/hiding of popups.
  final PopupController _popupLayerController = PopupController();

  SimpleMapWithPopups({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialZoom: 5.0,
        initialCenter: LatLng(44.421, 10.404),
        onTap: (_, __) => _popupLayerController
            .hideAllPopups(), // Hide popup when the map is tapped.
      ),
      children: <Widget>[
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: <String>['a', 'b', 'c'],
        ),
        PopupMarkerLayerWidget(
          options: PopupMarkerLayerOptions(
            //
            popupController: _popupLayerController,
            markersData: _markers,
            markerRotateAlignment: PopupMarkerLayerOptions.rotationAlignmentFor(
              AnchorAlign.top,
            ),
            popupBuilder: (BuildContext context, MarkerData marker) =>
                ExamplePopup(marker),
          ),
        ),
      ],
    );
  }

  List<MarkerData> get _markers {
    return _markerPositions.map(
      //
      (LatLng markerPosition) {
        return DataMarker(
          //
          Marker(
            //
            point: markerPosition,
            width: 40,
            height: 40,
            child: Icon(Icons.location_on, size: 40),
          ),
        );
      },
    ).toList();
  }
}
