import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart' as flutter_map;
import 'package:longpress_popup/src/popup_layer.dart';

import '../fluttermap_markerpopup.dart';
import 'marker_layer.dart';
import 'popup_controller_impl.dart';

class PopupMarkerLayerWidget extends StatefulWidget {
  final PopupMarkerLayerOptions options;

  PopupMarkerLayerWidget({required this.options}) : super(key: options.key);

  @override
  State<PopupMarkerLayerWidget> createState() => _PopupMarkerLayerWidgetState();
}

class _PopupMarkerLayerWidgetState extends State<PopupMarkerLayerWidget> {
  late final PopupControllerImpl _popupController;

  @override
  void initState() {
    super.initState();
    _popupController = widget.options.popupController == null
        ? PopupControllerImpl()
        : widget.options.popupController as PopupControllerImpl;
  }

  @override
  Widget build(BuildContext context) {
    final flutter_map.MapCamera mapState = flutter_map.MapCamera.maybeOf(
      context,
    )!;
    return Stack(
      children: <Widget>[
        MarkerLayer(
          //
          widget.options,
          mapState,
          null,
          _popupController,
          mapController: flutter_map.MapController.maybeOf(context)!,
        ),
        PopupLayer(
          mapState: mapState,
          // stream: mapState.onMoved,
          popupSnap: widget.options.popupSnap,
          popupBuilder: widget.options.popupBuilder,
          popupController: _popupController,
          popupAnimation: widget.options.popupAnimation,
          markerRotate: widget.options.rotate,
          onPopupEvent: widget.options.onPopupEvent,
        ),
      ],
    );
  }
}
