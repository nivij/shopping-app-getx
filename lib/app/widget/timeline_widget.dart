import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gocart/app/widget/EventCard.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Mytimeline extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final child;
  const Mytimeline({super.key, required this.isFirst, required this.isLast, required this.isPast,required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,

        beforeLineStyle: LineStyle(color: isPast? Colors.white : Colors.grey.shade600),
        indicatorStyle: IndicatorStyle(color:isPast? Colors.white : Colors.grey.shade600,
        iconStyle: IconStyle(iconData: Icons.done,
        color: isPast ? Colors.black : Colors.grey.shade600
        )),
        endChild: EventCard(isPast: isPast,child: child),
      ),
    );
  }
}
