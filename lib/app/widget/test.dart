import 'package:flutter/material.dart';

class CustomRatingBar extends StatefulWidget {
  final int maxRating;
  final double initialRating;
  final Function(double) onRatingChanged;

  CustomRatingBar({
    required this.maxRating,
    required this.initialRating,
    required this.onRatingChanged,
  });

  @override
  _CustomRatingBarState createState() => _CustomRatingBarState();
}

class _CustomRatingBarState extends State<CustomRatingBar> {
  double _currentRating = 0.0;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  void _updateRating(double newRating) {
    setState(() {
      _currentRating = newRating;
    });
    widget.onRatingChanged(_currentRating);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.maxRating, (index) {
        return GestureDetector(
          onTap: () {
            _updateRating(index + 1.0);
          },
          child: SizedBox(

            child: Icon(
              _currentRating >= index + 1
                  ? Icons.star
                  : _currentRating > index
                  ? Icons.star_half
                  : Icons.star_border,
              size: 18,
              color: Colors.amber, // Change the color to your desired color
            ),
          ),
        );
      }),
    );
  }
}

