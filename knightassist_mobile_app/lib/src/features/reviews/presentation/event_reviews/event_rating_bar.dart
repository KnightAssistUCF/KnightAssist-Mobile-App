import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class EventRatingBar extends StatelessWidget {
  const EventRatingBar({
    super.key,
    this.initialRating = 0.0,
    this.itemSize = 40,
    this.ignoreGestures = false,
    required this.onRatingUpdate,
  });

  final double initialRating;
  final double itemSize;
  final bool ignoreGestures;
  final ValueChanged<double> onRatingUpdate;

  static Key starRatingKey(int index) => Key('starts-$index');

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: initialRating,
      ignoreGestures: ignoreGestures,
      glow: false,
      allowHalfRating: false,
      itemSize: itemSize,
      itemBuilder: (context, index) => Icon(
        Icons.star,
        key: starRatingKey(index),
        color: Colors.amber,
      ),
      onRatingUpdate: onRatingUpdate,
    );
  }
}
