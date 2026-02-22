import 'package:flutter/material.dart';

/// Relative alignment for a [Marker.builder] widget relative to the center
/// of its bounding box defined by its [Marker.height] & [Marker.width]
enum AnchorAlign {
  topLeft(-1, 1),
  topRight(1, 1),
  bottomLeft(-1, -1),
  bottomRight(1, -1),

  center(0, 0),

  /// Top center
  top(0, 1),

  /// Bottom center
  bottom(0, -1),

  /// Left center
  left(-1, 0),

  /// Right center
  right(1, 0),

  @Deprecated(
    'Prefer `center`. '
    'This value is equivalent to the `center` alignment. '
    'If you notice a difference in behaviour, please open a bug report on GitHub. '
    'This feature is deprecated since v5.',
  )
  none(0, 0);

  final int _x;
  final int _y;

  const AnchorAlign(this._x, this._y);
}

class Anchor {
  final double left;
  final double top;

  Anchor(this.left, this.top);

  factory Anchor.fromPos(AnchorPos pos, double width, double height) {
    if (pos.anchor case final Anchor anchor?) return anchor;
    if (pos.alignment case final AnchorAlign alignment?) {
      return Anchor(
        switch (alignment._x) {
          -1 => 0,
          1 => width,
          _ => width / 2,
        },
        switch (alignment._y) {
          1 => 0,
          -1 => height,
          _ => height / 2,
        },
      );
    }
    throw Exception();
  }
}

/// Defines the positioning of a [Marker.builder] widget relative to the center
/// of its bounding box defined by its [Marker.height] & [Marker.width]
///
/// Can be defined exactly (using [AnchorPos.exactly] with an [Anchor]) or in
/// a relative alignment (using [AnchorPos.align] with an [AnchorAlign]).
class AnchorPos {
  final Anchor? anchor;
  final Alignment? alignment;

  AnchorPos.exactly(Anchor this.anchor) : alignment = null;
  AnchorPos.align(Alignment this.alignment) : anchor = null;
}
