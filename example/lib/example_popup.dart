import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longpress_popup/fluttermap_markerpopup.dart';

class ExamplePopup extends StatefulWidget {
  final MarkerData marker;

  const ExamplePopup(this.marker, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExamplePopupState();
}

class _ExamplePopupState extends State<ExamplePopup> {
  final List<IconData> _icons = <IconData>[Icons.star_border, Icons.star_half, Icons.star];
  int _currentIcon = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => setState(() {
          _currentIcon = (_currentIcon + 1) % _icons.length;
        }),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 12, right: 10),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: theme.colorScheme.primary.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(10)),
              child: Icon(_icons[_currentIcon], color: theme.colorScheme.primary),
            ),
            _cardDescription(context),
          ],
        ),
      ),
    );
  }

  Widget _cardDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Popup marker',
              overflow: TextOverflow.fade,
              softWrap: false,
              style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 6),
            Text('Position: ${widget.marker.marker.point.latitude.toStringAsFixed(3)}, ${widget.marker.marker.point.longitude.toStringAsFixed(3)}', style: GoogleFonts.jetBrainsMono(fontSize: 11.5, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8))),
            Text('Size: ${widget.marker.marker.width.toInt()} × ${widget.marker.marker.height.toInt()}', style: GoogleFonts.jetBrainsMono(fontSize: 11.5, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8))),
          ],
        ),
      ),
    );
  }
}
