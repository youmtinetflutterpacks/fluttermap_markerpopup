import 'package:flutter/material.dart';
import 'package:longpress_popup/extension_api.dart';

import 'map_with_popups.dart';

class PopupOptionControls extends StatefulWidget {
  const PopupOptionControls({Key? key}) : super(key: key);

  @override
  State<PopupOptionControls> createState() => _PopupOptionControlsState();
}

class _PopupOptionControlsState extends State<PopupOptionControls> {
  static const List<AlignmentGeometry> alignments = <AlignmentGeometry>[
    //
    Alignment.centerLeft, Alignment.topCenter, Alignment.centerRight, Alignment.bottomCenter, Alignment.center,
  ];

  bool rotate = true;
  bool fade = true;
  bool snapToMarker = true;
  AlignmentGeometry popupAlignment = alignments[1];
  AlignmentGeometry anchorAlignment = alignments[1];
  bool showMultiplePopups = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: MapWithPopups(snap: _popupSnap, rotate: rotate, fade: fade, showMultiplePopups: showMultiplePopups),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ToggleButtons(
                  textStyle: const TextStyle(fontSize: 16),
                  isSelected: <bool>[snapToMarker, rotate, fade],
                  onPressed: (int index) {
                    setState(() {
                      if (index == 0) snapToMarker = !snapToMarker;
                      if (index == 1) rotate = !rotate;
                      if (index == 2) fade = !fade;
                    });
                  },
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: const <Widget>[Icon(Icons.messenger), Text(' Snap to Marker')]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: const <Widget>[Icon(Icons.rotate_right), Text(' Rotate')]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: const <Widget>[Icon(Icons.animation), Text(' Fade')]),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('\nPopup snap ', style: TextStyle(fontSize: 18)),
                    ToggleButtons(
                      isSelected: List<bool>.generate(alignments.length, (int index) => popupAlignment == alignments[index]),
                      onPressed: (int index) {
                        setState(() {
                          popupAlignment = alignments[index];
                        });
                      },
                      children: <IconData>[Icons.arrow_back, Icons.arrow_upward, Icons.arrow_forward, Icons.arrow_downward, Icons.filter_center_focus_rounded].map((IconData icon) => Padding(padding: const EdgeInsets.all(8.0), child: Icon(icon))).toList(),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('\nMarker Anchor', style: TextStyle(fontSize: 18)),
                    ToggleButtons(
                      isSelected: List<bool>.generate(alignments.length, (int index) => anchorAlignment == alignments[index]),
                      onPressed: (int index) {
                        setState(() {
                          anchorAlignment = alignments[index];
                        });
                      },
                      children: <IconData>[Icons.arrow_back, Icons.arrow_upward, Icons.arrow_forward, Icons.arrow_downward, Icons.filter_center_focus_rounded].map((IconData icon) => Padding(padding: const EdgeInsets.all(8.0), child: Icon(icon))).toList(),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('\nShow multiple', style: TextStyle(fontSize: 18)),
                    Switch(
                      value: showMultiplePopups,
                      onChanged: (bool newValue) {
                        setState(() {
                          showMultiplePopups = newValue;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PopupSnap get _popupSnap {
    if (snapToMarker) {
      return <AlignmentGeometry, PopupSnap>{Alignment.centerLeft: PopupSnap.markerLeft, Alignment.topCenter: PopupSnap.markerTop, Alignment.centerRight: PopupSnap.markerRight, Alignment.bottomCenter: PopupSnap.markerBottom, Alignment.center: PopupSnap.markerCenter}[popupAlignment]!;
    } else {
      return <AlignmentGeometry, PopupSnap>{Alignment.centerLeft: PopupSnap.mapLeft, Alignment.topCenter: PopupSnap.mapTop, Alignment.centerRight: PopupSnap.mapRight, Alignment.bottomCenter: PopupSnap.mapBottom, Alignment.center: PopupSnap.mapCenter}[popupAlignment]!;
    }
  }
}
