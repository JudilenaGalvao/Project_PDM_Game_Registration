import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomRatingBar extends StatelessWidget {

  final void Function(double) ratingFunction;

  const CustomRatingBar({
    super.key, required this.ratingFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RatingBar(
        minRating: 0,
        maxRating: 5,
        initialRating: 0,
        allowHalfRating: true,
        onRatingUpdate: ratingFunction,
        updateOnDrag: true,
        ratingWidget: RatingWidget(
          full: Icon(
            Icons.star,
            color: Theme.of(context).colorScheme.primary,
          ),
          empty: const Icon(
            Icons.star,
            color: Colors.grey,
          ),
          half: Icon(
            Icons.star_half,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}