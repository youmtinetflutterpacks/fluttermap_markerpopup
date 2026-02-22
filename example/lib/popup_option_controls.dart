import 'package:flutter/material.dart';
import 'package:longpress_popup/extension_api.dart';

import 'map_with_popups.dart';

class PopupOptionControls extends StatefulWidget {
  const PopupOptionControls({Key? key}) : super(key: key);

  @override
  State<PopupOptionControls> createState() => _PopupOptionControlsState();
}

class _PopupOptionControlsState extends State<PopupOptionControls> {
  static const List<Alignment> alignments = <Alignment>[Alignment.centerLeft, Alignment.topCenter, Alignment.centerRight, Alignment.bottomCenter, Alignment.center];

  bool rotate = true;
  bool fade = true;
  bool snapToMarker = true;
  Alignment popupAlignment = alignments[1];
  Alignment anchorAlignment = alignments[1];
  bool showMultiplePopups = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Marker Popup Demo'), centerTitle: true),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  clipBehavior: Clip.antiAlias,
                  child: MapWithPopups(snap: _popupSnap, rotate: rotate, fade: fade, markerAnchorPoint: anchorAlignment, showMultiplePopups: showMultiplePopups),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(20)),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Display', style: theme.textTheme.titleMedium),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: <Widget>[
                        FilterChip(avatar: const Icon(Icons.my_location, size: 18), label: const Text('Snap to Marker'), selected: snapToMarker, onSelected: (bool selected) => setState(() => snapToMarker = selected)),
                        FilterChip(avatar: const Icon(Icons.rotate_right, size: 18), label: const Text('Rotate'), selected: rotate, onSelected: (bool selected) => setState(() => rotate = selected)),
                        FilterChip(avatar: const Icon(Icons.auto_awesome, size: 18), label: const Text('Fade'), selected: fade, onSelected: (bool selected) => setState(() => fade = selected)),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text('Popup snap', style: theme.textTheme.titleMedium),
                    const SizedBox(height: 10),
                    SegmentedButton<Alignment>(
                      showSelectedIcon: false,
                      segments: const <ButtonSegment<Alignment>>[
                        ButtonSegment<Alignment>(value: Alignment.centerLeft, icon: Icon(Icons.west), tooltip: 'Left'),
                        ButtonSegment<Alignment>(value: Alignment.topCenter, icon: Icon(Icons.north), tooltip: 'Top'),
                        ButtonSegment<Alignment>(value: Alignment.centerRight, icon: Icon(Icons.east), tooltip: 'Right'),
                        ButtonSegment<Alignment>(value: Alignment.bottomCenter, icon: Icon(Icons.south), tooltip: 'Bottom'),
                        ButtonSegment<Alignment>(value: Alignment.center, icon: Icon(Icons.center_focus_strong), tooltip: 'Center'),
                      ],
                      selected: <Alignment>{popupAlignment},
                      onSelectionChanged: (Set<Alignment> selected) {
                        setState(() {
                          popupAlignment = selected.first;
                        });
                      },
                    ),
                    const SizedBox(height: 18),
                    Text('Marker anchor', style: theme.textTheme.titleMedium),
                    const SizedBox(height: 10),
                    SegmentedButton<Alignment>(
                      showSelectedIcon: false,
                      segments: const <ButtonSegment<Alignment>>[
                        ButtonSegment<Alignment>(value: Alignment.centerLeft, icon: Icon(Icons.west), tooltip: 'Left'),
                        ButtonSegment<Alignment>(value: Alignment.topCenter, icon: Icon(Icons.north), tooltip: 'Top'),
                        ButtonSegment<Alignment>(value: Alignment.centerRight, icon: Icon(Icons.east), tooltip: 'Right'),
                        ButtonSegment<Alignment>(value: Alignment.bottomCenter, icon: Icon(Icons.south), tooltip: 'Bottom'),
                        ButtonSegment<Alignment>(value: Alignment.center, icon: Icon(Icons.center_focus_strong), tooltip: 'Center'),
                      ],
                      selected: <Alignment>{anchorAlignment},
                      onSelectionChanged: (Set<Alignment> selected) {
                        setState(() {
                          anchorAlignment = selected.first;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    SwitchListTile.adaptive(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Show multiple popups'),
                      subtitle: const Text('Keep previous popups open when selecting another marker.'),
                      value: showMultiplePopups,
                      onChanged: (bool newValue) {
                        setState(() {
                          showMultiplePopups = newValue;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PopupSnap get _popupSnap {
    if (snapToMarker) {
      return <Alignment, PopupSnap>{Alignment.centerLeft: PopupSnap.markerLeft, Alignment.topCenter: PopupSnap.markerTop, Alignment.centerRight: PopupSnap.markerRight, Alignment.bottomCenter: PopupSnap.markerBottom, Alignment.center: PopupSnap.markerCenter}[popupAlignment]!;
    } else {
      return <Alignment, PopupSnap>{Alignment.centerLeft: PopupSnap.mapLeft, Alignment.topCenter: PopupSnap.mapTop, Alignment.centerRight: PopupSnap.mapRight, Alignment.bottomCenter: PopupSnap.mapBottom, Alignment.center: PopupSnap.mapCenter}[popupAlignment]!;
    }
  }
}
