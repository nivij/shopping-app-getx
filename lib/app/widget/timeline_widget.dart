import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gocart/app/widget/EventCard.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Mytimeline extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final child;
  final child2;
  const Mytimeline({super.key, required this.isFirst, required this.isLast, required this.isPast,required this.child,required this.child2});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,

        beforeLineStyle: LineStyle(color: isPast? Theme.of(context).colorScheme.secondary : Colors.grey.shade600),
        indicatorStyle: IndicatorStyle(width: 27,
            color:isPast? Theme.of(context).colorScheme.secondary : Colors.grey.shade600,
        iconStyle: IconStyle(iconData: Icons.done,
        color: isPast ? Theme.of(context).colorScheme.primary: Colors.grey.shade600
        )),
        endChild: EventCard(isPast: isPast,child: child,child2:child2),
      ),
    );
  }
}
