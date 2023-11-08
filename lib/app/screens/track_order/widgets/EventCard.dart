import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final bool isPast;
  final child;
  final child2;
  const EventCard({super.key, required this.isPast, required this.child, required this.child2});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isPast? Theme.of(context).colorScheme.secondary : Colors.grey.shade600,
          ),
          child: child
        ),
        Visibility(
          visible: isPast, // Show child2 only if isPast is true
          child: child2,
        ),
      ],
    );

  }
}
